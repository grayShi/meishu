package com.springapp.mvc;

import com.springapp.entity.examPlace;
import com.springapp.entity.message;
import com.springapp.entity.reportPlace;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.springapp.entity.time;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class place1Controller extends  BaseController{
    @RequestMapping(value="/place1",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView){
        List<examPlace> place=examPlaceDao.findAll("from examPlace");
        modelAndView.addObject("place",place);
        String placeList = JSONArray.fromObject(place).toString();
        modelAndView.addObject("placeList",placeList);
        modelAndView.setViewName("place1");
        return modelAndView;
    }
    @RequestMapping(value="/place1-edit",method = RequestMethod.GET)
    public ModelAndView home1(@RequestParam(value = "id") Long id){
        ModelAndView modelAndView = new ModelAndView();
        List<examPlace> placeEdit=examPlaceDao.findAll("from examPlace where id =" + id);
        modelAndView.addObject("placeEdit", placeEdit);
        List<reportPlace> place=reportPlaceDao.findAll("select distinct place from reportPlace where isDelete = 0");
        modelAndView.addObject("place",place);
        modelAndView.addObject("id", id);
        modelAndView.setViewName("place1-edit");
        return modelAndView;
    }
    @RequestMapping(value="/place1-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value="count")int count,
                        @RequestParam(value = "reportPlace") String reportPlace,@RequestParam(value = "subPlace") String subPlace,
                        @RequestParam(value = "place") String place,@RequestParam(value = "classPlace") String classPlace,@RequestParam(value = "remark") String remark, HttpServletRequest request){
        Long examPlaceCount = examPlaceDao.getCount("select count (*) from examPlace where place ='"+place+"' and classPlace = '"+classPlace+"'",request);
        if(examPlaceCount <= 1) {
            examPlace exam = examPlaceDao.getId(id).get(0);
            String originalPlace = exam.getPlace();
            String originalClassPlace = exam .getClassPlace();
            int originalCount = exam.getCount();
            List<message>messageList = messageDao.findAll("from message where examPlace = '"+originalPlace+"' and classPlace = '"+originalClassPlace +"'");
            if(messageList.size() <= count) {
                for(message mes:messageList){
                    mes.setExamPlace(place);
                    mes.setClassPlace(classPlace);
                }
                messageDao.update(messageList,request);
                List<time> timeList = timeDao.findAll("from time where place = '" + exam.getPlace() + "' and classPlace = '" + exam.getClassPlace() + "'");
                if (timeList.size() != 0) {
                    for (time x : timeList) {
                        x.setPlace(place);
                        x.setClassPlace(classPlace);
                        x.setCount(count);
                    }
                    timeDao.update(timeList,request);
                }
                exam.setPlace(place);
                exam.setClassPlace(classPlace);
                exam.setCount(count);
                exam.setRemark(remark);
                exam.setReportPlace(reportPlace);
                exam.setSubPlace(subPlace);
                reportPlaceDao.update(exam,request);
                return "success";
            }else
                return messageList.size()+"";
        }else{
            return "is_exist";
        }
    }
    @RequestMapping(value="/place1-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        examPlaceDao.delete(examPlace.class,id,request);
        return "success";
    }
    @RequestMapping(value="/place1-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView){
        List<reportPlace> place=reportPlaceDao.findAll("select distinct place from reportPlace where isDelete = 0");
        modelAndView.addObject("place",place);
        modelAndView.setViewName("place1-add");
        return modelAndView;
    }
    @RequestMapping(value="/place1-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value="count")int count, @RequestParam(value = "place") String place,
                       @RequestParam(value = "classPlace") String classPlace, @RequestParam(value = "remark") String remark,
                       @RequestParam(value = "reportPlace") String reportPlace, @RequestParam(value = "subPlace") String subPlace){
        Long examPlaceCount = examPlaceDao.getCount("select count (*) from examPlace where place ='"+place+"' and classPlace = '"+classPlace+"'",request);
        if(examPlaceCount == 0) {
            examPlace exam = new examPlace();
            exam.setPlace(place);
            exam.setClassPlace(classPlace);
            exam.setCount(count);
            exam.setRemark(remark);
            exam.setReportPlace(reportPlace);
            exam.setSubPlace(subPlace);
            examPlaceDao.save(exam,request);
            return "success";
        }
        else
            return "is_exist";
    }
}
