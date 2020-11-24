package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsManageDao;
import com.heeexy.example.service.GoodsManageService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsManageServiceImpl implements GoodsManageService {

    @Autowired
    private GoodsManageDao goodsManageDao;

    @Override
    public JSONObject getGoodsList(JSONObject request2Json) {
        //封装分页数据
        CommonUtil.fillPageParam(request2Json);

        //统计当前条件下查询数据总个数  根据delete_status和商家ID查询
        request2Json.put("userId",CommonUtil.getUserId());
        int count = goodsManageDao.countGoods(request2Json);

        //获取当前条件下所有的数据
        List<JSONObject> list = goodsManageDao.listGoods(request2Json);
        JSONObject info = CommonUtil.successPage(request2Json, list, count);
        JSONObject data = info.getJSONObject("info");
        data.put("statusList",goodsManageDao.listStatus());
        info.put("info",data);
        return info;
    }

    @Override
    public JSONObject updateGoods(JSONObject requestJson) {
        //验证商品名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsManageDao.queryExistGoods(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsManageDao.updateGoods(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject deleteGoods(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        goodsManageDao.deleteGoods(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject addGoods(JSONObject requestJson) {
        //验证类目名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsManageDao.queryExistGoods(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsManageDao.addGoods(requestJson);
        return CommonUtil.successJson();
    }
}
