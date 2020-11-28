package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.ViewBusinessService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/viewBusiness")
@RestController
public class ViewBusinessController {

    @Autowired
    private ViewBusinessService viewBusinessService;

    @GetMapping("/getBusinessById")
    public JSONObject getBusinessById(HttpServletRequest request){

        JSONObject businessInfo =
                viewBusinessService.getBusinessById(CommonUtil.request2Json(request));

        return CommonUtil.successJson(businessInfo);
    }
}
