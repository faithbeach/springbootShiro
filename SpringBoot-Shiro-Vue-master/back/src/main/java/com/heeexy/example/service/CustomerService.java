package com.heeexy.example.service;


import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface CustomerService {
    JSONObject getInfo();

    JSONObject updateInfo(JSONObject requestJson);

    JSONObject addBalance(JSONObject requestJson);
}
