package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GoodsViewDao {


    int countGoods(JSONObject requestJson);

    List<JSONObject> listGoods(JSONObject requestJson);

    List<JSONObject> listCategory(JSONObject requestJson);
}
