package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.ViewBusinessDao;
import com.heeexy.example.service.ViewBusinessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ViewBusinessServiceImpl implements ViewBusinessService {

    @Autowired
    private ViewBusinessDao viewBusinessDao;

    @Override
    public JSONObject getBusinessById(JSONObject jsonObject) {

        return viewBusinessDao.getBusinessById(jsonObject);
    }
}
