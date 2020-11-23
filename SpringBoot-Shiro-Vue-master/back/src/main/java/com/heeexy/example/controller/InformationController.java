package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.InformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/information")
public class InformationController {

    @Autowired
    private InformationService informationService;

    @GetMapping("/list")
    public JSONObject list(){
        return informationService.list();
    }

    @PostMapping("/update")
    public JSONObject update(@RequestBody JSONObject jsonObject){

        return informationService.update(jsonObject);
    }

    @PostMapping("/delete")
    public JSONObject delete(@RequestBody JSONObject jsonObject){//当前请求进行拦截,把数据以后面格式传回去
        return informationService.delete(jsonObject);
    }

    @PostMapping("/selectbyid")
    public JSONObject selectById(@RequestBody JSONObject jsonObject){
        return informationService.selectById(jsonObject);
    }

    @PostMapping("/updatebyid")
    public JSONObject updateById(@RequestBody JSONObject jsonObject){
        return informationService.updateById(jsonObject);
    }

    @PostMapping("/insert")
    public JSONObject insert(@RequestBody JSONObject jsonObject){
        return informationService.insert(jsonObject);
    }

    /**
     * 输入
     * {
     *     perPage:单页显示条目数
     *     viewPage:当前浏览页数
     * }
     * 返回
     * {
     *      sumPage浏览总数
     * }
     */
    @PostMapping("/Page")
    public JSONObject page(@RequestBody JSONObject jsonObject){
        return informationService.page(jsonObject);
    }

    @PostMapping("/addPage")
    public JSONObject addPage(@RequestBody JSONObject jsonObject){
        return informationService.addPage(jsonObject);
    }


}
