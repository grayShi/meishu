package com.springapp.classes;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class log4j {
    public void printLog(String sql){
        Logger logger = Logger.getRootLogger();
//        HttpSession session= request.getSession();
//        String userId = (String) session.getAttribute("userId");
//        String username = (String) session.getAttribute("username");
//        String output = "("+username +" - "+ userId +")" + sql;
        logger.info(sql);
    }
}
