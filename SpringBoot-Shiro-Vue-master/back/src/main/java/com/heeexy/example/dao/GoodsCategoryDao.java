package com.heeexy.example.dao;


import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface GoodsCategoryDao {
    Integer countCategory(JSONObject request2Json);

    List<JSONObject> listPageTable(JSONObject request2Json);

    Integer updateCategory(JSONObject jsonObject);

    int queryExistCategoryName(JSONObject requestJson);

    void addCategory(JSONObject requestJson);

    void deleteCategory(JSONObject requestJson);
}
