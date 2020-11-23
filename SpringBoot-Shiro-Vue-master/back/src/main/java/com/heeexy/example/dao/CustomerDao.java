package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface CustomerDao {
    void addCustomerDao(JSONObject insert);

    JSONObject getInfo(Long userId);

    void updateInfo(JSONObject requestJson);

    void addBalance(JSONObject requestJson);
}
