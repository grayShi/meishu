package com.springapp.mvc;

import com.springapp.entity.examTime;
import com.springapp.entity.message;
import com.springapp.entity.subject;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sgl on 2017/5/4.
 */
@Controller
@RequestMapping(value = "**")

public class ExamTimeController extends BaseController{
    @RequestMapping(value="/examTime",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView, HttpServletRequest request){
        List<examTime> examTime=examTimeDao.findAll("from examTime",request);
        modelAndView.addObject("examTime",examTime);
        String examTimeList = JSONArray.fromObject(examTime).toString();
        modelAndView.addObject("examTimeList",examTimeList);
        modelAndView.setViewName("examTime");
        return modelAndView;
    }
    @RequestMapping(value="/examTime-add",method = RequestMethod.GET)
    public ModelAndView examTime_add(ModelAndView modelAndView, HttpServletRequest request){
        List<subject> subject=subjectDao.findAll("from subject",request);
        modelAndView.addObject("subject",subject);
        modelAndView.setViewName("examTime-add");
        return modelAndView;
    }
    @RequestMapping(value="/examTime-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value = "subject") String subject, @RequestParam(value = "level") int level, @RequestParam(value = "duration") String duration){
        Long count = examTimeDao.getCount("select count (*) from examTime where subject ='"+subject+"' and level ="+level,request);
        if(count == 0) {
            examTime exam = new examTime();
            List<subject> subjectList = subjectDao.findAll("from subject where subject ='"+subject+"'",request);
            if(subjectList.size()!=0) {
                exam.setSubId(subjectList.get(0).getId().toString());
                exam.setSubject(subject);
                exam.setLevel(level);
                exam.setDuration(duration);
                List<message> messageList = messageDao.findAll("from message where isDelete = 0 and subject ='"+exam.getSubId()+"￥"+subject+"' and level ="+level,request);
                List<message> messages = new ArrayList<message>();
                for(message message:messageList){
                    message.setExamTime(duration);
                    messages.add(message);
                }
                messageDao.update(messages,request);
                examTimeDao.save(exam,request);
                return "success";
            }
            else
                return "error";
        }
        else
            return "is_exist";
    }
    @RequestMapping(value="/examTime-getlevel",method = RequestMethod.POST)
    @ResponseBody
    public String getlevel(@RequestParam(value = "subject") String subject, HttpServletRequest request){
        List<subject> subjectList = subjectDao.findAll("from subject where subject = '"+subject+"'",request);
        return JSONArray.fromObject(subjectList).toString();
    }
    @RequestMapping(value="/examTime-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id, HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        List<examTime> examTimeL = examTimeDao.findAll("from examTime where id =" + id,request);
        modelAndView.addObject("examTimeLi", examTimeL);
        modelAndView.addObject("examTimeL", JSONArray.fromObject(examTimeL).toString());
        modelAndView.addObject("id", id);
        List<subject> subject=subjectDao.findAll("from subject where subject = '"+examTimeL.get(0).getSubject()+"'",request);
        modelAndView.addObject("subject",JSONArray.fromObject(subject).toString());
        List<subject> subjectL=subjectDao.findAll("from subject",request);
        String subjectList = JSONArray.fromObject(subjectL).toString();
        modelAndView.addObject("subjectList",subjectList);

        modelAndView.setViewName("examTime-edit");
        return modelAndView;
    }
    @RequestMapping(value="/examTime-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value = "subject") String subject,@RequestParam(value = "level") int level,@RequestParam(value = "duration") String duration, HttpServletRequest request){
//        Long count = examTimeDao.getCount("select count (*) from examTime where subject ='"+subject+"' and level ="+level);
//        if(count == 0) {
            examTime exam = examTimeDao.getId(id,request).get(0);
            List<subject> subjectList = subjectDao.findAll("from subject where subject ='"+subject+"'",request);
            if(subjectList.size()!=0) {
                exam.setSubId(subjectList.get(0).getId().toString());
                exam.setLevel(level);
                exam.setSubject(subject);
                exam.setDuration(duration);
                List<message> messageList = messageDao.findAll("from message where isDelete = 0 and subject ='"+exam.getSubId()+"￥"+subject+"' and level ="+level,request);
                List<message> messages = new ArrayList<message>();
                for(message message:messageList){
                    message.setExamTime(duration);
                    messages.add(message);
                }
                messageDao.update(messages,request);
                examTimeDao.update(exam,request);
                return "success";
            }
            else
                return "error";
//        }else
//            return "is_exist";
    }
    @RequestMapping(value="/examTime-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        examTime exam = examTimeDao.getId(id,request).get(0);
        List<message> messageList = messageDao.findAll("from message where isDelete = 0 and subject ='"+exam.getSubId()+"￥"+exam.getSubject()+"' and level ="+exam.getLevel(),request);
        List<message> messages = new ArrayList<message>();
        for(message message:messageList){
            message.setExamTime("");
            messages.add(message);
        }
        messageDao.update(messages,request);
        examTimeDao.delete(examTime.class,id,request);
        return "success";
    }
}
