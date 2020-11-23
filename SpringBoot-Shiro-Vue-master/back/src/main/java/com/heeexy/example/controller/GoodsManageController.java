package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.GoodsManageService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
