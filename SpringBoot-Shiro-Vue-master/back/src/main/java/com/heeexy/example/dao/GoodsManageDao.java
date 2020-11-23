package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GoodsManageDao {

    Integer countGoods(JSONObject request2Json);

    List<JSONObject> listGoods(JSONObject request2Json);
}
