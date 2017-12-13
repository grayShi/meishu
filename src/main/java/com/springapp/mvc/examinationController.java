package com.springapp.mvc;

import com.springapp.classes.searchSql;
import com.springapp.entity.examPlace;
import com.springapp.entity.time;
import com.springapp.entity.message;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class examinationController extends BaseController {
    @RequestMapping(value = "/examination", method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql = "";
        if(power.equals("admin")){
            sql += " and 1 = 1";
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
            sql += "and examPlace.reportPlace = '"+place+"' and examPlace.subPlace = '"+ SUBPLACE +"'";
        }
        List<String> timeList = timeDao.findAll("select distinct time.startTime from time as time,examPlace as examPlace " +
                "where time.place = examPlace.place and time.classPlace = examPlace.classPlace "+ sql);
        modelAndView.addObject("timeList",timeList);
        modelAndView.setViewName("examination");
        return modelAndView;
    }
    @RequestMapping(value="/examination-getSearch",method = RequestMethod.POST)
    @ResponseBody
    public String getSearch(HttpServletRequest request){
        searchSql search = new searchSql();
        String sql1 = search.getSession(request);
        String sql="select distinct reportPlace,subPlace from message where isDelete = 0 and reportPlace IS NOT NULL and subPlace IS NOT NULL " + sql1;
        List<String> reportList = messageDao.findAll(sql);
        return JSONArray.fromObject(reportList).toString();
    }
    @RequestMapping(value="/examination-searchSubject",method = RequestMethod.POST)
    @ResponseBody
    public String searchPlace(@RequestParam(value = "reportPlace") String reportPlace,@RequestParam(value = "subPlace") String subPlace){
        List<String> placeList = messageDao.findAll("select distinct subject,level from message where isDelete = 0 and reportPlace ='"+reportPlace+"'and subPlace = '"+subPlace+"'");
        return JSONArray.fromObject(placeList).toString();
    }
    @RequestMapping(value="/examination-examPlace",method = RequestMethod.POST)
    @ResponseBody
    public String examPlace(HttpServletRequest request,@RequestParam(value = "time") String time){
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        String sql = "";
        if(power.equals("admin")){
            sql += " and 1 = 1";
        } else {
            sql += "and examPlace.reportPlace = '"+place+"' and examPlace.subPlace like '%"+ subPlace +"'";
        }
        List<time> timeList = timeDao.findAll("select time from time as time,examPlace as examPlace where time.startTime = '"+time+"'" +
                "and time.place = examPlace.place and time.classPlace = examPlace.classPlace "+ sql);
        return JSONArray.fromObject(timeList).toString();
    }
    @RequestMapping(value="/examination-getPlaceCount",method = RequestMethod.POST)
    @ResponseBody
    public String getPlaceCount(@RequestParam(value = "reportPlace") String reportPlace,@RequestParam(value = "subPlace") String subPlace,@RequestParam(value = "subject") String subject,
                                @RequestParam(value = "level") int level, HttpServletRequest request){
        ArrayList<Long> count= new ArrayList<Long>();
        long totalCount = messageDao.getCount("select count (*) from message where isDelete = 0 and reportPlace='"+reportPlace+"' and subPlace= '"+subPlace+"' and subject ='"+subject+"' and level ="+level,request);
        long realCount = messageDao.getCount("select count (classPlace) from message where isDelete = 0 and reportPlace='"+reportPlace+"' and subPlace= '"+subPlace+"' and subject ='"+subject+"' and level ="+level,request);
        BigDecimal b1 = new BigDecimal(totalCount);
        BigDecimal b2 = new BigDecimal(realCount);
        long otherCount = b1.subtract(b2).longValue();
        count.add(otherCount);
        count.add(totalCount);
        return JSONArray.fromObject(count).toString();
    }
    @RequestMapping(value="/examination-getExamPlaceCount",method = RequestMethod.POST)
    @ResponseBody
    public Long getExamPlaceCount(@RequestParam(value = "examPlace") String examPlace,@RequestParam(value = "classPlace") String classPlace, HttpServletRequest request){
        ArrayList<Long> count= new ArrayList<Long>();
        long realCount = messageDao.getCount("select count (*) from message where isDelete = 0 and examPlace='"+examPlace+"' and classPlace= '"+classPlace+"'",request);
        return realCount;
    }
    @RequestMapping(value="/examination-start",method = RequestMethod.POST)
    @ResponseBody
    public String start(@RequestParam(value = "reportPlace") String reportPlace,@RequestParam(value = "subPlace") String subPlace,
                      @RequestParam(value = "realExamPlace") String[] examPlace,@RequestParam(value = "realClassPlace") String[] classPlace,
                      @RequestParam(value = "realCount") Long[] otherCount,@RequestParam(value = "realSubject") String[] subject,
                        @RequestParam(value = "realExamTime") String[] examTime,
                      @RequestParam(value = "realLevel") int[] level,@RequestParam(value = "time") String time, HttpServletRequest request){
        String sql="and ((subject ='"+subject[0]+"'and level ="+level[0]+")";
        for(int i=1;i<subject.length;i++){
            sql+="or (subject ='"+subject[i]+"'and level ="+level[i]+")";
        }
        sql+=")";
        List<message> list = messageDao.findAll("from message where isDelete = 0 and examPlace IS NULL and classPlace IS NULL and reportPlace='"+reportPlace+"' and subPlace ='"+subPlace+"' "+sql+"order by cardNumber");
        int count=0;
        List<message> changeList = new ArrayList<message>();
            for(int x=0;x<otherCount.length;x++) {
                if(count>=list.size())
                    break;
                for (int i = 0; i < otherCount[x]; i++) {
                    list.get(count+i).setClassPlace(classPlace[x]);
                    list.get(count+i).setExamPlace(examPlace[x]);
                    list.get(count+i).setTime(time);
                    if(!examTime[x].equals("noTime"))
                        list.get(count+i).setExamTime(examTime[x]);
                    messageDao.update(list.get(count+i),request);
                    changeList.add(list.get(count+i));
                    if(list.size()==(count+i+1))
                        break;
                }
                count+=otherCount[x];
             }
        return JSONArray.fromObject(changeList).toString();
    }
    @RequestMapping(value="/examination-startPlace",method = RequestMethod.POST)
    @ResponseBody
    public String startPlace(@RequestParam(value = "reportPlace") String[] reportPlace,@RequestParam(value = "subPlace") String[] subPlace,
                        @RequestParam(value = "realExamPlace") String[] examPlace,@RequestParam(value = "realClassPlace") String[] classPlace,
                        @RequestParam(value = "realCount") Long[] otherCount,@RequestParam(value = "realExamTime") String[] examTime,@RequestParam(value = "time") String time, HttpServletRequest request){
        String sql="and ((reportPlace ='"+reportPlace[0]+"'and subPlace ='"+subPlace[0]+"')";
        for(int i=1;i<reportPlace.length;i++){
            sql+="or (reportPlace ='"+reportPlace[i]+"'and subPlace ='"+subPlace[i]+"')";
        }
        sql+=")";
        List<message> list = messageDao.findAll("from message where isDelete = 0 and examPlace IS NULL and classPlace IS NULL "+sql+"order by cardNumber");
        int count=0;
        List<message> changeList = new ArrayList<message>();
        for(int x=0;x<otherCount.length;x++) {
            if(count>=list.size())
                break;
            for (int i = 0; i < otherCount[x]; i++) {
                list.get(count+i).setClassPlace(classPlace[x]);
                list.get(count+i).setExamPlace(examPlace[x]);
                list.get(count+i).setTime(time);
                if(!examTime[x].equals("noTime"))
                    list.get(count+i).setExamTime(examTime[x]);
                messageDao.update(list.get(count+i),request);
                changeList.add(list.get(count+i));
                if(list.size()==(count+i+1))
                    break;
            }
            count+=otherCount[x];
        }
        return JSONArray.fromObject(changeList).toString();
    }
    @RequestMapping(value="/examination-list",method = RequestMethod.POST)
    @ResponseBody
    public String list(){
        List<message> list=messageDao.findAll("from message where isDelete = 0 and examPlace IS NOT NULL and classPlace IS NOT NULL");
        return JSONArray.fromObject(list).toString();
    }
    @RequestMapping(value="/examination-getConfigExamList",method = RequestMethod.POST)
    @ResponseBody
    public String getConfigExamList(){
        List<message> list=messageDao.findAll("select DISTINCT(examPlace),classPlace from message where isDelete = 0 and examPlace IS NOT NULL and classPlace IS NOT NULL GROUP BY examPlace,classPlace");
        return JSONArray.fromObject(list).toString();
    }

    @RequestMapping(value="/examination-getConfigReportList",method = RequestMethod.POST)
    @ResponseBody
    public String getConfigReportList(){
        List<message> list=messageDao.findAll("select DISTINCT(reportPlace),subPlace from message where isDelete = 0 GROUP BY reportPlace,subPlace");
        return JSONArray.fromObject(list).toString();
    }

    @RequestMapping(value="/examination-startCancel",method = RequestMethod.POST)
    @ResponseBody
    public String startCancel(@RequestParam(value = "isAllCancel") Boolean isAllCancel,
                              @RequestParam(value = "reportPlace") String reportPlace,
                              @RequestParam(value = "subPlace") String subPlace,
                              @RequestParam(value = "examPlace") String examPlace,
                              @RequestParam(value = "classPlace") String classPlace, HttpServletRequest request){
        List<message> messageList = new ArrayList<message>();
        String sql="",sql1="",sql2="",sql3="",sql4="";
        if(isAllCancel){
            messageList=messageDao.findAll("from message where isDelete = 0 and examPlace IS NOT NULL and classPlace IS NOT NULL");
        }else{
            if(!reportPlace.equals(""))
                sql1 +="reportPlace ='"+reportPlace +"'";
            if(!subPlace.equals(""))
                sql2 +="subPlace ='"+subPlace +"'";
            if(!examPlace.equals(""))
                sql3 +="examPlace ='"+examPlace +"'";
            if(!classPlace.equals(""))
                sql4 +="classPlace ='"+classPlace +"'";
            if(!sql1.equals(""))
                sql+=" and "+sql1;
            if(!sql2.equals(""))
                sql+=" and "+sql2;
            if(!sql3.equals(""))
                sql+=" and "+sql3;
            if(!sql4.equals(""))
                sql+=" and "+sql4;
            messageList=messageDao.findAll("from message where isDelete = 0 " +sql);
        }
        for(message message:messageList){
            message.setClassPlace(null);
            message.setExamPlace(null);
            message.setTime(null);
        }
        messageDao.update(messageList,request);
        return JSONArray.fromObject(messageList).toString();
    }
}
