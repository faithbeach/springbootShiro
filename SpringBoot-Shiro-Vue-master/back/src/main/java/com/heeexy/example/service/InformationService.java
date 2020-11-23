package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

public interface InformationService {

    JSONObject list();

    JSONObject update(JSONObject jsonObject);

    JSONObject delete(JSONObject jsonObject);

    JSONObject selectById(JSONObject jsonObject);

    JSONObject updateById(JSONObject jsonObject);

    JSONObject insert(JSONObject jsonObject);

    JSONObject page(JSONObject jsonObject);

    JSONObject addPage(JSONObject jsonObject);
}
