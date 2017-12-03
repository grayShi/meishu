package com.springapp.mvc;

import com.springapp.entity.message;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
@RequestMapping(value = "/search1")
public class search1Controller extends BaseController{
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView) {
        modelAndView.setViewName("search1");
        return modelAndView;
    }
    @RequestMapping(value="/getSearch",method = RequestMethod.POST)
    @ResponseBody
    public String getSearch(@RequestParam(value="condition1")String condition1,@RequestParam(value="operator1")String operator1,@RequestParam(value="number1")String number1,@RequestParam(value="connect1")String connect1,
                            @RequestParam(value="condition2")String condition2,@RequestParam(value="operator2")String operator2,@RequestParam(value="number2")String number2,@RequestParam(value="connect2")String connect2,
                            @RequestParam(value="condition3")String condition3,@RequestParam(value="operator3")String operator3,@RequestParam(value="number3")String number3,@RequestParam(value="connect3")String connect3,
                            @RequestParam(value="condition4")String condition4,@RequestParam(value="operator4")String operator4,@RequestParam(value="number4")String number4,@RequestParam(value="connect4")String connect4,
                            @RequestParam(value="condition5")String condition5,@RequestParam(value="operator5")String operator5,@RequestParam(value="number5")String number5){
        String sql="";
        String sql1=" and ";
        if(!condition1.equals("0") && !operator1.equals("0")){
            if(operator1.equals("like"))
                sql+=condition1+" "+operator1 + " '%"+number1+"%' ";
            else
                sql+=condition1+" "+operator1 + " '"+number1+"' ";
            if(!connect1.equals("0"))
                sql+=" "+connect1+" ";
        }

        if(!condition2.equals("0") && !operator2.equals("0")){
            if(operator1.equals("like"))
                sql+=condition2+" "+operator2 + " '%"+number2+"%' ";
            else
                sql+=condition2+" "+operator2 + " '"+number2+"' ";
            if(!connect2.equals("0"))
                sql+=" "+connect2+" ";
        }

        if(!condition3.equals("0") && !operator3.equals("0")){
            if(operator3.equals("like"))
                sql+=condition3+" "+operator3 + " '%"+number3+"%' ";
            else
                sql+=condition3+" "+operator3 + " '"+number3+"' ";
            if(!connect3.equals("0"))
                sql+=" "+connect3+" ";
        }

        if(!condition4.equals("0") && !operator4.equals("0")){
            if(operator4.equals("like"))
                sql+=condition4+" "+operator4 + " '%"+number4+"%' ";
            else
                sql+=condition4+" "+operator4 + " '"+number4+"' ";
            if(!connect4.equals("0"))
                sql+=" "+connect4+" ";
        }

        if(!condition5.equals("0") && !operator5.equals("0")){
            if(operator5.equals("like"))
                sql+=condition5+" "+operator5 + " '%"+number5+"%' ";
            else
                sql+=condition5+" "+operator5 + " '"+number5+"' ";
        }
        if(!sql.trim().equals(""))
            sql = sql1+sql;
        List<message> messageList= messageDao.findAll("from message where isDelete = 0 "+sql);
        return JSONArray.fromObject(messageList).toString();

    }
}
