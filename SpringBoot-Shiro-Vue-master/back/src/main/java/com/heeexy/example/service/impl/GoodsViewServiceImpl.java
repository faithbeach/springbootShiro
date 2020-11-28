package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsViewDao;
import com.heeexy.example.service.GoodsViewService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GoodsViewServiceImpl implements GoodsViewService {

    @Autowired
    private GoodsViewDao goodsViewDao;

    @Override
    public JSONObject viewGoods(JSONObject requestJson) {
        //封装分页数据
        CommonUtil.fillPageParam(requestJson);

        //统计当前条件下查询数据总个数  根据delete_status和商家ID查询
//        requestJson.put("userId",CommonUtil.getUserId());
        int count = goodsViewDao.countGoods(requestJson);
        if(count==0)
            return CommonUtil.errorJson(ErrorEnum.E_30011);

        //获取当前条件下所有的数据
        List<JSONObject> list = goodsViewDao.listGoods(requestJson);
        //获取当前条件下的列表
        List<JSONObject> categoryList = goodsViewDao.listCategory(requestJson);
        JSONObject categoryAll = new JSONObject();
        categoryAll.put("categoryName","全部");
        categoryAll.put("number",0);
        ArrayList<JSONObject> arrayList= new ArrayList<>();
        arrayList.add(categoryAll);
        arrayList.addAll(categoryList);
        JSONObject info = CommonUtil.successPage(requestJson, list, count);
        JSONObject data = info.getJSONObject("info");
        data.put("categoryList",arrayList);
        info.put("info",data);
        return info;
    }
}
