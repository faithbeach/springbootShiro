package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.CustomerDao;
import com.heeexy.example.dao.UserDao;
import com.heeexy.example.service.CustomerService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Autowired
    private UserDao userDao;

    @Override
    public JSONObject getInfo() {
//        System.out.println(creatorId);
        return customerDao.getInfo(CommonUtil.getUserId());
    }

    @Override
    public JSONObject updateInfo(JSONObject requestJson) {
        Long updateId = CommonUtil.getUserId();
        requestJson.put("userId",updateId);
        customerDao.updateInfo(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject addBalance(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        customerDao.addBalance(requestJson);
        return CommonUtil.successJson();
    }
}
