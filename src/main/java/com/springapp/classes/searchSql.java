package com.springapp.classes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by sgl on 2017/12/3.
 */
public class searchSql {
    public String getSession(HttpServletRequest request){
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql = "";
        if(power.equals("admin")){
            return " and 1 = 1";
        } else {
            sql += " and reportPlace = '"+place+"' and subPlace like '%"+ subPlace +"'";
            return sql;
        }
    }
    public String getSessionSubPlace(HttpServletRequest request){
        HttpSession session= request.getSession();
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql = "";
        if(power.equals("admin")){
            return " and 1 = 1";
        } else {
            sql += "and subPlace like '%"+ subPlace +"'";
            return sql;
        }
    }
    public String getSessionEqual(HttpServletRequest request){
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql = "";
        if(power.equals("admin")){
            return " and 1 = 1";
        } else {
            sql += " and reportPlace = '"+place+"' and subPlace = '"+ setSubPlace(subPlace) +"'";
            return sql;
        }
    }

    public String setSubPlace(String subPlace) {
        char [] sub = subPlace.toCharArray();
        String SUBPLACE ="";
        for(int i=0;i<sub.length;i++){
            if(sub[i] == '￥'){
                for(int j=i+1;j<sub.length;j++) {
                    SUBPLACE += sub[j];
                }
                break;
            }
        }
        return SUBPLACE;
    }
}
