package com.heeexy.example.dao;


import com.alibaba.fastjson.JSONObject;

import java.util.List;

public interface PageTableDao {

    int countPageTable(JSONObject request2Json);

    List<JSONObject> listPageTable(JSONObject request2Json);

    void deletePageTable(JSONObject jsonObject);

    int isCodeOrNameExist(JSONObject jsonObject);

    int getMaxId();

    void addPage(JSONObject jsonObject);

    int doSearch(JSONObject request2Json);

    List<JSONObject> listDoSearch(JSONObject request2Json);
}
