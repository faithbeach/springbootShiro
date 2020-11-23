package com.heeexy.example.util.constants;

public enum DeleteStatus {

    NORMAL("1","正常"),
    DELETE("2","删除")

    ;

    DeleteStatus(String code, String name) {
        this.code = code;
        this.name = name;
    }

    private String code;
    private String name;

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
