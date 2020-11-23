package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.BusinessDao;
import com.heeexy.example.service.BusinessService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BusinessServiceImpl implements BusinessService {

    @Autowired
    private BusinessDao businessDao;


    @Override
    public JSONObject getInfo() {
//        System.out.println(creatorId);
        return businessDao.getInfo(CommonUtil.getUserId());
    }

    @Override
    public JSONObject updateInfo(JSONObject requestJson) {
        Long updateId = CommonUtil.getUserId();
        requestJson.put("userId",updateId);
        businessDao.updateInfo(requestJson);
        return CommonUtil.successJson();
    }

}
