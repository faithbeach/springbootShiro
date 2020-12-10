package com.heeexy.example.service.impl;

import com.heeexy.example.dao.ViewOrderDao;
import com.heeexy.example.service.ViewOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ViewOrderServiceImpl implements ViewOrderService {

    @Autowired
    private ViewOrderDao viewOrderDao;
}
