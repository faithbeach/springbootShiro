package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsViewDao;
import com.heeexy.example.service.GoodsViewService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        //获取当前条件下所有的数据
        List<JSONObject> list = goodsViewDao.listGoods(requestJson);

        JSONObject info = CommonUtil.successPage(requestJson, list, count);
//        JSONObject data = info.getJSONObject("info");
//        data.put("statusList",goodsViewDao.listStatus());
//        info.put("info",data);
        return info;
    }
}
