package com.springapp.mvc;

import com.springapp.entity.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class placeController extends  BaseController{
    @RequestMapping(value="/place",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView, HttpServletRequest request){
        List<reportPlace> subplace=reportPlaceDao.findAll("from reportPlace where isDelete = 0 order by placeId,subPlaceId",request);
        modelAndView.addObject("subplace",subplace);
        List<Place> place=placeDao.findAll("from Place",request);
        modelAndView.addObject("place",place);
        String placeList = JSONArray.fromObject(subplace).toString();
        modelAndView.addObject("placeList",placeList);
        modelAndView.setViewName("place");
        return modelAndView;
    }
    @RequestMapping(value="/place-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id, HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        List<reportPlace> placeEdit=reportPlaceDao.findAll("from reportPlace where isDelete = 0 and id =" + id,request);
        modelAndView.addObject("placeEdit", placeEdit);
        modelAndView.addObject("id", id);
        modelAndView.setViewName("place-edit");
        return modelAndView;
    }
    @RequestMapping(value="/place-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(HttpServletRequest request, @RequestParam(value = "id") Long id, @RequestParam(value = "place") String place, @RequestParam(value = "subPlace") String subPlace, @RequestParam(value = "remark") String remark){
        Long reportPlaceCount = reportPlaceDao.getCount("select count(*) from reportPlace where isDelete = 0 and place = '"+place.trim()+"' and subPlace = '"+subPlace.trim()+"' and id !="+id,request);
        if(reportPlaceCount != 0)
            return "notOne";
        reportPlace rep = reportPlaceDao.getId(id,request).get(0);
        String originalPlace = rep.getPlace();
        String originalSubPlaceNum = "";
        String currentSubPlaceNum = "";
        String userSubPlace = rep.getSubPlaceId() + "¥" + rep.getSubPlace();
        if(rep.getPlaceId()<10)
            originalSubPlaceNum +='0';
        originalSubPlaceNum += rep.getPlaceId();
        if (rep.getSubPlaceId() < 10)
            originalSubPlaceNum += '0';
        originalSubPlaceNum += rep.getSubPlaceId();
        String originalSubPlace = originalSubPlaceNum + '￥'+ rep.getSubPlace();
        List<Place> placeList = placeDao.findAll("from Place where place= '"+place.trim()+"'",request);
        if(placeList.size() == 0) {
            long placeCount = reportPlaceDao.getCount("select count(*) from reportPlace where placeId = "+rep.getPlaceId() +"and subPlaceId !="+rep.getSubPlaceId(),request);
            if(placeCount == 0){
                List<Place> Place = placeDao.findAll("from Place where place= '"+originalPlace+"'",request);
                Place.get(0).setPlace(place.trim());
                placeDao.update(Place.get(0),request);
                rep.setSubPlaceId(Long.parseLong("1"));
            }else {
                Place pla = new Place();
                pla.setPlace(place.trim());
                placeDao.save(pla,request);
                rep.setPlaceId(placeDao.setId(place.trim(),request));
                rep.setSubPlaceId(Long.parseLong("1"));
            }
        }else{
            if(!rep.getPlace().equals(place.trim())) {
                List<Map> maxList = reportPlaceDao.findAll("select new Map(max(subPlaceId) as subPlaceId) from reportPlace where placeId = " + placeDao.setId(place.trim(),request),request);
                rep.setSubPlaceId(Long.parseLong(maxList.get(0).get("subPlaceId").toString()) + 1);
            }
            rep.setPlaceId(placeList.get(0).getId());
        }
        rep.setIsDelete(0);
        rep.setRemark(remark);
        rep.setPlace(place.trim());
        rep.setSubPlace(subPlace.trim());
        if(rep.getPlaceId()<10)
            currentSubPlaceNum +='0';
        currentSubPlaceNum += rep.getPlaceId();
        if (rep.getSubPlaceId() < 10)
            currentSubPlaceNum += '0';
        currentSubPlaceNum += rep.getSubPlaceId();
        String currentPlace = rep.getPlace();
        String currentsubPlace = currentSubPlaceNum + '￥'+ rep.getSubPlace();
        String currentUserSubPlace = rep.getSubPlaceId() + "¥" + rep.getSubPlace();
        List<User> userList = userDao.findAll("from User where place = '"+originalPlace +"' and subPlace = '"+userSubPlace+"'",request);
        for(User change : userList){
            change.setPlace(currentPlace);
            change.setSubPlace(currentUserSubPlace);
            change.setUsername(rep.getSubPlace());
        }
        userDao.update(userList, request);
        List<message> messageList = messageDao.findAll("from message where isDelete = 0 and reportPlace = '"+originalPlace +"' and subPlace = '"+originalSubPlace+"'",request);
        for(message changeList : messageList){
            changeList.setReportPlace(currentPlace);
            changeList.setSubPlace(currentsubPlace);
            if(!currentSubPlaceNum.equals(originalSubPlaceNum))
                changeList.setCardNumber(changeList.getCardNumber().substring(0,2)+currentSubPlaceNum+changeList.getCardNumber().substring(6,changeList.getCardNumber().length()));
        }
        messageDao.update(messageList,request);
        rep.setRealId(currentSubPlaceNum);
        reportPlaceDao.update(rep,request);
        return "success";
    }
    @RequestMapping(value="/place-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        List<reportPlace>reportPlaces = reportPlaceDao.getId(id,request);
        reportPlace reportPlace = reportPlaces.get(0);
        reportPlace.setIsDelete(1);
        reportPlaceDao.update(reportPlace,request);
        Long placeCount = reportPlaceDao.getCount("select count(*) from reportPlace where isDelete = 0 and placeId = "+reportPlace.getPlaceId(),request);
        if(placeCount == 0)
            placeDao.delete(Place.class,reportPlace.getId(),request);
        return "success";
    }
    @RequestMapping(value="/place-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView){
        modelAndView.setViewName("place-add");
        return modelAndView;
    }
    @RequestMapping(value="/place-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(HttpServletRequest request, @RequestParam(value = "place") String place,@RequestParam(value = "subPlace") String[] subPlace,@RequestParam(value = "remark") String remark){
        Long placeCount = placeDao.getPlaceCount(place.trim(),request);
        if(placeCount == 0) {
            Place pla = new Place();
            pla.setPlace(place.trim());
            placeDao.save(pla,request);
        }
        int isCount = 0;  ////重复数据
        for(int i=0;i<subPlace.length;i++) {
            Long placeId = placeDao.setId(place.trim(),request);
            List<reportPlace> reportPlaceList = reportPlaceDao.findAll("from reportPlace where isDelete = 0 and subPlace = '"+subPlace[i].trim()+"' and placeId = " + placeId,request);
            if(reportPlaceList.size() == 0) {
                Long count = reportPlaceDao.getCount("select count(*) from reportPlace where placeId = " + placeId,request);
                ///////搜索全表
                reportPlace rep = new reportPlace();
                if(count >0){
                    List<Map>maxList = reportPlaceDao.findAll("select new Map(max(subPlaceId) as subPlaceId) from reportPlace where placeId = " + placeId,request);
                    rep.setSubPlaceId(Long.parseLong(maxList.get(0).get("subPlaceId").toString())+1);
                }else
                    rep.setSubPlaceId(Long.parseLong("1"));
                rep.setPlace(place);
                rep.setIsDelete(0);
                rep.setSubPlace(subPlace[i].trim());
                rep.setRemark(remark);
                rep.setPlaceId(placeDao.setId(place.trim(),request));
                String currentSubPlaceNum = "";
                if(rep.getPlaceId()<10)
                    currentSubPlaceNum +='0';
                currentSubPlaceNum += rep.getPlaceId();
                if (rep.getSubPlaceId() < 10)
                    currentSubPlaceNum += '0';
                currentSubPlaceNum += rep.getSubPlaceId();
                rep.setRealId(currentSubPlaceNum);
                reportPlaceDao.save(rep,request);
                User user = new User();
                user.setPower("school");
                user.setUsername(rep.getSubPlace());
                user.setPassword("a85436017eb06a341f1a7e2d1fa69de7");   // 默认密码：mskj
                user.setPlace(place);
                user.setSubPlace(rep.getSubPlaceId()+"¥"+rep.getSubPlace());
                userDao.save(user,request);
            }else {
                isCount++;
            }
        }
        if(isCount == 0)
            return "success";
        else
            return isCount+"";
    }
}
