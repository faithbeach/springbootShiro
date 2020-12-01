package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface AddressDao {

    int countAddress(JSONObject jsonObject);

    List<JSONObject> listAddress(JSONObject jsonObject);

    void addAddress(JSONObject requestJson);

    void updateAddress(JSONObject requestJson);

    void deleteAddress(JSONObject requestJson);
}
