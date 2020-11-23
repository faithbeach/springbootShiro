package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.GoodsCategoryService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/goodsCategory")
public class GoodsCategoryController {

    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @GetMapping("/getAllCategories")
    public JSONObject getAllCategories(HttpServletRequest request){
        JSONObject request2Json = CommonUtil.request2Json(request);
        if(request2Json.getString("search")!=null)
            CommonUtil.getAllStringTrimed(request2Json,"search");
        return goodsCategoryService.getAllCategories(request2Json);
    }

    @PostMapping("/updateCategory")
    public JSONObject updateCategory(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "categoryName,categoryBrief,id");
        CommonUtil.getAllStringTrimed(requestJson,"categoryName,categoryBrief");
        CommonUtil.hasAllRequiredString(requestJson, "categoryName");
        return goodsCategoryService.updateCategory(requestJson);
    }

    @PostMapping("/addCategory")
    public JSONObject addCategory(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "categoryName");
        CommonUtil.getAllStringTrimed(requestJson,"categoryName");
        CommonUtil.hasAllRequiredString(requestJson, "categoryName");
        return goodsCategoryService.addCategory(requestJson);
    }

    @PostMapping("/deleteCategory")
    public JSONObject deleteCategory(@RequestBody JSONObject requestJson){
        CommonUtil.hasAllRequired(requestJson, "id");
        return goodsCategoryService.deleteCategory(requestJson);
    }

//    @GetMapping("/searchQuery")
//    public JSONObject searchQuery(HttpServletRequest request){
//        JSONObject requestJson = CommonUtil.request2Json(request);
//        CommonUtil.hasAllRequiredString(requestJson, "search");
//        return goodsCategoryService.searchQuery(requestJson);
//    }
}
