package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.AddressDao;
import com.heeexy.example.service.AddressService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressDao addressDao;

    @Override
    public JSONObject listAddress(JSONObject jsonObject) {
        //封装分页数据
        CommonUtil.fillPageParam(jsonObject);
        jsonObject.put("userId",CommonUtil.getUserId());
        //统计当前条件下查询数据总个数
        int count = addressDao.countAddress(jsonObject);
        //获取当前条件下所有的数据
        List<JSONObject> list = addressDao.listAddress(jsonObject);
        return CommonUtil.successPage(jsonObject, list, count);
    }

    @Override
    public JSONObject addAddress(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        addressDao.addAddress(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject updateAddress(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        addressDao.updateAddress(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject deleteAddress(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        addressDao.deleteAddress(requestJson);
        return CommonUtil.successJson();
    }
}
