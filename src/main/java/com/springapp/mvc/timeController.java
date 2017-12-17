package com.springapp.mvc;

import com.springapp.entity.examPlace;
import com.springapp.entity.message;
import com.springapp.entity.subject;
import com.springapp.entity.time;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class timeController extends BaseController{
    @RequestMapping(value="/time",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView, HttpServletRequest request){
        List<time> time=timeDao.findAll("from time",request);
        modelAndView.addObject("time",time);
        String timeList = JSONArray.fromObject(time).toString();
        modelAndView.addObject("timeList",timeList);
        modelAndView.setViewName("time");
        return modelAndView;
    }
    @RequestMapping(value="/time-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id, HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        List<time> timeList = timeDao.findAll("from time where id =" + id,request);
        List<examPlace> placeList= examPlaceDao.findAll("from examPlace where place !='"+timeList.get(0).getPlace()+"'",request);
        modelAndView.addObject("timeEdit", timeList);
        List<subject> placeList1= examPlaceDao.findAll("from examPlace where place ='"+timeList.get(0).getPlace()+"' and classPlace !='"+timeList.get(0).getClassPlace()+"'",request);
        modelAndView.addObject("placeList", placeList);
        modelAndView.addObject("placeList1", placeList1);
        modelAndView.addObject("id", id);
        modelAndView.setViewName("time-edit");
        return modelAndView;
    }
    @RequestMapping(value="/time-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value = "place") String place,@RequestParam(value = "classPlace") String classPlace,
                        @RequestParam(value = "startTime") String startTime, HttpServletRequest request){
        Long timeCount = timeDao.getCount("select count (*) from time where place ='"+place+"' and classPlace = '"+classPlace +"' and startTime = '"+startTime+"'",request);
        if(timeCount == 0) {
            time time = timeDao.getId(id,request).get(0);
            String originalPlace = time.getPlace();
            String originalClassPlace = time .getClassPlace();
            String originalStartTime = time.getStartTime();
            List<message>messageList = messageDao.findAll("from message where examPlace = '"+originalPlace+"' and classPlace = '"+originalClassPlace +"' and time = '"+originalStartTime+"'",request);
            for(message mes:messageList){
                mes.setExamPlace(place);
                mes.setClassPlace(classPlace);
                mes.setTime(startTime);
            }
            messageDao.update(messageList,request);
            time.setPlace(place);
            time.setClassPlace(classPlace);
            List<examPlace> countList = examPlaceDao.findAll("from examPlace where place = '" + place + "' and classPlace = '" + classPlace + "'",request);
            time.setCount(countList.get(0).getCount());
            time.setStartTime(startTime);

            timeDao.update(time,request);
            return "success";
        }else {
            return "is_exist";
        }
    }
    @RequestMapping(value="/time-edit-getClassPlace",method = RequestMethod.POST)
    @ResponseBody
    public String getLevel(@RequestParam(value = "place") String place, HttpServletRequest request){
        List<examPlace> placeList= examPlaceDao.findAll("from examPlace where place ='"+place+"'",request);
        return JSONArray.fromObject(placeList).toString();
    }
    @RequestMapping(value="/time-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        timeDao.delete(time.class,id,request);
        return "success";
    }
    @RequestMapping(value="/time-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView, HttpServletRequest request){
        List<examPlace> PlaceList= examPlaceDao.findAll("select distinct place from examPlace",request);
        modelAndView.addObject("PlaceList",PlaceList);
        modelAndView.setViewName("time-add");
        return modelAndView;
    }
    @RequestMapping(value="/time-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value = "place") String place, @RequestParam(value = "classPlace") String classPlace,
                       @RequestParam(value = "startTime") String startTime){
        Long timeCount = timeDao.getCount("select count (*) from time where place ='"+place+"' and classPlace = '"+classPlace +"' and startTime = '"+startTime+"'",request);
        if(timeCount == 0) {
            time time = new time();
            time.setPlace(place);
            time.setClassPlace(classPlace);
            List<examPlace> countList = examPlaceDao.findAll("from examPlace where place = '" + place + "' and classPlace = '" + classPlace + "'",request);
            time.setCount(countList.get(0).getCount());
            time.setStartTime(startTime);
            timeDao.save(time,request);
            return "success";
        }else
            return  "is_exist";
    }
}
