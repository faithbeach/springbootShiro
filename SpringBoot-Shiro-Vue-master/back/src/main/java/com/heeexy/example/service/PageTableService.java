package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;

import javax.servlet.http.HttpServletRequest;

public interface PageTableService {

    JSONObject getAllPage(JSONObject request2Json);

    JSONObject deletePageTable(JSONObject jsonObject);

    JSONObject addPageTable(JSONObject jsonObject);

    JSONObject doSearch(JSONObject request2Json);
}
