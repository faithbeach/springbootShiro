package com.heeexy.example.util.constants;

/**
 * @author: hxy
 * @date: 2017/10/24 10:16
 */
public enum ErrorEnum {
	/*
	 * 错误信息
	 * */
	E_400("400", "请求处理异常，请稍后再试"),
	E_500("500", "请求方式有误,请检查 GET/POST"),
	E_501("501", "请求路径不存在"),
	E_502("502", "权限不足"),
	E_10008("10008", "角色删除失败,尚有用户属于此角色"),
	E_10009("10009", "账户已存在"),
	E_10010("10010", "命名已被使用"),
	E_20011("20011", "登陆已过期,请重新登陆"),

	E_30009("30009", "命名已存在"),
	E_30010("30010", "仍有该分类的商品"),

	E_30011("30011", "没有符合检索项"),

	E_90003("90003", "缺少必填参数");

	private String errorCode;

	private String errorMsg;

	ErrorEnum(String errorCode, String errorMsg) {
		this.errorCode = errorCode;
		this.errorMsg = errorMsg;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

}