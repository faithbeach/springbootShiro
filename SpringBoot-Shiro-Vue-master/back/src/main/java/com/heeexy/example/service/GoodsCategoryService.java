package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

public interface GoodsCategoryService {
    JSONObject getAllCategories(JSONObject request2Json);

    JSONObject updateCategory(JSONObject jsonObject);

    JSONObject addCategory(JSONObject requestJson);

    JSONObject deleteCategory(JSONObject requestJson);

//    JSONObject searchQuery(JSONObject requestJson);
}
