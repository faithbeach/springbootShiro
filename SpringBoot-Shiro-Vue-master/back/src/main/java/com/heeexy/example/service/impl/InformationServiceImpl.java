package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.InformationDao;
import com.heeexy.example.service.InformationService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InformationServiceImpl implements InformationService {

    @Autowired
    private InformationDao informationDao;

    @Override
    public JSONObject list() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("delete_status",1);
        List<JSONObject> list = informationDao.select(jsonObject);
        return CommonUtil.successJson(list);
    }

    @Override
    public JSONObject update(JSONObject jsonObject) {
        jsonObject.put("delete_status",1);
        informationDao.update(jsonObject);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject delete(JSONObject jsonObject) {
        jsonObject.put("delete_status",2);
        informationDao.update(jsonObject);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject selectById(JSONObject jsonObject) {
        List<JSONObject> list = informationDao.select(jsonObject);
        return CommonUtil.successJson(list);
    }

    @Override
    public JSONObject updateById(JSONObject jsonObject) {
        informationDao.update(jsonObject);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject insert(JSONObject jsonObject) {
        jsonObject.put("delete_status",1);
        informationDao.insert(jsonObject);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject page(JSONObject jsonObject) {
        Integer a = jsonObject.getIntValue("perPage");
        int num = (informationDao.count(jsonObject)+a-1)/a;
        Integer b = jsonObject.getIntValue("viewPage");
        b = a * b;
        jsonObject.put("viewIndex",b);
        List<JSONObject> list = informationDao.page(jsonObject);
        JSONObject jsonObject1 = CommonUtil.successJson(list);
        jsonObject1.put("sumPage",num);
        return jsonObject1;
    }

    @Override
    public JSONObject addPage(JSONObject jsonObject) {
        if(informationDao.isCodeOrNameExist(jsonObject)>0)
            return CommonUtil.errorJson(ErrorEnum.E_10010);
        Integer newId = (1+informationDao.getMaxId()/100)*100;

        jsonObject.put("id1",newId+1);
        jsonObject.put("id2",newId+2);
        jsonObject.put("id3",newId+3);
        jsonObject.put("pc1",jsonObject.getString("menuCode")+":list");
        jsonObject.put("pc2",jsonObject.getString("menuCode")+":add");
        jsonObject.put("pc3",jsonObject.getString("menuCode")+":update");

        informationDao.addPage(jsonObject);

        return CommonUtil.successJson();
    }
}
