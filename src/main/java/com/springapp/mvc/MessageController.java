package com.springapp.mvc;


import com.springapp.classes.searchSql;
import com.springapp.entity.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class MessageController extends BaseController{
    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView) {
        List<reportPlace> place=reportPlaceDao.findAll("select distinct place from reportPlace where isDelete = 0");
        String placeList=JSONArray.fromObject(place).toString();
        modelAndView.addObject("placeList",placeList);
        modelAndView.addObject("place",place);
        List<subject> subject=subjectDao.findAll("from subject");
        String subjectList=JSONArray.fromObject(subject).toString();
        modelAndView.addObject("subject",subject);
        modelAndView.addObject("subjectList",subjectList);
        modelAndView.setViewName("message");
        return modelAndView;
    }
    @RequestMapping(value="/message-getLevel",method = RequestMethod.POST)
    @ResponseBody
    public String getLevel(@RequestParam(value = "subject") String subject){
        List<subject> subjectList= subjectDao.findAll("from subject where subject ='"+subject+"'order by level");
        return JSONArray.fromObject(subjectList).toString();
    }
    @RequestMapping(value="/message-getSubPlace",method = RequestMethod.POST)
    @ResponseBody
    public String getSubPlace(HttpServletRequest request, @RequestParam(value = "place") String place){
        List<reportPlace> subPlaceList= reportPlaceDao.findAll("from reportPlace where isDelete = 0 and place ='"+place+"' order by subPlace");
        return JSONArray.fromObject(subPlaceList).toString();
    }
    @RequestMapping(value="/message-saveMessage",method = RequestMethod.POST)
    @ResponseBody
    public String saveMessage(@RequestParam(value = "reportPlace") String reportPlace, @RequestParam(value = "subPlace") String subPlace,
                              @RequestParam(value = "name") String name, @RequestParam(value = "sex") String sex,
                              @RequestParam(value = "birth") String birth, @RequestParam(value = "email",required = false) String email,
                              @RequestParam(value = "country",required = false) String country, @RequestParam(value = "nation",required = false) String nation,
                              @RequestParam(value = "address") String address, @RequestParam(value = "postCodes",required = false) String postCodes,
                              @RequestParam(value = "phoneNumber",required = false) String phoneNumber, @RequestParam(value = "subject") String subject,
                              @RequestParam(value = "level") int level,@RequestParam(value = "date") String date){

        Long isCount = messageDao.getCount("select count (*) from message where isDelete = 0 and name ='" + name + "'and address='" + address + "'and subject='" + subject + "'and level = " + level);
        if(isCount !=0){
            return "notOne";
        }
        message Message =new message();
        Message.setSubject(subject);
        Message.setAddress(address);
        Message.setBirth(birth);
        //Message.setCardNumber();
        Message.setCountry(country);
        Message.setLevel(level);
        Message.setName(name);
        Message.setSex(sex);
        Message.setNation(nation);
        Message.setReportPlace(reportPlace);
        Message.setPhoneNumber(phoneNumber);
        Message.setIsDelete(0);
        Date nowDate = new Date();
        String Id=(nowDate.getYear()+1900+"").substring(2);
        String placeId=""+placeDao.setId(reportPlace);
        String subPlaceId="";
        String subjectId="";
        String Subject="";
        String subPlaceIdCount = "";
        if(placeDao.setId(reportPlace)<10){
            Id+='0';
            subPlaceIdCount+='0';
        }
        Id+=placeId;
        subPlaceIdCount+=placeId;
        char [] pla = subPlace.toCharArray();
        for(int i=0;i<pla.length;i++){
            if(pla[i]=='￥'){
                for(int j=i;j<2;j++) {
                    Id += '0';
                    subPlaceIdCount += '0';
                }
                break;
            }
            else
                subPlaceId+=pla[i];
        }
        Id+=subPlaceId;
        Message.setSubPlace(subPlaceIdCount+subPlace);
        char [] sub = subject.toCharArray();
        for(int i=0;i<sub.length;i++){
            if(sub[i]=='￥'){
                for(int j=i;j<2;j++)
                    Id+='0';
                for(int x=i+1;x<sub.length;x++)
                    Subject+=sub[x];
                break;
            }
            else
                subjectId+=sub[i];
        }
        Id+=subjectId;
        if(level<10)
            Id+='0';
        Id+=level;
        Long countId=messageDao.getCount("select count (*) from message where endSignUpTime = '"+ date +"' and reportPlace = '"+Message.getReportPlace()+"'and subPlace = '"+Message.getSubPlace()+"' and subject='"+subject+"'and level = "+level)+1;
        if(countId<1000)
            Id+='0';
        if(countId<100)
            Id+='0';
        if(countId<10)
            Id+='0';
        Id+=countId;
        Message.setCardNumber(Id);
        List<examTime> examTimeList = examTimeDao.findAll("from examTime where subject ='"+Subject+"' and level ="+level);
        if(examTimeList.size()!=0) {
            Message.setExamTime(examTimeList.get(0).getDuration());
        }
        Message.setEndSignUpTime(date);
        messageDao.save(Message);
        return "success";
    }
    @RequestMapping(value="/message-getSearch",method = RequestMethod.POST)
    @ResponseBody
    public String getSearch(@RequestParam(value = "name") String name, @RequestParam(value = "sex") String sex,
                            @RequestParam(value = "birth") String birth){
        List<message> messageList= messageDao.findAll("from message where isDelete = 0 and name ='"+name+"'and sex='"+sex+"'and birth='"+birth+"'");
        return JSONArray.fromObject(messageList).toString();
    }
