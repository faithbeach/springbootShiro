package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

public interface OrderDao {
    void addOrderOneType(JSONObject orderJson);

    void addSubOrderOneType(JSONObject subOrderJson);

    void customerPayment(JSONObject paymentJson);
}
