package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsViewDao;
import com.heeexy.example.dao.OrderDao;
import com.heeexy.example.service.OrderService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private GoodsViewDao goodsViewDao;

    /**
     * 判断购买数量numbers是否大于等于1,小于等于商品库存
     * 判断商品是否有效
     * 判断商品是否为上架状态
     * 判断用户账号是否有足够资金划扣
     *
     * @return*/
    @Override
    @Transactional
    public JSONObject buyOneType(JSONObject requestJson) {
        Integer numbers = requestJson.getInteger("numbers");
        if(numbers<1){//购买数量是否大于0
            return CommonUtil.errorJson(ErrorEnum.E_40001);}
        JSONObject goodsInfo =
                goodsViewDao.getGoodsInfoById(requestJson.getLong("goodsId"));
        if(goodsInfo.getString("goodsName")==null){//商品有效性
            return CommonUtil.errorJson(ErrorEnum.E_40004);
        }
        if(goodsInfo.getInteger("saleStatus")!=1){//商品上下架情况
            return CommonUtil.errorJson(ErrorEnum.E_40003);
        }
        if(numbers>goodsInfo.getInteger("goodsNumbers")){//购买数量是否超出库存
            return CommonUtil.errorJson(ErrorEnum.E_40002);
        }
        JSONObject customerInfo = goodsViewDao.getCustomerInfoById(CommonUtil.getUserId());
        int planNumber = requestJson.getInteger("plan");
        Integer sum = numbers * goodsInfo.getInteger("goodsPrice");
        if(planNumber==2){
            if(customerInfo.getInteger("balance")<sum){//余额是否充足
                return CommonUtil.errorJson(ErrorEnum.E_40005);
            }
        }
        //订单入库
        JSONObject orderJson = new JSONObject();
        String orderUUID = CommonUtil.getDecUUID().substring(2,22);
        orderJson.put("orderUUID",orderUUID);//放入UUID
        orderJson.put("customerComment",requestJson.getString("customerComment"));
        orderJson.put("businessId",requestJson.getLong("businessId"));
        orderJson.put("userId",CommonUtil.getUserId());
        orderJson.put("orderStatus",planNumber);
        JSONObject addressInfo =
                goodsViewDao.getAddressInfoById(requestJson.getLong("addressId"));
        orderJson.put("customerAddress",addressInfo.getString("address"));
        orderJson.put("customerPhone",addressInfo.getString("phone"));
        orderJson.put("customerName",addressInfo.getString("name"));
        orderDao.addOrderOneType(orderJson);

        //订单子表
        JSONObject subOrderJson = new JSONObject();
        subOrderJson.put("userId",CommonUtil.getUserId());
        subOrderJson.put("goodsId",goodsInfo.getLong("goodsId"));
        subOrderJson.put("categoryName",goodsInfo.getString("categoryName"));
        subOrderJson.put("goodsNumbers",numbers);
        subOrderJson.put("goodsName",goodsInfo.getString("goodsName"));
        subOrderJson.put("goodsPrice",goodsInfo.getInteger("goodsPrice"));
        subOrderJson.put("orderUUID",orderUUID);
        orderDao.addSubOrderOneType(subOrderJson);

        if(planNumber==2){
            //用户余额划扣
            JSONObject paymentJson = new JSONObject();
            paymentJson.put("userId",CommonUtil.getUserId());
            paymentJson.put("sum",sum);
            orderDao.customerPayment(paymentJson);

            //余额验证
            customerInfo = goodsViewDao.getCustomerInfoById(CommonUtil.getUserId());
            if(customerInfo.getInteger("balance")<0){//余额是否充足
                return CommonUtil.errorJson(ErrorEnum.E_40005);
            }
        }
        return CommonUtil.successJson();
    }
}
