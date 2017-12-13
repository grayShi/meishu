package com.springapp.mvc;

import com.springapp.entity.subject;
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
@RequestMapping(value = "**")

public class subjectController extends BaseController{
    @RequestMapping(value="/subject",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView){
        List<subject> subject=subjectDao.findAll("from subject");
        modelAndView.addObject("subject",subject);
        String subjectList = JSONArray.fromObject(subject).toString();
        modelAndView.addObject("subjectList",subjectList);
        modelAndView.setViewName("subject");
        return modelAndView;
    }
    @RequestMapping(value="/subject-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id){

            ModelAndView modelAndView = new ModelAndView();
            List<subject> subjectList = subjectDao.findAll("from subject where id =" + id);
            modelAndView.addObject("subjectEdit", subjectList);
            modelAndView.addObject("id", id);
            modelAndView.setViewName("subject-edit");
            return modelAndView;
}
    @RequestMapping(value="/subject-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value = "subject") String subject,@RequestParam(value = "level") int level, HttpServletRequest request){
        Long count = subjectDao.getCount("select count (*) from subject where subject ='"+subject+"' and id !="+id,request);
        if(count == 0) {
            subject sub = subjectDao.getId(id).get(0);
            sub.setLevel(level);
            sub.setSubject(subject);
            subjectDao.update(sub,request);
            return "success";
        }else
            return "is_exist";
    }

    @RequestMapping(value="/subject-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        subjectDao.delete(subject.class,id,request);
        return "success";
    }
    @RequestMapping(value="/subject-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView){
        modelAndView.setViewName("subject-add");
        return modelAndView;
    }
    @RequestMapping(value="/subject-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value = "subject") String subject, @RequestParam(value = "level") int level){
        Long count = subjectDao.getCount("select count (*) from subject where subject ='"+subject+"'",request);
        if(count == 0) {
            subject sub = new subject();
            sub.setSubject(subject);
            sub.setLevel(level);
            subjectDao.save(sub,request);
            return "success";
        }
        else
            return "is_exist";
    }
}
