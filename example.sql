/*
Navicat MySQL Data Transfer

Source Server         : Java
Source Server Version : 80011
Source Host           : localhost:3306
Source Database       : example

Target Server Type    : MYSQL
Target Server Version : 80011
File Encoding         : 65001

Date: 2020-12-10 20:39:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT '' COMMENT '文章内容',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1.有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='发布号作者表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('5', '照一照', '2017-10-25 09:08:45', '2020-11-09 09:19:30', '2');
INSERT INTO `article` VALUES ('6', '亚里士多德', '2017-10-26 10:49:28', '2020-11-08 11:09:27', '2');
INSERT INTO `article` VALUES ('10', '亚历山大', '2017-10-26 14:57:45', '2017-11-08 13:28:52', '1');
INSERT INTO `article` VALUES ('11', '李白', '2017-10-26 15:23:42', '2017-10-26 15:23:42', '1');
INSERT INTO `article` VALUES ('19', '文章test2', '2017-11-18 13:37:07', '2017-11-18 13:37:11', '1');
INSERT INTO `article` VALUES ('20', '科加斯可可', '2020-10-27 20:17:40', '2020-10-27 20:17:40', '1');
INSERT INTO `article` VALUES ('21', 'ooooooooo', '2020-11-08 15:51:21', '2020-11-08 15:51:21', '1');

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `user_id` int(11) DEFAULT NULL,
  `business_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家名称',
  `business_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家电话',
  `business_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家地址',
  `business_open_time` time DEFAULT NULL COMMENT '商家开始营业时间',
  `business_close_time` time DEFAULT NULL COMMENT '商家结束营业时间',
  `business_brief` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商检简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES ('2', '2020-11-19 08:02:31', null, null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `business` VALUES ('3', '2020-11-19 08:04:55', null, '2020-11-19 08:04:55', null, '1', null, null, null, null, null, null, null);
INSERT INTO `business` VALUES ('4', '2020-11-19 20:36:23', null, '2020-11-19 20:36:23', null, '1', null, null, null, null, null, null, null);
INSERT INTO `business` VALUES ('5', '2020-11-21 12:30:24', '10003', '2020-11-23 11:15:25', '10010', '1', '10010', '美团团团', '1000000', '麦当劳旁边', '06:00:00', '15:00:00', '吼吼吃噶');
INSERT INTO `business` VALUES ('6', '2020-11-21 18:24:34', null, '2020-11-21 18:24:34', null, '1', '10003', null, null, null, null, null, null);
INSERT INTO `business` VALUES ('7', '2020-11-23 11:03:24', '10003', '2020-11-23 11:08:16', '10011', '1', '10011', '饿了么', '15000', '麦当劳上面', '08:30:00', '17:00:00', '空虚寂寞冷');
INSERT INTO `business` VALUES ('8', '2020-11-24 20:57:53', '10003', '2020-11-24 21:00:18', '10012', '1', '10012', '麦当劳', '10001', '雍华庭', '06:00:00', '21:00:00', '我好想吃薯条啊');
INSERT INTO `business` VALUES ('9', '2020-11-24 20:58:25', '10003', '2020-11-24 21:08:04', '10013', '1', '10013', '肯德基', '159', '仙领', '08:00:00', '18:00:00', '老油条巨好吃');
INSERT INTO `business` VALUES ('10', '2020-11-24 20:59:14', '10003', '2020-11-24 21:14:57', '10014', '1', '10014', '尊宝披萨', '156', '地王广场', '05:00:00', '23:50:00', '披萨啊披萨');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上次修改时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `user_id` bigint(11) DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '顾客姓名',
  `customer_phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账户电话号码',
  `customer_balance` decimal(65,2) DEFAULT NULL COMMENT '账户余额    单位分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '2020-11-21 12:27:41', '10003', '2020-11-21 12:27:41', '10003', '1', '8', null, null, null);
INSERT INTO `customer` VALUES ('2', '2020-11-21 12:29:22', '10003', '2020-12-08 20:47:56', '10009', '1', '10009', '大苏', '15975648231', '2194.00');

-- ----------------------------
-- Table structure for customer_address
-- ----------------------------
DROP TABLE IF EXISTS `customer_address`;
CREATE TABLE `customer_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名称',
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址',
  `customer_phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `default_address` int(1) DEFAULT '1' COMMENT '默认地址 1-非默认地址 2-默认地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of customer_address
-- ----------------------------
INSERT INTO `customer_address` VALUES ('1', '2020-12-01 20:12:50', '10009', '2020-12-01 22:16:37', '10009', '1', '10009', '苏先生', '君豪中心1楼', '10008112', '1');
INSERT INTO `customer_address` VALUES ('3', '2020-12-01 21:03:57', '10009', '2020-12-01 22:16:08', '10009', '1', '10009', '小苏', '麦当劳隔壁', '12684984', '2');
INSERT INTO `customer_address` VALUES ('4', '2020-12-01 22:06:06', '10009', '2020-12-01 22:16:08', '10009', '2', '10009', '苏大哥', '顶顶顶', '159731', '1');
INSERT INTO `customer_address` VALUES ('5', '2020-12-01 22:16:04', '10009', '2020-12-01 22:16:04', '10009', '1', '10009', '苏姥姥', '31465', '465461', '1');
INSERT INTO `customer_address` VALUES ('6', '2020-12-01 22:17:10', '10009', '2020-12-01 22:17:10', '10009', '1', '10009', '苏超人', 'M78', '1324659784', '1');

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品类名',
  `category_brief` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `business_id` bigint(20) unsigned DEFAULT NULL COMMENT '商家名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES ('1', '2020-11-22 10:44:39', '10010', '2020-11-24 20:28:45', '10010', '1', '零食', '很多种类噢12', '10010');
INSERT INTO `goods_category` VALUES ('2', '2020-11-22 18:49:01', '10010', '2020-11-22 19:00:39', '10010', '2', '海鲜', '海里的美味', '10010');
INSERT INTO `goods_category` VALUES ('3', '2020-11-22 19:07:53', '10010', '2020-11-22 19:07:53', '10010', '1', '海鲜', '好吃的呢', '10010');
INSERT INTO `goods_category` VALUES ('4', '2020-11-23 10:25:47', '10010', '2020-11-23 11:01:20', '10010', '1', '贝壳呀', '也是一种海鲜哦', '10010');
INSERT INTO `goods_category` VALUES ('5', '2020-11-23 11:00:23', '10010', '2020-11-24 20:05:43', '10010', '1', '波力海苔哦', '很好吃的紫菜', '10010');
INSERT INTO `goods_category` VALUES ('6', '2020-11-23 11:02:47', '10010', '2020-11-24 20:29:26', '10010', '2', '饿了么', '兜售里面的快递员', '10010');
INSERT INTO `goods_category` VALUES ('7', '2020-11-24 21:00:34', '10012', '2020-11-24 21:00:34', '10012', '1', '汉堡', '汉堡类', '10012');
INSERT INTO `goods_category` VALUES ('8', '2020-11-24 21:00:48', '10012', '2020-11-24 21:00:48', '10012', '1', '小吃', '薯条麦乐鸡', '10012');
INSERT INTO `goods_category` VALUES ('9', '2020-11-24 21:01:00', '10012', '2020-11-24 21:01:00', '10012', '1', '饮料', '喝的呀', '10012');
INSERT INTO `goods_category` VALUES ('10', '2020-11-24 21:08:27', '10013', '2020-11-24 21:08:27', '10013', '1', '汉堡', '1', '10013');
INSERT INTO `goods_category` VALUES ('11', '2020-11-24 21:08:56', '10013', '2020-11-24 21:08:56', '10013', '1', '小吃', '2', '10013');
INSERT INTO `goods_category` VALUES ('12', '2020-11-24 21:09:00', '10013', '2020-11-24 21:09:00', '10013', '1', '饮料', '3', '10013');
INSERT INTO `goods_category` VALUES ('13', '2020-11-24 21:15:12', '10014', '2020-11-24 21:15:12', '10014', '1', '披萨', '各种披萨', '10014');
INSERT INTO `goods_category` VALUES ('14', '2020-11-24 21:15:30', '10014', '2020-11-24 21:15:30', '10014', '1', '小吃', '各种小吃', '10014');
INSERT INTO `goods_category` VALUES ('15', '2020-11-24 21:15:43', '10014', '2020-11-24 21:15:43', '10014', '1', '饮料', '各种饮料', '10014');

-- ----------------------------
-- Table structure for goods_manage
-- ----------------------------
DROP TABLE IF EXISTS `goods_manage`;
CREATE TABLE `goods_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `goods_price` decimal(10,2) DEFAULT NULL COMMENT '产品价格',
  `goods_numbers` int(10) DEFAULT NULL COMMENT '商品库存数量',
  `goods_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类id',
  `goods_sale_status` int(1) DEFAULT NULL COMMENT '上下架状态 1上架 2下架',
  `goods_brief` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '商品描述',
  `business_id` bigint(20) DEFAULT NULL COMMENT '商家的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of goods_manage
-- ----------------------------
INSERT INTO `goods_manage` VALUES ('2', '2020-11-23 16:36:06', '10010', '2020-11-24 19:12:37', '10010', '2', '旺旺碎冰冰', '5.50', '500', '4', '1', '旺旺碎冰冰呀呀呀呀呀', '10010');
INSERT INTO `goods_manage` VALUES ('3', '2020-11-24 08:16:36', '10010', '2020-11-24 15:23:25', '10010', '1', '跳跳糖', '3.00', '300', '5', '1', '跳跳糖啊', '10010');
INSERT INTO `goods_manage` VALUES ('4', '2020-11-24 19:37:15', '10010', '2020-11-24 19:37:15', '10010', '1', '旺旺碎冰冰', '12.00', '12', '1', '1', '123', '10010');
INSERT INTO `goods_manage` VALUES ('5', '2020-11-24 19:39:56', '10010', '2020-11-24 19:57:03', '10010', '1', '海牛', '15.00', '13', '4', '1', '1234', '10010');
INSERT INTO `goods_manage` VALUES ('6', '2020-11-24 19:40:24', '10010', '2020-11-24 20:05:56', '10010', '1', '王德发', '50.00', '20', '3', '1', '海王', '10010');
INSERT INTO `goods_manage` VALUES ('7', '2020-11-24 20:05:00', '10010', '2020-11-24 20:29:20', '10010', '2', '戒指', '15000.00', '2', '6', '1', 's', '10010');
INSERT INTO `goods_manage` VALUES ('8', '2020-11-24 21:01:32', '10012', '2020-11-24 21:01:32', '10012', '1', '香辣鸡腿堡', '10.00', '100', '7', '1', '香辣鸡腿堡哟', '10012');
INSERT INTO `goods_manage` VALUES ('9', '2020-11-24 21:01:53', '10012', '2020-11-24 21:01:53', '10012', '1', '麦香鱼', '8.00', '100', '7', '1', '麦香鱼啊', '10012');
INSERT INTO `goods_manage` VALUES ('10', '2020-11-24 21:02:14', '10012', '2020-11-24 21:02:14', '10012', '1', '巨无霸', '12.00', '200', '7', '1', 'BigMac', '10012');
INSERT INTO `goods_manage` VALUES ('11', '2020-11-24 21:02:46', '10012', '2020-11-24 21:02:46', '10012', '1', '板烧鸡腿堡', '12.50', '140', '7', '1', '板烧鸡腿堡呀', '10012');
INSERT INTO `goods_manage` VALUES ('12', '2020-11-24 21:03:17', '10012', '2020-11-24 21:03:17', '10012', '1', '小薯条', '7.00', '30', '8', '1', 'x', '10012');
INSERT INTO `goods_manage` VALUES ('13', '2020-11-24 21:03:36', '10012', '2020-11-24 21:03:36', '10012', '1', '中薯条', '9.00', '50', '8', '1', 'z', '10012');
INSERT INTO `goods_manage` VALUES ('14', '2020-11-24 21:04:05', '10012', '2020-11-24 21:04:05', '10012', '1', '大薯条', '10.00', '50', '8', '1', 'd', '10012');
INSERT INTO `goods_manage` VALUES ('15', '2020-11-24 21:04:39', '10012', '2020-11-24 21:04:39', '10012', '1', '麦乐鸡块4', '10.00', '50', '8', '1', '1', '10012');
INSERT INTO `goods_manage` VALUES ('16', '2020-11-24 21:05:11', '10012', '2020-11-24 21:05:11', '10012', '1', '麦乐鸡块5', '10.50', '60', '8', '1', '5', '10012');
INSERT INTO `goods_manage` VALUES ('17', '2020-11-24 21:05:36', '10012', '2020-11-24 21:05:36', '10012', '1', '小可乐', '6.00', '90', '9', '1', 'x', '10012');
INSERT INTO `goods_manage` VALUES ('18', '2020-11-24 21:05:55', '10012', '2020-11-24 21:05:55', '10012', '1', '中可乐', '7.00', '60', '9', '1', 'a', '10012');
INSERT INTO `goods_manage` VALUES ('19', '2020-11-24 21:06:38', '10012', '2020-11-24 21:06:38', '10012', '1', '大可乐', '10.00', '90', '9', '1', 'p', '10012');
INSERT INTO `goods_manage` VALUES ('20', '2020-11-24 21:07:09', '10012', '2020-11-24 21:07:09', '10012', '1', '大雪碧英雄联盟限定版', '20.00', '2', '9', '1', '英雄联盟限定版送专属皮肤', '10012');
INSERT INTO `goods_manage` VALUES ('21', '2020-11-24 21:09:29', '10013', '2020-11-24 21:09:29', '10013', '1', '麦辣鸡腿堡', '10.50', '99', '10', '1', '1', '10013');
INSERT INTO `goods_manage` VALUES ('22', '2020-11-24 21:09:52', '10013', '2020-11-24 21:09:52', '10013', '1', '麦香鱼', '7.00', '60', '10', '1', '2', '10013');
INSERT INTO `goods_manage` VALUES ('23', '2020-11-24 21:10:14', '10013', '2020-11-24 21:10:14', '10013', '1', '板烧鸡腿堡', '12.00', '64', '10', '1', '1', '10013');
INSERT INTO `goods_manage` VALUES ('24', '2020-11-24 21:10:35', '10013', '2020-11-24 21:10:35', '10013', '1', '大可乐', '9.00', '90', '12', '1', '1', '10013');
INSERT INTO `goods_manage` VALUES ('25', '2020-11-24 21:11:02', '10013', '2020-11-24 21:11:52', '10013', '1', '大雪碧', '9.00', '90', '12', '1', '123', '10013');
INSERT INTO `goods_manage` VALUES ('26', '2020-11-24 21:12:22', '10013', '2020-11-24 21:12:22', '10013', '1', '安心油条', '6.00', '999', '11', '1', '安心油条创始人', '10013');
INSERT INTO `goods_manage` VALUES ('27', '2020-11-24 21:13:04', '10013', '2020-11-24 21:13:04', '10013', '1', '薯条', '9.00', '99', '11', '1', '薯条哦', '10013');
INSERT INTO `goods_manage` VALUES ('28', '2020-11-24 21:16:26', '10014', '2020-11-24 21:16:26', '10014', '1', '榴莲披萨9寸', '45.00', '99', '13', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('29', '2020-11-24 21:16:44', '10014', '2020-11-24 21:16:53', '10014', '1', '榴莲披萨13寸', '60.00', '90', '13', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('30', '2020-11-24 21:17:15', '10014', '2020-11-24 21:17:15', '10014', '1', '四季披萨9寸', '48.00', '56', '13', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('31', '2020-11-24 21:17:35', '10014', '2020-11-24 21:17:35', '10014', '1', '意大利披萨12寸', '60.00', '50', '13', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('32', '2020-11-24 21:18:24', '10014', '2020-11-24 21:18:30', '10014', '1', '大可乐', '7.00', '50', '15', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('33', '2020-11-24 21:18:43', '10014', '2020-11-24 21:18:43', '10014', '1', '大雪碧', '7.00', '70', '15', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('34', '2020-11-24 21:18:57', '10014', '2020-11-24 21:18:57', '10014', '1', '薯条', '12.00', '60', '14', '1', '', '10014');
INSERT INTO `goods_manage` VALUES ('35', '2020-11-24 21:19:19', '10014', '2020-11-24 21:19:19', '10014', '1', '炸物拼盘', '15.00', '60', '14', '1', '', '10014');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `order_uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
  `order_status` int(10) DEFAULT NULL COMMENT '订单状态',
  `refund_order_status` int(10) DEFAULT NULL COMMENT '退款单状态',
  `business_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '顾客地址',
  `customer_phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '顾客电话',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '顾客名称',
  `deliveryman_id` bigint(20) DEFAULT NULL COMMENT '骑手id',
  `customer_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '顾客备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('4', '2020-12-05 16:23:53', '10009', '2020-12-05 16:23:53', '10009', '1', '73496952943181807043', '2', null, '10014', '君豪中心1楼', '10008112', '苏先生', null, '一顿辣椒');
INSERT INTO `order` VALUES ('5', '2020-12-05 16:39:25', '10009', '2020-12-05 16:39:25', '10009', '1', '61647937311460377336', '1', null, '10014', '麦当劳隔壁', '12684984', '小苏', null, '');
INSERT INTO `order` VALUES ('6', '2020-12-08 20:47:56', '10009', '2020-12-08 20:47:56', '10009', '1', '68767317095441470072', '2', null, '10012', 'M78', '1324659784', '苏超人', null, '10包番茄酱');

-- ----------------------------
-- Table structure for order_subform
-- ----------------------------
DROP TABLE IF EXISTS `order_subform`;
CREATE TABLE `order_subform` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(255) DEFAULT NULL COMMENT '创建人',
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(255) DEFAULT NULL COMMENT '更新人',
  `delete_status` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据是否有效，1 有效 （未删除）  2 无效（删除）',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品ID',
  `goods_category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品分类名称',
  `goods_number` int(10) DEFAULT NULL COMMENT '购买数量',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
  `goods_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  `order_uuid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_subform
-- ----------------------------
INSERT INTO `order_subform` VALUES ('3', '2020-12-05 16:23:53', '10009', '2020-12-05 16:23:53', '10009', '1', '29', '披萨', '10', '榴莲披萨13寸', '60.00', '73496952943181807043');
INSERT INTO `order_subform` VALUES ('4', '2020-12-05 16:39:25', '10009', '2020-12-05 16:39:25', '10009', '1', '29', '披萨', '10', '榴莲披萨13寸', '60.00', '61647937311460377336');
INSERT INTO `order_subform` VALUES ('5', '2020-12-08 20:47:56', '10009', '2020-12-08 20:47:56', '10009', '1', '17', '饮料', '5', '小可乐', '6.00', '68767317095441470072');
INSERT INTO `order_subform` VALUES ('6', '2020-12-08 20:47:56', '10009', '2020-12-08 21:19:58', '10009', '1', '11', '汉堡', '3', '板烧鸡腿堡', '12.50', '68767317095441470072');

-- ----------------------------
-- Table structure for status_code_name
-- ----------------------------
DROP TABLE IF EXISTS `status_code_name`;
CREATE TABLE `status_code_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_status_code` int(11) DEFAULT NULL,
  `goods_status_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of status_code_name
-- ----------------------------
INSERT INTO `status_code_name` VALUES ('1', '1', '上架');
INSERT INTO `status_code_name` VALUES ('2', '2', '下架');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` bigint(11) NOT NULL DEFAULT '0' COMMENT '自定id,主要供前端展示权限列表分类排序使用.',
  `menu_code` varchar(255) DEFAULT '' COMMENT '归属菜单,前端判断并展示菜单使用,',
  `menu_name` varchar(255) DEFAULT '' COMMENT '菜单的中文释义',
  `permission_code` varchar(255) DEFAULT '' COMMENT '权限的代码/通配符,对应代码中@RequiresPermissions 的value',
  `permission_name` varchar(255) DEFAULT '' COMMENT '本权限的中文释义',
  `required_permission` tinyint(1) DEFAULT '2' COMMENT '是否本菜单必选权限, 1.必选 2非必选 通常是"列表"权限是必选',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('101', 'article', '文章管理', 'article:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('102', 'article', '文章管理', 'article:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('103', 'article', '文章管理', 'article:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('601', 'user', '用户', 'user:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('602', 'user', '用户', 'user:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('603', 'user', '用户', 'user:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('701', 'role', '角色权限', 'role:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('702', 'role', '角色权限', 'role:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('703', 'role', '角色权限', 'role:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('704', 'role', '角色权限', 'role:delete', '删除', '2');
INSERT INTO `sys_permission` VALUES ('801', 'order', '订单', 'order:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('802', 'order', '订单', 'order:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('803', 'order', '订单', 'order:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('901', 'businessInfo', '商家信息', 'businessInfo:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('902', 'businessInfo', '商家信息', 'businessInfo:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('903', 'businessInfo', '商家信息', 'businessInfo:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1001', 'customerInfo', '顾客信息', 'customerInfo:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1002', 'customerInfo', '顾客信息', 'customerInfo:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1003', 'customerInfo', '顾客信息', 'customerInfo:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1101', 'goodsCategory', '类目管理', 'goodsCategory:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1102', 'goodsCategory', '类目管理', 'goodsCategory:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1103', 'goodsCategory', '类目管理', 'goodsCategory:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1201', 'goodsManage', '商品管理', 'goodsManage:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1202', 'goodsManage', '商品管理', 'goodsManage:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1203', 'goodsManage', '商品管理', 'goodsManage:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1301', 'viewGoods', '商品浏览', 'viewGoods:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1302', 'viewGoods', '商品浏览', 'viewGoods:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1303', 'viewGoods', '商品浏览', 'viewGoods:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1401', 'viewBusiness', '浏览商家信息', 'viewBusiness:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1402', 'viewBusiness', '浏览商家信息', 'viewBusiness:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1403', 'viewBusiness', '浏览商家信息', 'viewBusiness:update', '修改', '2');
INSERT INTO `sys_permission` VALUES ('1501', 'customerAddress', '地址管理', 'customerAddress:list', '列表', '1');
INSERT INTO `sys_permission` VALUES ('1502', 'customerAddress', '地址管理', 'customerAddress:add', '新增', '2');
INSERT INTO `sys_permission` VALUES ('1503', 'customerAddress', '地址管理', 'customerAddress:update', '修改', '2');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', '2017-11-22 16:24:34', '2017-11-22 16:24:52', '1');
INSERT INTO `sys_role` VALUES ('2', '作家', '2017-11-22 16:24:34', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role` VALUES ('3', '程序员', '2017-11-22 16:28:47', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role` VALUES ('4', '路人甲', '2020-11-08 16:22:17', '2020-11-21 11:19:25', '1');
INSERT INTO `sys_role` VALUES ('5', '路人乙', '2020-11-08 16:36:50', '2020-11-19 08:03:23', '2');
INSERT INTO `sys_role` VALUES ('6', '商家', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role` VALUES ('7', '顾客', '2020-11-21 11:13:37', '2020-11-21 11:13:37', '1');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(11) DEFAULT NULL COMMENT '角色id',
  `permission_id` bigint(11) DEFAULT NULL COMMENT '权限id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效 1有效     2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='角色-权限关联表';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '2', '101', '2017-11-22 16:26:21', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('2', '2', '102', '2017-11-22 16:26:21', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('5', '2', '602', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('6', '2', '601', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('7', '2', '603', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('8', '2', '703', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('9', '2', '701', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('10', '2', '702', '2017-11-22 16:28:28', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('11', '2', '704', '2017-11-22 16:28:31', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('12', '2', '103', '2017-11-22 16:28:31', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('13', '3', '601', '2017-11-22 16:28:47', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('14', '3', '701', '2017-11-22 16:28:47', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('15', '3', '702', '2017-11-22 16:35:01', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('16', '3', '704', '2017-11-22 16:35:01', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('17', '3', '102', '2017-11-22 16:35:01', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('18', '3', '101', '2017-11-22 16:35:01', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('19', '3', '603', '2017-11-22 16:35:01', '2020-11-21 11:08:29', '2');
INSERT INTO `sys_role_permission` VALUES ('20', '4', '101', '2020-11-08 16:22:17', '2020-11-08 16:35:29', '2');
INSERT INTO `sys_role_permission` VALUES ('21', '5', '101', '2020-11-08 16:36:50', '2020-11-08 16:36:50', '1');
INSERT INTO `sys_role_permission` VALUES ('22', '5', '601', '2020-11-08 16:36:50', '2020-11-13 21:31:59', '2');
INSERT INTO `sys_role_permission` VALUES ('23', '5', '701', '2020-11-08 16:36:50', '2020-11-13 21:31:59', '2');
INSERT INTO `sys_role_permission` VALUES ('24', '5', '801', '2020-11-13 16:35:10', '2020-11-13 16:35:55', '2');
INSERT INTO `sys_role_permission` VALUES ('25', '5', '801', '2020-11-13 17:20:15', '2020-11-13 17:20:46', '2');
INSERT INTO `sys_role_permission` VALUES ('26', '5', '801', '2020-11-13 21:31:59', '2020-11-14 08:52:11', '2');
INSERT INTO `sys_role_permission` VALUES ('27', '5', '802', '2020-11-13 21:31:59', '2020-11-14 08:40:15', '2');
INSERT INTO `sys_role_permission` VALUES ('28', '5', '803', '2020-11-13 21:31:59', '2020-11-14 08:40:15', '2');
INSERT INTO `sys_role_permission` VALUES ('29', '2', '801', '2020-11-14 08:51:29', '2020-11-14 08:52:39', '2');
INSERT INTO `sys_role_permission` VALUES ('30', '2', '801', '2020-11-14 08:53:17', '2020-11-21 11:08:31', '2');
INSERT INTO `sys_role_permission` VALUES ('31', '6', '901', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role_permission` VALUES ('32', '6', '902', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role_permission` VALUES ('33', '6', '903', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role_permission` VALUES ('34', '6', '801', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role_permission` VALUES ('35', '6', '802', '2020-11-21 11:13:30', '2020-12-02 08:20:20', '2');
INSERT INTO `sys_role_permission` VALUES ('36', '6', '803', '2020-11-21 11:13:30', '2020-11-21 11:13:30', '1');
INSERT INTO `sys_role_permission` VALUES ('37', '7', '1001', '2020-11-21 11:13:37', '2020-11-21 11:13:37', '1');
INSERT INTO `sys_role_permission` VALUES ('38', '7', '1002', '2020-11-21 11:13:37', '2020-11-21 11:13:37', '1');
INSERT INTO `sys_role_permission` VALUES ('39', '7', '1003', '2020-11-21 11:13:37', '2020-11-21 11:13:37', '1');
INSERT INTO `sys_role_permission` VALUES ('40', '6', '1101', '2020-11-22 10:56:47', '2020-11-22 10:56:47', '1');
INSERT INTO `sys_role_permission` VALUES ('41', '6', '1102', '2020-11-22 10:56:47', '2020-11-22 10:56:47', '1');
INSERT INTO `sys_role_permission` VALUES ('42', '6', '1103', '2020-11-22 10:56:47', '2020-11-22 10:56:47', '1');
INSERT INTO `sys_role_permission` VALUES ('43', '6', '1201', '2020-11-23 20:59:03', '2020-11-23 20:59:03', '1');
INSERT INTO `sys_role_permission` VALUES ('44', '6', '1202', '2020-11-23 20:59:03', '2020-11-23 20:59:03', '1');
INSERT INTO `sys_role_permission` VALUES ('45', '6', '1203', '2020-11-23 20:59:03', '2020-11-23 20:59:03', '1');
INSERT INTO `sys_role_permission` VALUES ('46', '7', '1301', '2020-11-24 21:52:33', '2020-11-24 21:52:33', '1');
INSERT INTO `sys_role_permission` VALUES ('47', '7', '1303', '2020-11-24 21:52:33', '2020-11-24 21:52:33', '1');
INSERT INTO `sys_role_permission` VALUES ('48', '6', '1301', '2020-11-24 21:52:41', '2020-11-24 21:52:41', '1');
INSERT INTO `sys_role_permission` VALUES ('49', '4', '1301', '2020-11-24 21:52:51', '2020-11-24 21:52:51', '1');
INSERT INTO `sys_role_permission` VALUES ('50', '7', '1401', '2020-11-28 09:45:10', '2020-11-28 09:45:10', '1');
INSERT INTO `sys_role_permission` VALUES ('51', '6', '1401', '2020-11-28 09:45:16', '2020-11-28 09:45:16', '1');
INSERT INTO `sys_role_permission` VALUES ('52', '7', '1501', '2020-12-01 20:22:44', '2020-12-01 20:22:44', '1');
INSERT INTO `sys_role_permission` VALUES ('53', '7', '1502', '2020-12-01 20:22:44', '2020-12-01 20:22:44', '1');
INSERT INTO `sys_role_permission` VALUES ('54', '7', '1503', '2020-12-01 20:22:44', '2020-12-01 20:22:44', '1');
INSERT INTO `sys_role_permission` VALUES ('55', '7', '801', '2020-12-02 08:20:11', '2020-12-02 08:20:11', '1');
INSERT INTO `sys_role_permission` VALUES ('56', '7', '803', '2020-12-02 08:20:11', '2020-12-02 08:20:11', '1');
INSERT INTO `sys_role_permission` VALUES ('57', '7', '802', '2020-12-02 08:20:24', '2020-12-02 08:20:24', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `role_id` int(11) DEFAULT '0' COMMENT '角色ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10015 DEFAULT CHARSET=utf8 COMMENT='运营后台用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('10003', 'admin', '123456', '超级用户23', '1', '2017-10-30 11:52:38', '2017-11-17 23:51:40', '1');
INSERT INTO `sys_user` VALUES ('10004', 'user', '123456', '莎士比亚', '2', '2017-10-30 16:13:02', '2020-11-21 11:08:01', '2');
INSERT INTO `sys_user` VALUES ('10005', 'aaa', '123456', 'abba', '4', '2017-11-15 14:02:56', '2020-11-08 16:35:08', '2');
INSERT INTO `sys_user` VALUES ('10007', 'test', '123456', '就看看列表', '3', '2017-11-22 16:29:41', '2020-11-21 11:08:04', '2');
INSERT INTO `sys_user` VALUES ('10008', 'aaa', '123456', '啊啊啊', '5', '2020-11-08 16:37:49', '2020-11-21 11:08:06', '2');
INSERT INTO `sys_user` VALUES ('10009', 'Susan', '123456', '苏神', '7', '2020-11-21 12:29:22', '2020-11-21 12:29:22', '1');
INSERT INTO `sys_user` VALUES ('10010', 'meituan', '123456', '美团', '6', '2020-11-21 12:30:24', '2020-11-21 12:30:24', '1');
INSERT INTO `sys_user` VALUES ('10011', 'eleme', '123456', '饿了么', '6', '2020-11-23 11:03:24', '2020-11-23 11:03:24', '1');
INSERT INTO `sys_user` VALUES ('10012', 'McDonal', '123456', '麦当劳', '6', '2020-11-24 20:57:53', '2020-11-24 20:57:53', '1');
INSERT INTO `sys_user` VALUES ('10013', 'kfc', '123456', '肯德基', '6', '2020-11-24 20:58:25', '2020-11-24 20:58:25', '1');
INSERT INTO `sys_user` VALUES ('10014', 'pizza', '123456', '尊宝披萨', '6', '2020-11-24 20:59:14', '2020-11-24 20:59:14', '1');

-- ----------------------------
-- View structure for order_subform_info
-- ----------------------------
DROP VIEW IF EXISTS `order_subform_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_subform_info` AS select `order_subform`.`order_uuid` AS `order_uuid`,`order_subform`.`goods_id` AS `goods_id`,`order_subform`.`goods_name` AS `goods_name`,`order_subform`.`goods_category_name` AS `category_name`,`order_subform`.`goods_price` AS `goods_price`,`order_subform`.`goods_number` AS `goods_number`,(`order_subform`.`goods_number` * `order_subform`.`goods_price`) AS `item_total_price`,`order_subform`.`delete_status` AS `delete_status` from `order_subform` ;

-- ----------------------------
-- View structure for order_total
-- ----------------------------
DROP VIEW IF EXISTS `order_total`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_total` AS select `order_subform_info`.`order_uuid` AS `order_uuid`,sum(`order_subform_info`.`item_total_price`) AS `order_total` from `order_subform_info` group by `order_subform_info`.`order_uuid` ;
