package com.springapp.mvc;

import com.springapp.entity.commitCost;
import com.springapp.entity.cost;
import com.springapp.entity.cost1;
import com.springapp.entity.message;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "**")
public class CommitCostController extends BaseController{
    @RequestMapping(value="/commitCost",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView, HttpServletRequest request){
        List<commitCost> commitCostList= this.costCommitDao.findAll("select commitCost.id,commitCost.placeId,reportPlace.place,reportPlace.subPlace,commitCost.count,commitCost.totalCost, commitCost.isDelete from commitCost commitCost,reportPlace reportPlace where commitCost.placeId = reportPlace.realId",request);
        List <cost1> allCostList = new ArrayList<>();
        for(int i=0;i<commitCostList.size();i++) {
            cost1 cost = new cost1();
            List result = JSONArray.fromObject(commitCostList.get(i));
            cost.setId(result.get(0).toString());
            cost.setSubID(result.get(1).toString());
            cost.setReportPlace(result.get(2).toString());
            cost.setSubPlace(result.get(3).toString());
//            cost.setLevel(Integer.parseInt(result.get(4).toString()));
            cost.setCount(Integer.parseInt(result.get(4).toString()));
            cost.setRemark(Double.parseDouble(result.get(5).toString()));
            if(result.get(6).toString().equals("1")) {
                cost.setConfirm("已确认缴费");
            } else {
                cost.setConfirm("等待确认缴费");
            }

            allCostList.add(cost);
        }
        modelAndView.addObject("allCostList",allCostList);
        modelAndView.setViewName("commitCost");
        return modelAndView;
    }

    @RequestMapping(value="/commitCost-delete",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long[] id, HttpServletRequest request){
        List<commitCost> commitCosts = costCommitDao.getId(id,request);
        for(commitCost commitCost : commitCosts) {
            costCommitDao.delete(commitCost, request);
        }
        return "success";
    }

    @RequestMapping(value="/commitCost-commit",method = RequestMethod.POST)
    @ResponseBody
    public String commit(@RequestParam(value = "id") Long[] id, HttpServletRequest request){
        List<commitCost> commitCosts = costCommitDao.getId(id,request);
        for(commitCost commitCost : commitCosts) {
            List<message>messageList = messageDao.findAll("from message where isDelete = 0 and subPlace like '"+commitCost.getPlaceId()+"￥%' and level in ("+commitCost.getLevel()+") and isPay = false order by id",request);
            if(messageList.size() >= commitCost.getCount()){
                for(int i =0;i<commitCost.getCount();i++) {
                    messageList.get(i).setIsPay(true);
                }
                messageDao.update(messageList,request);
            } else {
                commitCost.setIsDelete(messageList.size()); // 目前有多少没有缴费的人
                return JSONArray.fromObject(commitCost).toString();
            }
            commitCost.setIsDelete(1);
            commitCost.setConfirmDate(new Date());
            costCommitDao.update(commitCost, request);
        }
        return JSONArray.fromObject(new commitCost()).toString();
    }
}
