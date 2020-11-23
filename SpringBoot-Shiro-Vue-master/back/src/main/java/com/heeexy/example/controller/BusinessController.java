package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.BusinessService;
import com.heeexy.example.util.CommonUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/business")
public class BusinessController {

    @Autowired
    private BusinessService businessService;

    @RequiresPermissions("businessInfo:list")
    @GetMapping("/getInfo")
    public JSONObject getInfo(){
        JSONObject customerInfo = businessService.getInfo();
        return CommonUtil.successJson(customerInfo);
    }

    @RequiresPermissions("businessInfo:update")
    @PostMapping("/updateInfo")
    public JSONObject updateInfo(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson,
"name,phoneNumber,address,openTime,closeTime");
        CommonUtil.getAllStringTrimed(requestJson,
                "name,phoneNumber,address,brief,openTime,closeTime");
        CommonUtil.hasAllRequiredString(requestJson,
                "name,phoneNumber,address,openTime,closeTime");
        return businessService.updateInfo(requestJson);
    }
}
