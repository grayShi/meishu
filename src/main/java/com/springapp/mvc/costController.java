package com.springapp.mvc;

import com.springapp.entity.cost;
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
 * Created by hello on 2016/7/5.
 */
@Controller
@RequestMapping(value = "**")
public class costController extends BaseController{
    @RequestMapping(value="/cost",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView, HttpServletRequest request){
        List<cost> cost=costDao.findAll("from cost",request);
        modelAndView.addObject("cost",cost);
        String costList = JSONArray.fromObject(cost).toString();
        modelAndView.addObject("costList",costList);
        modelAndView.setViewName("cost");
        return modelAndView;
    }
    @RequestMapping(value="/cost-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id, HttpServletRequest request){

        ModelAndView modelAndView = new ModelAndView();
        List<cost> costEdit = costDao.findAll("from cost where id =" + id,request);
        List<cost> cost=costDao.findAll("from cost",request);
        String costList1 = JSONArray.fromObject(cost).toString();
        String costList2 = JSONArray.fromObject(costEdit).toString();
        modelAndView.addObject("costList1",costList1);
        modelAndView.addObject("costList2",costList2);
        modelAndView.addObject("costEdit", costEdit);
        modelAndView.addObject("id", id);
        modelAndView.setViewName("cost-edit");
        return modelAndView;
    }
    @RequestMapping(value="/cost-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,@RequestParam(value = "zhengshufei") Double zhengshufei,@RequestParam(value = "baomingfei") Double baomingfei,
                        @RequestParam(value = "kaowufei") Double kaowufei,@RequestParam(value = "level") int level,@RequestParam(value = "remark") Double remark, HttpServletRequest request){
        cost cos = costDao.getId(id,request).get(0);
        cos.setLevel(level);
        cos.setBaomingfei(baomingfei);
        cos.setKaowufei(kaowufei);
        cos.setZhengshufei(zhengshufei);
        cos.setRemark(remark);
        costDao.update(cos,request);
        return "success";
    }
    @RequestMapping(value="/cost-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        costDao.delete(cost.class,id,request);
        return "success";
    }
    @RequestMapping(value="/cost-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView, HttpServletRequest request){
        List<cost> cost=costDao.findAll("from cost",request);
        String costList = JSONArray.fromObject(cost).toString();
        modelAndView.addObject("costList",costList);
        modelAndView.setViewName("cost-add");
        return modelAndView;
    }
    @RequestMapping(value="/cost-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value = "zhengshufei") Double zhengshufei, @RequestParam(value = "baomingfei") Double baomingfei,
                       @RequestParam(value = "kaowufei") Double kaowufei, @RequestParam(value = "level") int level, @RequestParam(value = "remark") Double remark){
        cost cos =new cost();
        cos.setLevel(level);
        cos.setBaomingfei(baomingfei);
        cos.setKaowufei(kaowufei);
        cos.setZhengshufei(zhengshufei);
        cos.setRemark(remark);
        costDao.save(cos, request);
        return "success";
    }
}