//    @RequestMapping(value = "getCardNumber",method = RequestMethod.POST)
//    @ResponseBody
//    public String getCardNumber(@RequestParam(value = "subject") String subject, @RequestParam(value = "reportPlace") String reportPlace,
//                                @RequestParam(value = "subPlace") String subPlace,@RequestParam(value = "level") int level){
//        List<subject> sub= subjectDao.findAll("from subject where subject='"+subject+"'");
//        Long subId=sub.get(0).getId();
//        List<reportPlace> rep=reportPlaceDao.findAll("from reportPlace where reportPlace='"+reportPlace+"' and subPlace='"+subPlace+"'");
//        Long repId=rep.get(0).getId();
//        //Long countId=messageDao.getCount("from message where subject='"+subject+"'");
//        return
//    }
    @RequestMapping(value="/message-editMessage",method = RequestMethod.POST)
    @ResponseBody
    public String editMessage(@RequestParam(value = "id")Long id,@RequestParam(value = "reportPlace") String reportPlace, @RequestParam(value = "subPlace") String subPlace,
                              @RequestParam(value = "name") String name, @RequestParam(value = "sex") String sex,
                              @RequestParam(value = "birth") String birth, @RequestParam(value = "email",required = false) String email,
                              @RequestParam(value = "country",required = false) String country, @RequestParam(value = "nation",required = false) String nation,
                              @RequestParam(value = "address",required = false) String address, @RequestParam(value = "postCodes",required = false) String postCodes,
                              @RequestParam(value = "phoneNumber",required = false) String phoneNumber, @RequestParam(value = "subject") String subject,
                              @RequestParam(value = "level") int level,@RequestParam(value = "date") String date){
        message Message = messageDao.getId(id).get(0);
        Message.setSubject(subject);
        Message.setAddress(address);
        Message.setBirth(birth);
        //Message.setCardNumber();
        Message.setCountry(country);
        Message.setLevel(level);
        Message.setName(name);
        Message.setSex(sex);
        Message.setNation(nation);
        Message.setReportPlace(reportPlace);
        Message.setPhoneNumber(phoneNumber);
        Message.setIsDelete(0);
        Date nowDate = new Date();
        String Id=(nowDate.getYear()+1900+"").substring(2);             /////////////////准考证前两位  当前录入年份
        String placeId=""+placeDao.setId(reportPlace);
        String subPlaceId="";
        String subjectId="";                                        ////////////////两位    报考点代号
        String Subject="";
        String subPlaceIdCount = "";
        if(placeDao.setId(reportPlace)<10){
            Id+='0';
            subPlaceIdCount+='0';
        }
        Id+=placeId;
        subPlaceIdCount+=placeId;                                 ///////////////两位    子报考点代号
        char [] pla = subPlace.toCharArray();                       ///////////////两位     科目代号
        for(int i=0;i<pla.length;i++){                             /////////////二位     级别
            if(pla[i]=='￥'){                                        ///////////四位      同科目同级别 人数
                for(int j=i;j<2;j++) {
                    Id += '0';
                    subPlaceIdCount += '0';
                }
                break;
            }
            else
                subPlaceId+=pla[i];
        }
        Id+=subPlaceId;
        Message.setSubPlace(subPlaceIdCount+subPlace);
        char [] sub = subject.toCharArray();
        for(int i=0;i<sub.length;i++){
            if(sub[i]=='￥'){
                for(int j=i;j<2;j++)
                    Id+='0';
                for(int x=i+1;x<sub.length;x++)
                    Subject+=sub[x];
                break;
            }
            else
                subjectId+=sub[i];
        }
        Id+=subjectId;
        if(level<10)
            Id+='0';
        Id+=level;
        Long countId=messageDao.getCount("select count (*) from message where endSignUpTime = '"+ date +"' and reportPlace = '"+Message.getReportPlace()+"'and subPlace = '"+Message.getSubPlace()+"' and subject='"+subject+"'and level = "+level)+1;

        ///搜索全表 包括isDelete=0
        if(countId<1000)
            Id+='0';
        if(countId<100)
            Id+='0';
        if(countId<10)
            Id+='0';
        Id+=countId;
        Message.setCardNumber(Id);
        List<examTime> examTimeList = examTimeDao.findAll("from examTime where subject ='"+Subject+"' and level ="+level);
        if(examTimeList.size()!=0) {
            Message.setExamTime(examTimeList.get(0).getDuration());
        }
        Message.setEndSignUpTime(date);
        messageDao.update(Message);
        return "success";
    }
    @RequestMapping(value="/message-searchTime",method = RequestMethod.POST)
    @ResponseBody
    public String searchTime(@RequestParam(value = "subject")String subject,@RequestParam(value="level") int level){
        Long count=examTimeDao.getCount("select count (*) from examTime where subject='"+subject+"'and level = "+level);
        if(count>0)
            return "success";
        else
            return "false";
    }

}
