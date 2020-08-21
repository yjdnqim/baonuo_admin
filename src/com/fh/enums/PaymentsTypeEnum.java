package com.fh.enums;

import com.fh.util.PageData;

import java.util.ArrayList;
import java.util.List;

public enum PaymentsTypeEnum {
    ZHICHU(1,"支出"),
    SHOURI(2,"收入");

    private int value;
    private String desc;

    PaymentsTypeEnum(int value, String desc) {
        this.value = value;
        this.desc = desc;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    /**
     * 根据value获取描述
     * @param value
     * @return
     */
    public static String getDescByValue(int value){
        for(PaymentsTypeEnum enumItem : PaymentsTypeEnum.values()){
            if(enumItem.getValue() == value){
                return enumItem.getDesc();
            }
        }
        return "";
    }

    /**
     * 获取状态列表
     * @return
     */
    public static List<PageData> getList(){
        List<PageData> pdList = new ArrayList<PageData>();
        for(PaymentsTypeEnum enumItem : PaymentsTypeEnum.values()){
            PageData pd = new PageData();
            pd.put("VALUE", enumItem.getValue());
            pd.put("DESC", enumItem.getDesc());
            pdList.add(pd);
        }

        return pdList;
    }
}
