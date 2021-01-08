package com.heeexy.example.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.dao.GoodsManageDao;
import com.heeexy.example.service.GoodsManageService;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.constants.ErrorEnum;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class GoodsManageServiceImpl implements GoodsManageService {

    @Autowired
    private GoodsManageDao goodsManageDao;

    @Override
    public JSONObject getGoodsList(JSONObject request2Json) {
        //封装分页数据
        CommonUtil.fillPageParam(request2Json);
        //统计当前条件下查询数据总个数  根据delete_status和商家ID查询
        request2Json.put("userId",CommonUtil.getUserId());
        int count = goodsManageDao.countGoods(request2Json);
        //获取当前条件下所有的数据
        List<JSONObject> list = goodsManageDao.listGoods(request2Json);
        JSONObject info = CommonUtil.successPage(request2Json, list, count);
        JSONObject data = info.getJSONObject("info");
        data.put("statusList",goodsManageDao.listStatus());
        info.put("info",data);
        return info;
    }

    @Override
    public JSONObject updateGoods(JSONObject requestJson) {
        //验证商品名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsManageDao.queryExistGoods(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsManageDao.updateGoods(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject deleteGoods(JSONObject requestJson) {
        requestJson.put("userId",CommonUtil.getUserId());
        goodsManageDao.deleteGoods(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject addGoods(JSONObject requestJson) {
        //验证类目名称是否存在
        requestJson.put("userId",CommonUtil.getUserId());
        int exist = goodsManageDao.queryExistGoods(requestJson);
        if(exist>0){
            return CommonUtil.errorJson(ErrorEnum.E_30009);
        }
        goodsManageDao.addGoods(requestJson);
        return CommonUtil.successJson();
    }

    @Override
    public JSONObject batchAddGoods(MultipartFile file) {
        String fileName = file.getOriginalFilename();
        Set<Integer> invaildRows = new HashSet<>(128);   //不符合要求的列
        try {
            InputStream is = file.getInputStream();
            if(fileName.endsWith("xlsx")){
                Workbook workbook = new XSSFWorkbook(is);
                Sheet sheet = workbook.getSheet("Sheet1");
                int totalRows = sheet.getLastRowNum();
                int threadNum = (totalRows-1)/100;          //每100条数据创建一个线程处理
                for(int threadId=0;threadId<=threadNum;threadId++){
                    int curThreadId = threadId;
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            JSONObject jsonObject = new JSONObject();
                            int beginRowNum = curThreadId*100+1;
                            int lastRowNum = curThreadId==threadNum?(totalRows-1):beginRowNum+100;
                            for(int i=beginRowNum;i<lastRowNum;i++){

                            }
                        }
                    }).start();
                }
                System.out.println(sheet.getRow(0).getLastCellNum());
                Cell cell = sheet.getRow(3).getCell(1);
            }else {
                return CommonUtil.errorJson(ErrorEnum.E_30300);
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return CommonUtil.errorJson(ErrorEnum.E_30300);
        }
        return CommonUtil.successJson();
    }
}
