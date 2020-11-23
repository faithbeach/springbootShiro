package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsCategoryDao;
import com.heeexy.example.service.GoodsCategoryService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GoodsCategoryServiceImpl implements GoodsCategoryService {

    @Autowired
    private GoodsCategoryDao goodsCategoryDao;


    @Override
    public JSONObject getAllCategories(JSONObject request2Json) {
        //封装分页数据
        CommonUtil.fillPageParam(request2Json);

        //统计当前条件下查询数据总个数  根据delete_status和商家ID查询
        request2Json.put("userId",CommonUtil.getUserId());
        int count = goodsCategoryDao.countCategory(request2Json);

        //获取当前条件下所有的数据
        List<JSONObject> list = goodsCategoryDao.listPageTable(request2Json);
        return CommonUtil.successPage(request2Json, list, count);
    }

    @Override
    @Transactional
    public JSONObject updateCategory(JSONObject requestJson) {
        //验证类目名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsCategoryDao.queryExistCategoryName(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsCategoryDao.updateCategory(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject addCategory(JSONObject requestJson) {
        //验证类目名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsCategoryDao.queryExistCategoryName(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsCategoryDao.addCategory(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject deleteCategory(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        goodsCategoryDao.deleteCategory(requestJson);
        return CommonUtil.successJson();
    }

//    @Override
//    public JSONObject searchQuery(JSONObject request2Json) {
//        //封装分页数据
//        CommonUtil.fillPageParam(request2Json);
//
//        //统计当前条件下查询数据总个数  根据delete_status和商家ID查询
//        request2Json.put("userId",CommonUtil.getUserId());
//        int count = goodsCategoryDao.countCategory(request2Json);
//
//        //获取当前条件下所有的数据
//        List<JSONObject> list = goodsCategoryDao.listPageTable(request2Json);
//        return CommonUtil.successPage(request2Json, list, count);
//    }
}
