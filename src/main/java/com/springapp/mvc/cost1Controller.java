package com.springapp.mvc;

import com.springapp.classes.searchSql;
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
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class cost1Controller extends BaseController{
    @RequestMapping(value = "/cost1",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
//        List<message> levelList = messageDao.findAll("select reportPlace,subPlace,level,count(*),time from message as message where isDelete = 0 group by reportPlace,subPlace,level,message.time");
//        List levelCount;
//        List<cost1> allCostList = new ArrayList<cost1>();
//        int totalCount = 0;
//        Double totalBaomingfei = 0.0,totalKaowufei = 0.0,totalZhengshufei = 0.0,totalRemark = 0.0;
//        for(int i=0;i<levelList.size();i++) {
//            levelCount = JSONArray.fromObject(levelList.get(i));
//            cost1 x = new cost1();
//            x.setReportPlace(levelCount.get(0).toString());
//            String sub1="";
//            String subId="";
//            char[] sub = levelCount.get(1).toString().toCharArray();
//            for (int m = 0; m < sub.length; m++) {
//                if (sub[m] == '￥') {
//                    for (int n = m + 1; n < sub.length; n++)
//                        sub1 += sub[n];
//                    break;
//                }
//                subId+=sub[m];
//            }
//            x.setSubPlace(sub1);
//            x.setLevel(Integer.parseInt(levelCount.get(2).toString()));
//            List<cost> costList = costDao.findAll("from cost where level = " + Integer.parseInt(levelCount.get(2).toString()));
//            if(costList.size()!=0){
//                x.setCount(Integer.parseInt(levelCount.get(3).toString()));
//                x.setBaomingfei(costList.get(0).getBaomingfei() * x.getCount());
//                x.setKaowufei(costList.get(0).getKaowufei() * x.getCount());
//                x.setZhengshufei(costList.get(0).getZhengshufei() * x.getCount());
//                x.setRemark(costList.get(0).getRemark() * x.getCount());
//                x.setSubID(subId);
//                totalCount += x.getCount();
//                totalBaomingfei += x.getBaomingfei();
//                totalKaowufei += x.getKaowufei();
//                totalZhengshufei += x.getZhengshufei();
//                totalRemark += x.getRemark();
//            }
//            else{
//                x.setCount(0);
//                x.setSubID(subId);
//                x.setBaomingfei(0.0);
//                x.setKaowufei(0.0);
//                x.setZhengshufei(0.0);
//                x.setRemark(0.0);
//                totalCount += x.getCount();
//                totalBaomingfei += x.getBaomingfei();
//                totalKaowufei += x.getKaowufei();
//                totalZhengshufei += x.getZhengshufei();
//                totalRemark += x.getRemark();
//            }
//            x.setStartTime(levelCount.get(4).toString());
//            allCostList.add(x);
//        }
//        List<cost1> totalCostList = new ArrayList<cost1>();
//        cost1 y = new cost1();
//        Double Baomingfei = 0.0, Kaowufei = 0.0, Zhengshufei = 0.0, Remark = 0.0;
//        int count = 0;
//        if(allCostList.size()!=0) {
//            String newId = allCostList.get(0).getSubID();
//            String newStart = allCostList.get(0).getStartTime();
//            for (int i = 0; i < allCostList.size(); i++) {
//                if (!allCostList.get(i).getSubID().equals(newId) || !allCostList.get(i).getStartTime().equals(newStart)) {
//                    y.setSubID(newId);
//                    y.setStartTime(newStart);
//                    y.setBaomingfei(Baomingfei);
//                    y.setZhengshufei(Zhengshufei);
//                    y.setKaowufei(Kaowufei);
//                    y.setRemark(Remark);
//                    y.setCount(count);
//                    newId = allCostList.get(i).getSubID();
//                    newStart = allCostList.get(i).getStartTime();
//                    i--;
//                    y.setReportPlace(allCostList.get(i).getReportPlace());
//                    y.setSubPlace(allCostList.get(i).getSubPlace());
//                    totalCostList.add(y);
//                    y = new cost1();
//                    Baomingfei = 0.0;
//                    Kaowufei = 0.0;
//                    Zhengshufei = 0.0;
//                    Remark = 0.0;
//                    count = 0;
//                    continue;
//                }
//                Baomingfei += allCostList.get(i).getBaomingfei();
//                Kaowufei += allCostList.get(i).getKaowufei();
//                Zhengshufei += allCostList.get(i).getZhengshufei();
//                count += allCostList.get(i).getCount();
//                Remark += allCostList.get(i).getRemark();
//
//            }
//            y = new cost1();
//            y.setSubID(newId);
//            y.setReportPlace(allCostList.get(allCostList.size() - 1).getReportPlace());
//            y.setSubPlace(allCostList.get(allCostList.size() - 1).getSubPlace());
//            y.setStartTime(allCostList.get(allCostList.size() - 1).getStartTime());
//            y.setBaomingfei(Baomingfei);
//            y.setZhengshufei(Zhengshufei);
//            y.setKaowufei(Kaowufei);
//            y.setRemark(Remark);
//            y.setCount(count);
//            totalCostList.add(y);
//        }
//        modelAndView.addObject("totalCostList",totalCostList);
//        cost1 total = new cost1();
//        total.setCount(totalCount);
//        total.setBaomingfei(totalBaomingfei);
//        total.setKaowufei(totalKaowufei);
//        total.setZhengshufei(totalZhengshufei);
//        total.setRemark(totalRemark);
//        modelAndView.addObject("totalCost",total);
//        List<message> levelList1 = messageDao.findAll("select distinct level from message where isDelete = 0 order by level");
//        modelAndView.addObject("levelList1",levelList1);
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<message> reportPlaceList = messageDao.findAll("select distinct reportPlace from message where isDelete = 0" +sql);
        modelAndView.addObject("reportPlaceList",reportPlaceList);
//        List<message> examTime = messageDao.findAll("select distinct time from message where isDelete = 0 and time IS NOT NULL order by time");
//        if (examTime.size() != 0)
//            if (examTime.get(0) == null && examTime.size() == 1)
//                examTime = new ArrayList<>();
//        modelAndView.addObject("examTime", examTime);
        List<message> endTimeList = messageDao.findAll("select distinct endSignUpTime from message where isDelete = 0 and endSignUpTime IS NOT NULL "+sql+"");
        modelAndView.addObject("endTimeList",endTimeList);
        modelAndView.setViewName("cost1");
        return modelAndView;
    }
    @RequestMapping(value="/cost1-getSearch",method = RequestMethod.POST)
    @ResponseBody
    public String getLevel(HttpServletRequest request, @RequestParam(value="endSignUpTime") String endSignUpTime,
                           @RequestParam(value="reportPlace")String reportPlace, @RequestParam(value="subPlace")String subPlace){
        searchSql search = new searchSql();
        String sql1 = search.getSession(request);
        String sql2="";
        String sql3="";
        String sql4="";
        String sql = "select reportPlace,subPlace,level,count(*),time from message as message where isDelete = 0 "+ sql1;
        if(!reportPlace.equals("0") || !subPlace.equals("0") || !endSignUpTime.equals("0"))
            sql+="and ";
        if(! reportPlace.equals("0")) {
            sql2 += "reportPlace = '" + reportPlace + "'";
        }
        if( !endSignUpTime.equals("0")) {
            if (!sql2.equals(""))
                sql3 += " and ";
            sql3 += "message.endSignUpTime = '" + endSignUpTime + "'";
        }
        if( !subPlace.equals("0")) {
            if (!sql2.equals("")|| !sql3.equals(""))
                sql4 += " and ";
            sql4 += "subPlace = '" + subPlace + "'";
        }
        sql+=sql2+sql3+sql4+" group by reportPlace,subPlace,level,message.endSignUpTime";
        List<message> levelList = messageDao.findAll(sql);
        List levelCount;
        List<cost1> allCostList = new ArrayList<cost1>();
        int totalCount = 0;
        Double totalBaomingfei = 0.0,totalKaowufei = 0.0,totalZhengshufei = 0.0,totalRemark = 0.0;
        for(int i=0;i<levelList.size();i++) {
            levelCount = JSONArray.fromObject(levelList.get(i));
            cost1 x = new cost1();
            x.setReportPlace(levelCount.get(0).toString());
            String sub1="";
            String subId = "";
            char[] sub = levelCount.get(1).toString().toCharArray();
            for (int m = 0; m < sub.length; m++) {
                if (sub[m] == '￥') {
                    for (int n = m + 1; n < sub.length; n++)
                        sub1 += sub[n];
                    break;
                }
                subId+=sub[m];
            }
            x.setSubPlace(sub1);
            x.setLevel(Integer.parseInt(levelCount.get(2).toString()));
            List<cost> costList = costDao.findAll("from cost where level = " + Integer.parseInt(levelCount.get(2).toString()));
            if(costList.size()!=0){
                x.setCount(Integer.parseInt(levelCount.get(3).toString()));
                x.setBaomingfei(costList.get(0).getBaomingfei() * x.getCount());
                x.setKaowufei(costList.get(0).getKaowufei() * x.getCount());
                x.setZhengshufei(costList.get(0).getZhengshufei() * x.getCount());
                x.setRemark(costList.get(0).getRemark() * x.getCount());
                x.setSubID(subId);
                totalCount += x.getCount();
                totalBaomingfei += x.getBaomingfei();
                totalKaowufei += x.getKaowufei();
                totalZhengshufei += x.getZhengshufei();
                totalRemark += x.getRemark();
            }
            else{
                x.setCount(0);
                x.setBaomingfei(0.0);
                x.setKaowufei(0.0);
                x.setZhengshufei(0.0);
                x.setRemark(0.0);
                x.setSubID(subId);
                totalCount += x.getCount();
                totalBaomingfei += x.getBaomingfei();
                totalKaowufei += x.getKaowufei();
                totalZhengshufei += x.getZhengshufei();
                totalRemark += x.getRemark();
            }
            x.setStartTime(levelCount.get(4).toString());
            allCostList.add(x);
        }

        List<cost1> totalCostList = new ArrayList<cost1>();
        cost1 y = new cost1();
        Double Baomingfei = 0.0,Kaowufei = 0.0,Zhengshufei = 0.0,Remark = 0.0;
        int count = 0;
        if(allCostList.size()!=0) {
            String newId = allCostList.get(0).getSubID();
            String newStart = allCostList.get(0).getStartTime();
            for (int i = 0; i < allCostList.size(); i++) {
                if (!allCostList.get(i).getSubID().equals(newId)) {
                    y.setSubID(newId);
                    y.setStartTime(newStart);
                    y.setBaomingfei(Baomingfei);
                    y.setZhengshufei(Zhengshufei);
                    y.setKaowufei(Kaowufei);
                    y.setRemark(Remark);
                    y.setCount(count);
                    newId = allCostList.get(i).getSubID();
                    newStart = allCostList.get(i).getStartTime();
                    i--;
                    y.setReportPlace(allCostList.get(i).getReportPlace());
                    y.setSubPlace(allCostList.get(i).getSubPlace());
                    totalCostList.add(y);
                    y = new cost1();
                    Baomingfei = 0.0;
                    Kaowufei = 0.0;
                    Zhengshufei = 0.0;
                    Remark = 0.0;
                    count = 0;
                    continue;
                }
                Baomingfei += allCostList.get(i).getBaomingfei();
                Kaowufei += allCostList.get(i).getKaowufei();
                Zhengshufei += allCostList.get(i).getZhengshufei();
                count += allCostList.get(i).getCount();
                Remark += allCostList.get(i).getRemark();

            }
            y = new cost1();
            y.setSubID(newId);
            y.setReportPlace(allCostList.get(allCostList.size() - 1).getReportPlace());
            y.setSubPlace(allCostList.get(allCostList.size() - 1).getSubPlace());
            if(!allCostList.get(allCostList.size() - 1).getStartTime().equals("null")){
                y.setStartTime(allCostList.get(allCostList.size() - 1).getStartTime());
            } else {
                y.setStartTime("");
            }
            y.setBaomingfei(Baomingfei);
            y.setZhengshufei(Zhengshufei);
            y.setKaowufei(Kaowufei);
            y.setRemark(Remark);
            y.setCount(count);
            totalCostList.add(y);
        }
        cost1 total = new cost1();
        total.setCount(totalCount);
        total.setBaomingfei(totalBaomingfei);
        total.setKaowufei(totalKaowufei);
        total.setZhengshufei(totalZhengshufei);
        total.setRemark(totalRemark);
        totalCostList.add(total);
        return JSONArray.fromObject(totalCostList).toString();
    }
    @RequestMapping(value = "/cost1-detail",method = RequestMethod.GET)
    public ModelAndView home1(@RequestParam(value="subID")String subID) {
        ModelAndView modelAndView = new ModelAndView();
        List<message> levelList = messageDao.findAll("select reportPlace,subPlace,level,count(*) from message where isDelete = 0 and subPlace like '"+subID+"￥%' group by reportPlace,subPlace,level");
        List levelCount;
        List<cost1> allCostList = new ArrayList<cost1>();
        int totalCount = 0;
        Double totalBaomingfei = 0.0,totalKaowufei = 0.0,totalZhengshufei = 0.0,totalRemark = 0.0;
        for(int i=0;i<levelList.size();i++) {
            levelCount = JSONArray.fromObject(levelList.get(i));
            cost1 x = new cost1();
            x.setReportPlace(levelCount.get(0).toString());
            String sub1="";
            String subId="";
            char[] sub = levelCount.get(1).toString().toCharArray();
            for (int m = 0; m < sub.length; m++) {
                if (sub[m] == '￥') {
                    for (int n = m + 1; n < sub.length; n++)
                        sub1 += sub[n];
                    break;
                }
                subId+=sub[m];
            }
            x.setSubPlace(sub1);
            x.setLevel(Integer.parseInt(levelCount.get(2).toString()));
            List<cost> costList = costDao.findAll("from cost where level = " + Integer.parseInt(levelCount.get(2).toString()));
            if(costList.size()!=0){
                x.setCount(Integer.parseInt(levelCount.get(3).toString()));
                x.setBaomingfei(costList.get(0).getBaomingfei() * x.getCount());
                x.setKaowufei(costList.get(0).getKaowufei() * x.getCount());
                x.setZhengshufei(costList.get(0).getZhengshufei() * x.getCount());
                x.setRemark(costList.get(0).getRemark() * x.getCount());
                x.setSubID(subId);
                totalCount += x.getCount();
                totalBaomingfei += x.getBaomingfei();
                totalKaowufei += x.getKaowufei();
                totalZhengshufei += x.getZhengshufei();
                totalRemark += x.getRemark();
            }
            else{
                x.setCount(Integer.parseInt(levelCount.get(3).toString()));
                x.setSubID(subId);
                x.setBaomingfei(0.0);
                x.setKaowufei(0.0);
                x.setZhengshufei(0.0);
                x.setRemark(0.0);
                totalCount += x.getCount();
                totalBaomingfei += x.getBaomingfei();
                totalKaowufei += x.getKaowufei();
                totalZhengshufei += x.getZhengshufei();
                totalRemark += x.getRemark();
            }
            allCostList.add(x);
        }
        cost1 total = new cost1();
        total.setCount(totalCount);
        total.setBaomingfei(totalBaomingfei);
        total.setKaowufei(totalKaowufei);
        total.setZhengshufei(totalZhengshufei);
        total.setRemark(totalRemark);
        modelAndView.addObject("totalCost",total);
        modelAndView.addObject("allCostList",allCostList);
        modelAndView.setViewName("cost1-detail");
        return modelAndView;
    }
}
