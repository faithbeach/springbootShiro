package com.heeexy.example.service;

import com.alibaba.fastjson.JSONObject;
import org.springframework.web.multipart.MultipartFile;

public interface GoodsManageService {

    JSONObject getGoodsList(JSONObject request2Json);

    JSONObject updateGoods(JSONObject requestJson);

    JSONObject deleteGoods(JSONObject requestJson);

    JSONObject addGoods(JSONObject requestJson);

    JSONObject batchAddGoods(MultipartFile multipartFile);
}
