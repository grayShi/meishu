package com.springapp.mvc;

import com.springapp.entity.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by sgl on 2017/12/2.
 */
@Controller
@RequestMapping(value = "**")
public class userController extends BaseController {
    @RequestMapping(value="/user",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView){
        List<User> user = userDao.findAll("from User");
        for(User us : user){
            if(us.getSubPlace() != null){
                char [] sub = us.getSubPlace().toCharArray();
                String subPlace ="";
                for(int i=0;i<sub.length;i++){
                    if(sub[i] == '￥'){
                        for(int j=i+1;j<sub.length;j++) {
                            subPlace += sub[j];
                        }
                        break;
                    }
                }
                us.setSubPlace(subPlace);
            }
        }
        modelAndView.addObject("user",user);
        String userList = JSONArray.fromObject(user).toString();
        modelAndView.addObject("userList",userList);
        modelAndView.setViewName("user");
        return modelAndView;
    }
    @RequestMapping(value="/user-edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id") Long id){
        ModelAndView modelAndView = new ModelAndView();
        List<User> userList = userDao.findAll("from User where id =" + id);
        modelAndView.addObject("userList", userList);
        List<reportPlace> place=reportPlaceDao.findAll("select distinct place from reportPlace where isDelete = 0");
        modelAndView.addObject("place",place);
        List<reportPlace> subPlace= reportPlaceDao.findAll("select subPlace from reportPlace where isDelete = 0 and place ='"+userList.get(0).getPlace()+"'order by subPlace");
        modelAndView.addObject("subPlace",subPlace);
        modelAndView.addObject("id", id);
        modelAndView.setViewName("user-edit");
        return modelAndView;
    }
    @RequestMapping(value="/user-edit1",method = RequestMethod.POST)
    @ResponseBody
    public String edit1(@RequestParam(value = "id") Long id,
                        @RequestParam(value = "username") String username,@RequestParam(value = "password") String password,
                        @RequestParam(value = "power") String power,@RequestParam(value = "place") String place,
                        @RequestParam(value = "subPlace") String subPlace){
        Long userCount = userDao.getCount("select count (*) from User where username ='"+username+"' and id !="+ id);
        if(userCount == 0) {
            User user = userDao.getId(id).get(0);
            user.setUsername(username);
            if(!password.equals("")){
                user.setPassword(password);
            }
            user.setPower(power);
            if(power.equals("admin")){
                user.setPlace("");
                user.setSubPlace("");
            } else {
                user.setPlace(place);
                user.setSubPlace(subPlace);
            }
            userDao.update(user);
            return "success";
        }else {
            return "is_exist";
        }
    }
    @RequestMapping(value="/user-add",method = RequestMethod.GET)
    public ModelAndView add(ModelAndView modelAndView){
        List<reportPlace> place=reportPlaceDao.findAll("select distinct place from reportPlace where isDelete = 0");
        modelAndView.addObject("place",place);
        modelAndView.setViewName("user-add");
        return modelAndView;
    }
    @RequestMapping(value="/user-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id){
        userDao.delete(User.class,id);
        return "success";
    }
    @RequestMapping(value="/user-add1",method = RequestMethod.POST)
    @ResponseBody
    public String add1(@RequestParam(value = "username") String username,@RequestParam(value = "password") String password,
                       @RequestParam(value = "power") String power,@RequestParam(value = "place") String place,
                       @RequestParam(value = "subPlace") String subPlace){
        Long userCount = userDao.getCount("select count (*) from User where username ='"+username+"'");
        if(userCount == 0) {
            User user = new User();
            user.setPower(power);
            user.setUsername(username);
            user.setPassword(password);
            if(!power.equals("admin")){
                user.setPlace(place);
                user.setSubPlace(subPlace);
            }
            userDao.save(user);
            return "success";
        }else
            return  "is_exist";
    }
    @RequestMapping(value="/changePassword",method = RequestMethod.GET)
    public ModelAndView changePassword(@RequestParam(value = "id") Long id){
        ModelAndView modelAndView = new ModelAndView();
        List<User> userList = userDao.findAll("from User where id =" + id);
        modelAndView.addObject("username", userList.get(0).getUsername());
        modelAndView.addObject("id", id);
        modelAndView.setViewName("changePassword");
        return modelAndView;
    }
    @RequestMapping(value="/changePassword-user",method = RequestMethod.POST)
    @ResponseBody
    public String changePassword(@RequestParam(value = "id") Long id,
                        @RequestParam(value = "originPassword") String originPassword,
                                 @RequestParam(value = "newPassword") String newPassword){
        User user = userDao.getId(id).get(0);
        if(user.getPassword().equals(originPassword)) {
            user.setPassword(newPassword);
            userDao.update(user);
            return "success";
        }else {
            return "error_origin";
        }
    }
}
