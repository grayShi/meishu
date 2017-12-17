package com.springapp.classes;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class log4j {
    public void printLog(String sql,HttpServletRequest request){
        Logger logger = Logger.getRootLogger();

        logger.info(getUserFromRequest(request) + sql);
    }
    public String getUserFromRequest(HttpServletRequest request){
        HttpSession session= request.getSession();
        String userId = (String) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        String power = (String) session.getAttribute("power");
        return "["+userId+" - "+ username + " - " +power +"] : ";
    }
}
