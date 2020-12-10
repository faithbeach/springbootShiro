package com.heeexy.example.controller;

import com.heeexy.example.service.ViewOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/viewOrder")
@RestController
public class ViewOrderController {

    @Autowired
    private ViewOrderService viewOrderService;



}
