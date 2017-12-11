package com.springapp.mvc;

import com.springapp.entity.User;
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
 * Created by gray shi on 2017/2/23.
 */
@Controller
public class LoginController extends BaseController{
//    @RequestMapping(value = "/",method = RequestMethod.GET)
//    public String home() {
//        return "login";
//    }
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView){
        HttpSession session= request.getSession();
        session.removeAttribute("userId");
        session.removeAttribute("username");
        session.removeAttribute("power");
        modelAndView.setViewName("login");
        return modelAndView;
    }
    @RequestMapping(value = "/login-check",method = RequestMethod.POST)
    @ResponseBody
    public String loginCheck(HttpServletRequest request, @RequestParam(value = "username")String username, @RequestParam(value = "password")String password) {
        HttpSession session= request.getSession();
        List<User> usersList = userDao.findAll("from User where username = '"+username+"'");
        for(User user : usersList){
            if(user.getUsername().equals(username)){
                if (password.equals(user.getPassword())) {
                    session.setAttribute("userId", user.getId()+"");
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("power", user.getPower());
                    session.setAttribute("place", user.getPlace());
                    session.setAttribute("subPlace", user.getSubPlace());
                    return "success";
                }
                return "pwd_error";
            }
        }
        return "usr_error";
    }
    @RequestMapping(value = "/reLogin",method = RequestMethod.GET)
    public ModelAndView reLogin(HttpServletRequest request, ModelAndView modelAndView){
        modelAndView.setViewName("reLogin");
        return modelAndView;
    }
}
