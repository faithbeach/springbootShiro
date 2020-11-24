package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.GoodsManageService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/goodsManage")
public class GoodsManageController {

    @Autowired
    private GoodsManageService goodsManageService;

    @GetMapping("/getGoodsList")
    public JSONObject getGoods(HttpServletRequest request){
        JSONObject request2Json = CommonUtil.request2Json(request);
        if(request2Json.getString("search")!=null)
            CommonUtil.getAllStringTrimed(request2Json,"search");
        return goodsManageService.getGoodsList(request2Json);
    }

    @PostMapping("/updateGoods")
    public JSONObject updateGoods(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "name,id");
        CommonUtil.getAllStringTrimed(requestJson,"name,brief");
        CommonUtil.hasAllRequiredString(requestJson, "name");
        return goodsManageService.updateGoods(requestJson);
    }

    @PostMapping("/deleteGoods")
    public JSONObject deleteGoods(@RequestBody JSONObject requestJson){
        requestJson.put("userId",CommonUtil.getUserId());
        return goodsManageService.deleteGoods(requestJson);
    }

    @PostMapping("/addGoods")
    public JSONObject addGoods(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "name,price,numbers,categoryId,statusCode");
        CommonUtil.getAllStringTrimed(requestJson,"name");
        CommonUtil.hasAllRequiredString(requestJson, "name");
        return goodsManageService.addGoods(requestJson);
    }
}
