package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.CustomerService;
import com.heeexy.example.util.CommonUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @RequiresPermissions("customerInfo:list")
    @GetMapping("/getInfo")
    public JSONObject getInfo(){
        JSONObject customerInfo = customerService.getInfo();
        return CommonUtil.successJson(customerInfo);
    }

    @RequiresPermissions("customerInfo:update")
    @PostMapping("/updateInfo")
    public JSONObject updateInfo(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "name");
        CommonUtil.getAllStringTrimed(requestJson,
                "name,phoneNumber");
        CommonUtil.hasAllRequiredString(requestJson,
                "name");
        return customerService.updateInfo(requestJson);
    }

    @PostMapping("/addBalance")
    public JSONObject addBalance(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "amounts");
        return customerService.addBalance(requestJson);
    }

}
