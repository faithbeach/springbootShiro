package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

public interface GoodsManageService {

    JSONObject getGoodsList(JSONObject request2Json);

    JSONObject updateGoods(JSONObject requestJson);

    JSONObject deleteGoods(JSONObject requestJson);

    JSONObject addGoods(JSONObject requestJson);
}
