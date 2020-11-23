package com.heeexy.example.util;

/**
 * @author: hxy
 * @date: 2017/10/24 10:16
 */
public class StringTools {

	public static boolean isNullOrEmpty(String str) {
		return null == str || "".equals(str.trim()) || "null".equals(str.trim());
	}

	public static boolean isNullOrEmpty(Object obj) {
		return null == obj || "".equals(obj);
	}
}
