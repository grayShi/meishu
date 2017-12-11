package com.springapp.mvc;

import com.springapp.classes.searchSql;
import com.springapp.entity.examPlace;
import com.springapp.entity.message;
import com.springapp.entity.time;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by sgl on 2017/8/13.
 */
@Controller
public class forPersonController extends BaseController{
    @RequestMapping(value = "/forPerson",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<message> message = messageDao.findAll("from message where isDelete = 0 "+ sql);
        modelAndView.addObject("message",message);
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql1 = "";
        if(power.equals("admin")){
            sql1 += " and 1 = 1";
        } else {
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
            sql1 += "and examPlace.reportPlace = '"+place+"' and examPlace.subPlace = '"+ SUBPLACE +"'";
        }
        List<time> timeList = timeDao.findAll("select time from time as time,examPlace as examPlace where " +
                "time.place = examPlace.place and time.classPlace = examPlace.classPlace "+ sql1);
        modelAndView.addObject("timeList",timeList);
        List<examPlace> examPlaceList = examPlaceDao.findAll("from examPlace where 1 = 1 " + sql);
        modelAndView.addObject("examPlaceList",examPlaceList);
        String[]nameBirth = new String[message.size()];
        for(int i = 0;i<message.size();i++){
            nameBirth[i]=message.get(i).getName()+"-"+message.get(i).getBirth();

        }
        modelAndView.addObject("nameBirth",JSONArray.fromObject(nameBirth).toString());
        modelAndView.setViewName("forPerson");
        return modelAndView;
    }
    @RequestMapping(value="/forPerson-startExam",method = RequestMethod.POST)
    @ResponseBody
    public String startExam(@RequestParam(value = "nameList") String[] nameList,@RequestParam(value = "birthList") String[] birthList,
                       @RequestParam(value = "examPlace") String  examPlace,@RequestParam(value = "classPlace") String  classPlace,
                            @RequestParam(value = "time") String  time){
        String sql = "and (";
        for(int i=0;i<nameList.length;i++){
            sql+="(name = '"+nameList[i]+"' and birth ='"+birthList[i]+"')";
            if(i+1 != nameList.length)
                sql +=" or ";
        }
        sql+=")";
        List<message> messageList = messageDao.findAll("from message where isDelete = 0 "+sql);
        for(message message:messageList){
            message.setExamPlace(examPlace);
            message.setClassPlace(classPlace);
            message.setTime(time);
        }
        messageDao.update(messageList);
        return "success";
    }
    @RequestMapping(value="/forPerson-setExamPlace",method = RequestMethod.POST)
    @ResponseBody
    public String setExamPlace(HttpServletRequest request, @RequestParam(value = "time") String  time){
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql1 = "";
        if(power.equals("admin")){
            sql1 += " and 1 = 1";
        } else {
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
            sql1 += "and examPlace.reportPlace = '"+place+"' and examPlace.subPlace = '"+ SUBPLACE +"'";
        }
        List<time> timeList = timeDao.findAll("select time from time as time,examPlace as examPlace where time.startTime = '"+time+"'" +
                "and time.place = examPlace.place and time.classPlace = examPlace.classPlace "+ sql1);
        return JSONArray.fromObject(timeList).toString();
    }
}
