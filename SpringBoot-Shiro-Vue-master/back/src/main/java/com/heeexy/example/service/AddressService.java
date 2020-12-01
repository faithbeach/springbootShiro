package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

public interface AddressService {
    JSONObject listAddress(JSONObject request2Json);

    JSONObject addAddress(JSONObject requestJson);

    JSONObject updateAddress(JSONObject requestJson);

    JSONObject deleteAddress(JSONObject requestJson);
}
