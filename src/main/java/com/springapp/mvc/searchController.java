package com.springapp.mvc;

import com.springapp.entity.message;
import com.springapp.entity.subject;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class searchController extends BaseController{
    @RequestMapping(value = "/search",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView) {
        List<subject> subjectList = subjectDao.findAll("from subject");
        modelAndView.addObject("subjectList",subjectList);
        modelAndView.setViewName("search");
        return modelAndView;
    }
    @RequestMapping(value="/search-getSearch",method = RequestMethod.POST)
    @ResponseBody
    public String getSearch(@RequestParam(value = "subject")String subject){
        List<message> messageList = messageDao.findAll("from message where isDelete = 0 and subject ='"+subject+"'");
        return JSONArray.fromObject(messageList).toString();
    }
}
