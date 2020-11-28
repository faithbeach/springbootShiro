package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.service.GoodsViewService;
import com.heeexy.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/goods")
public class GoodsViewController {

    @Autowired
    private GoodsViewService goodsViewService;

    @GetMapping("/viewGoods")
    public JSONObject getGoods(HttpServletRequest request){
        JSONObject request2Json = CommonUtil.request2Json(request);
        CommonUtil.getAllStringTrimed(request2Json,"searchText");
        return goodsViewService.viewGoods(request2Json);
    }

}
