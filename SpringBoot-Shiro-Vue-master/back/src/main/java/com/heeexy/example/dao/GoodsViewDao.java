package com.heeexy.example.dao;

import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsViewDao {


    int countGoods(JSONObject requestJson);

    List<JSONObject> listGoods(JSONObject requestJson);

    List<JSONObject> listCategory(JSONObject requestJson);

    JSONObject getGoodsInfoById(Long goodsId);

    JSONObject getCustomerInfoById(@Param("userId") Long userId);

    JSONObject getAddressInfoById(@Param("addressId") Long addressId);
}
