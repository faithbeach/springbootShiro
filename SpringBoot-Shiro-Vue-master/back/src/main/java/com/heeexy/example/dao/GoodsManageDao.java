package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GoodsManageDao {

    Integer countGoods(JSONObject request2Json);

    List<JSONObject> listGoods(JSONObject request2Json);

    List<JSONObject> listStatus();

    int queryExistGoods(JSONObject requestJson);

    void updateGoods(JSONObject requestJson);

    void deleteGoods(JSONObject requestJson);

    void addGoods(JSONObject requestJson);
}
