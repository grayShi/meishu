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
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
@RequestMapping(value = "**")
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
        modelAndView.addObject("id", id);
        modelAndView.setViewName("place1-edit");
        return modelAndView;
    }
    @RequestMapping(value="/place1-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value="count")int count,@RequestParam(value = "place") String place,@RequestParam(value = "classPlace") String classPlace,@RequestParam(value = "remark") String remark){
        Long examPlaceCount = examPlaceDao.getCount("select count (*) from examPlace where place ='"+place+"' and classPlace = '"+classPlace+"'");
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
                messageDao.update(messageList);
                List<time> timeList = timeDao.findAll("from time where place = '" + exam.getPlace() + "' and classPlace = '" + exam.getClassPlace() + "'");
                if (timeList.size() != 0) {
                    for (time x : timeList) {
                        x.setPlace(place);
                        x.setClassPlace(classPlace);
                        x.setCount(count);
                    }
                    timeDao.update(timeList);
                }
                exam.setPlace(place);
                exam.setClassPlace(classPlace);
                exam.setCount(count);
                exam.setRemark(remark);
                reportPlaceDao.update(exam);
                return "success";
            }else
                return messageList.size()+"";
        }else{
            return "is_exist";
        }
    }
    @RequestMapping(value="/place1-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id){
        examPlaceDao.delete(examPlace.class,id);
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
    public String add1(@RequestParam(value="count")int count,@RequestParam(value = "place") String place,@RequestParam(value = "classPlace") String classPlace,@RequestParam(value = "remark") String remark){
        Long examPlaceCount = examPlaceDao.getCount("select count (*) from examPlace where place ='"+place+"' and classPlace = '"+classPlace+"'");
        if(examPlaceCount == 0) {
            examPlace exam = new examPlace();
            exam.setPlace(place);
            exam.setClassPlace(classPlace);
            exam.setCount(count);
            exam.setRemark(remark);
            examPlaceDao.save(exam);
            return "success";
        }
        else
            return "is_exist";
    }
}
