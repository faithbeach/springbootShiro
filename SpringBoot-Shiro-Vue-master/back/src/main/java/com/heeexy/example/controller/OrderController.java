package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.OrderService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    /**
     * 购买一种产品的情况
     * */
    @PostMapping("/buyOneType")
    public JSONObject buyOneType(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson,"goodsId,businessId,addressId,numbers,plan");
        return orderService.buyOneType(requestJson);
    }

}
