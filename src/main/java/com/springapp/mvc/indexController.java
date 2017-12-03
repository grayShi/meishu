package com.springapp.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by hello on 2016/7/5.
 */
@Controller

public class indexController extends BaseController{
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public ModelAndView home1(ModelAndView modelAndView){
        modelAndView.setViewName("index");
        return modelAndView;
    }
}
