package com.heeexy.example.controller;


import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.PageTableService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/pageTable")
public class PageTableController {

    @Autowired
    private PageTableService pageTableService;

    @GetMapping("/getAllPage")
    public JSONObject getAllPage(HttpServletRequest request){
        return pageTableService.getAllPage(CommonUtil.request2Json(request));
    }

    @PostMapping("/deletePageTable")
    public JSONObject deletePageTable(@RequestBody JSONObject jsonObject){
        return pageTableService.deletePageTable(jsonObject);
    }

    @PostMapping("/addPageTable")
    public JSONObject addPageTable(@RequestBody JSONObject jsonObject){
        return pageTableService.addPageTable(jsonObject);
    }

    @GetMapping("/doSearch")
    public JSONObject doSearch(HttpServletRequest request){
        return pageTableService.doSearch(CommonUtil.request2Json(request));
    }

}
