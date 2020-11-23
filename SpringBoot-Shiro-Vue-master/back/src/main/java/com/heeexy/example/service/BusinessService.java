package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

public interface BusinessService {
    JSONObject getInfo();

    JSONObject updateInfo(JSONObject requestJson);
}
