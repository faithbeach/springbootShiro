package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.AddressService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @GetMapping("/listAddress")
    public JSONObject listAddress(HttpServletRequest request) {
        return addressService.listAddress(CommonUtil.request2Json(request));
    }

    @PostMapping("/addAddress")
    public JSONObject addAddress(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "name,address,phone");
        return addressService.addAddress(requestJson);
    }

    @PostMapping("/updateAddress")
    public JSONObject updateAddress(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "name,address,phone");
        return addressService.updateAddress(requestJson);
    }

    @PostMapping("/deleteAddress")
    public JSONObject deleteAddress(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "id");
        return addressService.deleteAddress(requestJson);
    }
}
