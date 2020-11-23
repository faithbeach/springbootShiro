package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

public interface BusinessDao {


    void addBusiness(JSONObject jsonObject);

    JSONObject getInfo(Long userId);

    void updateInfo(JSONObject requestJson);
}
