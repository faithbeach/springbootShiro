package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;
import java.util.List;

public interface InformationDao {

    void update(JSONObject jsonObject);

    List<JSONObject> select(JSONObject jsonObject);

    void insert(JSONObject jsonObject);

    int count(JSONObject jsonObject);

    List<JSONObject> page(JSONObject jsonObject);

    int getMaxId();

    Integer isCodeOrNameExist(JSONObject jsonObject);

    void addPage(JSONObject jsonObject);
}