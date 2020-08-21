package com.fh.enums;

import com.fh.util.PageData;

import java.util.ArrayList;
import java.util.List;

public enum WorkerTypeEnum {
    SHEXIN("shexin","射芯"),
    LUGONG("lugong","炉工"),
    TAIBAO("taibao","抬包"),
    DAMO("damo","打磨"),
    PAOGUANG("paoguang","抛光");

    private String value;
    private String desc;

    WorkerTypeEnum(String value, String desc) {
        this.value = value;
        this.desc = desc;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
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
    public static String getDescByValue(String value){
        for(WorkerTypeEnum enumItem : WorkerTypeEnum.values()){
            if(enumItem.getValue().equals(value)){
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
        for(WorkerTypeEnum enumItem : WorkerTypeEnum.values()){
            PageData pd = new PageData();
            pd.put("VALUE", enumItem.getValue());
            pd.put("DESC", enumItem.getDesc());
            pdList.add(pd);
        }

        return pdList;
    }
}
