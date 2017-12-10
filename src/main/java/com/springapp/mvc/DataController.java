package com.springapp.mvc;


import com.springapp.classes.searchSql;
import com.springapp.entity.levelTable;
import com.springapp.entity.message;
import com.springapp.entity.subject;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import org.apache.tools.ant.taskdefs.email.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class DataController extends BaseController{
    @RequestMapping(value = "/data",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<String> messageList = messageDao.findAll("select distinct subject from message where isDelete = 0" + sql);
        List<subject> subjectList = new ArrayList<subject>();
        String sub1;
        String subId;
        for(String a : messageList) {
            sub1="";
            subId="";
            char[] sub = a.toCharArray();
            for (int i = 0; i < sub.length; i++) {
                if (sub[i] == '￥') {
                    for (int x = i + 1; x < sub.length; x++)
                        sub1 += sub[x];
                    break;
                }
                else
                    subId+=sub[i];
            }
            subject Subject = new subject();
            Subject.setSubject(sub1);
            Subject.setId(Long.parseLong(subId));
            subjectList.add(Subject);
        }
        modelAndView.addObject("subjectList",subjectList);
        List<message> levelList = messageDao.findAll("select distinct level from message where isDelete = 0 and level IS NOT NULL "+sql+" order by level");
        modelAndView.addObject("levelList",levelList);
        List<message> reportPlace = messageDao.findAll("select distinct reportPlace from message where isDelete = 0 and reportPlace IS NOT NULL"+ sql);
        modelAndView.addObject("reportPlaceList",reportPlace);
        List<message> yearList = messageDao.findAll("select distinct time from message where isDelete = 0 and time IS NOT NULL" + sql);
        if(yearList.size() == 0)
            modelAndView.addObject("yearList",new ArrayList<message>());
        else {
            modelAndView.addObject("yearList", yearList);
        }
        modelAndView.setViewName("data");
        return modelAndView;
    }
    @RequestMapping(value = "/data-setSubPlace",method=RequestMethod.POST)
    @ResponseBody
    public String setSubPlace(HttpServletRequest request, @RequestParam(value = "reportPlace")String reportPlace){
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<message> subPlaceList = messageDao.findAll("select distinct subPlace from message where isDelete = 0 and reportPlace = '"+reportPlace+"' "+sql);
        return JSONArray.fromObject(subPlaceList).toString();
    }
    @RequestMapping(value = "/data-setLevel",method=RequestMethod.POST)
    @ResponseBody
    public String setLevel(HttpServletRequest request, @RequestParam(value = "subject")String subject){
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<message> levelList = messageDao.findAll("select distinct level from message where isDelete = 0 and subject = '"+subject+"'"+ sql+ " order by level");
        return JSONArray.fromObject(levelList).toString();
    }
    @RequestMapping(value="/data-getLevel",method = RequestMethod.POST)
    @ResponseBody
    public String getLevel(HttpServletRequest request, @RequestParam(value="Subject")String subject,@RequestParam(value="Level") String level,
                           @RequestParam(value="ReportPlace")String reportPlace, @RequestParam(value="SubPlace")String subPlace,@RequestParam(value="year")String year){
        String sql="select subject,level,count(*) from message where isDelete = 0";
        String sql1="";
        String sql2="";
        String sql3="";
        String sql4="";
        String sql5="";
        if(!subject.equals("0") || !level.equals("0")  ||! reportPlace.equals("0") || !subPlace.equals("0")|| !year.equals("0"))
            sql+="and ";
        if(!subject.equals("0"))
            sql1="subject = '"+subject+"'";
        if(!level.equals("0")){
            if(!sql1.equals(""))
                sql2+=" and ";
            sql2 += "level = " + level;
        }
        if(! reportPlace.equals("0")) {
            if(!sql1.equals("") || !sql2.equals(""))
                sql3+=" and ";
            sql3 += "reportPlace = '" + reportPlace + "'";
        }
        if( !subPlace.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals(""))
                sql4 += " and ";
            sql4 += "subPlace = '" + subPlace + "'";
        }
        if( !year.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals("")|| !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time like '" + year + "%'";
        }
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        sql+=sql1+sql2+sql3+sql4+sql5+sql6+" GROUP BY subject,level order by subject";
        List<message> levelList = messageDao.findAll(sql);
        List<levelTable> tableList = new ArrayList<levelTable>();
        levelTable list = new levelTable();
        List x;
        List y;

        for(int i = 0; i < levelList.size(); i++) {
            x=JSONArray.fromObject(levelList.get(i));
            if(i!=levelList.size()-1)
                 y=JSONArray.fromObject(levelList.get(i+1));
            else
                y=x;
            String sub1="";
            char[] sub = x.get(0).toString().toCharArray();
            for (int m = 0; m < sub.length; m++) {
                if (sub[m] == '￥') {
                    for (int n = m + 1; n < sub.length; n++)
                        sub1 += sub[n];
                    break;
                }
            }
            list.setSubject(sub1);

            if(x.get(1).toString().equals("1"))
                list.setLevelCount1(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("2"))
                list.setLevelCount2(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("3"))
                list.setLevelCount3(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("4"))
                list.setLevelCount4(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("5"))
                list.setLevelCount5(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("6"))
                list.setLevelCount6(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("7"))
                list.setLevelCount7(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("8"))
                list.setLevelCount8(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("9"))
                list.setLevelCount9(Integer.parseInt(x.get(2).toString()));
            else if(x.get(1).toString().equals("10"))
                list.setLevelCount10(Integer.parseInt(x.get(2).toString()));
            if(!x.get(0).toString().equals(y.get(0).toString()) && i!=levelList.size()-1){
                tableList.add(list);
                list = new levelTable();
            }
            else if(i==levelList.size()-1)
                tableList.add(list);
        }

         return JSONArray.fromObject(tableList).toString();

    }
    @RequestMapping(value="/data-getSubject",method = RequestMethod.POST)
    @ResponseBody
    public String getSubject(HttpServletRequest request, @RequestParam(value="Subject")String subject,@RequestParam(value="Level") String level,
                           @RequestParam(value="ReportPlace")String reportPlace, @RequestParam(value="SubPlace")String subPlace,@RequestParam(value="year")String year){
        String sql="select subject,count(*) from message where isDelete = 0";
        String sql1="";
        String sql2="";
        String sql3="";
        String sql4="";
        String sql5="";
        if(!subject.equals("0") || !level.equals("0")  ||! reportPlace.equals("0") || !subPlace.equals("0")|| !year.equals("0"))
            sql+="and ";
        if(!subject.equals("0"))
            sql1="subject = '"+subject+"'";
        if(!level.equals("0")){
            if(!sql1.equals(""))
                sql2+=" and ";
            sql2 += "level = " + level;
        }
        if(! reportPlace.equals("0")) {
            if(!sql1.equals("") || !sql2.equals(""))
                sql3+=" and ";
            sql3 += "reportPlace = '" + reportPlace + "'";
        }
        if( !subPlace.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals(""))
                sql4 += " and ";
            sql4 += "subPlace = '" + subPlace + "'";
        }
        if( !year.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals("")|| !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time like '" + year + "%'";
        }
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        sql+=sql1+sql2+sql3+sql4+sql5+sql6+" GROUP BY subject order by subject";
        List<message> subjectList = messageDao.findAll(sql);
        List<levelTable> tableList = new ArrayList<levelTable>();
        List x;
        for(int i = 0; i < subjectList.size(); i++) {
            levelTable list = new levelTable();
            x = JSONArray.fromObject(subjectList.get(i));
            String sub1="";
            char[] sub = x.get(0).toString().toCharArray();
            for (int m = 0; m < sub.length; m++) {
                if (sub[m] == '￥') {
                    for (int n = m + 1; n < sub.length; n++)
                        sub1 += sub[n];
                    break;
                }
            }
            list.setSubject(sub1);
            list.setLevelCount1(Integer.parseInt(x.get(1).toString()));
            tableList.add(list);
        }
        return JSONArray.fromObject(tableList).toString();
    }
    @RequestMapping(value="/data-getSex",method = RequestMethod.POST)
    @ResponseBody
    public String getSex(HttpServletRequest request, @RequestParam(value="Subject")String subject,@RequestParam(value="Level") String level,
                             @RequestParam(value="ReportPlace")String reportPlace, @RequestParam(value="SubPlace")String subPlace,@RequestParam(value="year")String year){
        String sql="select sex,count(*) from message where isDelete = 0";
        String sql1="";
        String sql2="";
        String sql3="";
        String sql4="";
        String sql5="";
        if(!subject.equals("0") || !level.equals("0")  ||! reportPlace.equals("0") || !subPlace.equals("0")|| !year.equals("0"))
            sql+="and ";
        if(!subject.equals("0"))
            sql1="subject = '"+subject+"'";
        if(!level.equals("0")){
            if(!sql1.equals(""))
                sql2+=" and ";
            sql2 += "level = " + level;
        }
        if(! reportPlace.equals("0")) {
            if(!sql1.equals("") || !sql2.equals(""))
                sql3+=" and ";
            sql3 += "reportPlace = '" + reportPlace + "'";
        }
        if( !subPlace.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals(""))
                sql4 += " and ";
            sql4 += "subPlace = '" + subPlace + "'";
        }
        if( !year.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("")|| !sql3.equals("")|| !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time like '" + year + "%'";
        }
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        sql+=sql1+sql2+sql3+sql4+sql5+sql6+" GROUP BY sex order by subject";
        List<message> subjectList = messageDao.findAll(sql);
        List<levelTable> tableList = new ArrayList<levelTable>();
        List x;
        for(int i = 0; i < subjectList.size(); i++) {
            levelTable list = new levelTable();
            x = JSONArray.fromObject(subjectList.get(i));
            list.setSubject(x.get(0).toString());
            list.setLevelCount1(Integer.parseInt(x.get(1).toString()));
            tableList.add(list);
        }
        return JSONArray.fromObject(tableList).toString();
    }
    @RequestMapping(value="/data-getYear",method = RequestMethod.POST)
    @ResponseBody
    public String getYear(HttpServletRequest request, @RequestParam(value="Subject")String subject,@RequestParam(value="Level") String level,
                         @RequestParam(value="ReportPlace")String reportPlace, @RequestParam(value="SubPlace")String subPlace,@RequestParam(value="year")String year) {
        String sql = "select MONTH(time),count(*) from message where isDelete = 0";
        String sql1 = "";
        String sql2 = "";
        String sql3 = "";
        String sql4 = "";
        String sql5 = "";
        if (!subject.equals("0") || !level.equals("0") || !reportPlace.equals("0") || !subPlace.equals("0") || !year.equals("0"))
            sql += "and ";
        if (!subject.equals("0"))
            sql1 = "subject = '" + subject + "'";
        if (!level.equals("0")) {
            if (!sql1.equals(""))
                sql2 += " and ";
            sql2 += "level = " + level;
        }
        if (!reportPlace.equals("0")) {
            if (!sql1.equals("") || !sql2.equals(""))
                sql3 += " and ";
            sql3 += "reportPlace = '" + reportPlace + "'";
        }
        if (!subPlace.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("") || !sql3.equals(""))
                sql4 += " and ";
            sql4 += "subPlace = '" + subPlace + "'";
        }
        if (!year.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("") || !sql3.equals("") || !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time like '" + year + "%'";
        }
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        sql += sql1 + sql2 + sql3 + sql4 + sql5+sql6 + " GROUP BY MONTH(time) order by MONTH(time)";
        List<message> yearList = messageDao.findAll(sql);
        List<levelTable> tableList = new ArrayList<levelTable>();
        List x;
        for(int i = 0; i < yearList.size(); i++) {
            levelTable list = new levelTable();
            x = JSONArray.fromObject(yearList.get(i));
            list.setSubject(x.get(0).toString());
            list.setLevelCount1(Integer.parseInt(x.get(1).toString()));
            tableList.add(list);
        }
        return JSONArray.fromObject(tableList).toString();
    }
}
