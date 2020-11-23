package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.PageTableDao;
import com.heeexy.example.service.PageTableService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PageTableServiceImpl implements PageTableService {

    @Autowired
    private PageTableDao pageTableDao;


    @Override
    public JSONObject getAllPage(JSONObject request2Json) {

        //封装分页数据
        CommonUtil.fillPageParam(request2Json);

        //统计当前条件下查询数据总个数
        int count = pageTableDao.countPageTable(request2Json);

        //获取当前条件下所有的数据
        List<JSONObject> list = pageTableDao.listPageTable(request2Json);
        return CommonUtil.successPage(request2Json, list, count);
    }

    @Override
    public JSONObject deletePageTable(JSONObject jsonObject) {
        pageTableDao.deletePageTable(jsonObject);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject addPageTable(JSONObject jsonObject) {
        if(pageTableDao.isCodeOrNameExist(jsonObject)>0)
            return CommonUtil.errorJson(ErrorEnum.E_10010);
        Integer newId = (1+pageTableDao.getMaxId()/100)*100;

        jsonObject.put("id1",newId+1);
        jsonObject.put("id2",newId+2);
        jsonObject.put("id3",newId+3);
        jsonObject.put("pc1",jsonObject.getString("menuCode")+":list");
        jsonObject.put("pc2",jsonObject.getString("menuCode")+":add");
        jsonObject.put("pc3",jsonObject.getString("menuCode")+":update");

        pageTableDao.addPage(jsonObject);

        return CommonUtil.successJson();
    }



    @Override
    public JSONObject doSearch(JSONObject request2Json) {
        //封装分页数据
        CommonUtil.fillPageParam(request2Json);
        //统计当前条件下查询数据总个数
        if(request2Json.getString("search").equals(""))
            request2Json.put("search",null);
        int count = pageTableDao.doSearch(request2Json);

        //获取当前条件下所有的数据
        List<JSONObject> list = pageTableDao.listDoSearch(request2Json);

        return CommonUtil.successPage(request2Json, list, count);
    }
}
