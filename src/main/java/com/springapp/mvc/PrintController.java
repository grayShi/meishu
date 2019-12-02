package com.springapp.mvc;

import com.springapp.classes.searchSql;
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
 * Created by hello on 2016/7/5.
 */
@Controller
public class PrintController extends BaseController {
    @RequestMapping(value = "/print", method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<String> messageList = messageDao.findAll("select distinct subject from message where isDelete = 0 " +sql,request);
        List<subject> subjectList = new ArrayList<subject>();
        String sub1;
        String subId;
        if(messageList.size()!=0)
        for (String a : messageList) {
            sub1 = "";
            subId = "";
            char[] sub = a.toCharArray();
            for (int i = 0; i < sub.length; i++) {
                if (sub[i] == '￥') {
                    for (int x = i + 1; x < sub.length; x++)
                        sub1 += sub[x];
                    break;
                } else
                    subId += sub[i];
            }
            subject Subject = new subject();
            Subject.setSubject(sub1);
            Subject.setId(Long.parseLong(subId));
            subjectList.add(Subject);
        }
        modelAndView.addObject("subjectList", subjectList);
        List<message> levelList = messageDao.findAll("select distinct level from message where isDelete = 0 "+sql+" order by level",request);
        if (levelList.size() != 0) {
            if (levelList.get(0) == null && levelList.size() == 1)
                levelList = new ArrayList<>();
        }
        modelAndView.addObject("levelList", levelList);
        List<message> reportPlace = messageDao.findAll("select distinct reportPlace from message where isDelete = 0 " +sql,request);
        if (reportPlace.size() != 0)
            if (reportPlace.get(0) == null && reportPlace.size() == 1)
                reportPlace = new ArrayList<>();
        modelAndView.addObject("reportPlaceList", reportPlace);
        List<message> examTime = messageDao.findAll("select distinct time from message where isDelete = 0 and time IS NOT NULL "+sql+" order by time",request);
        if (examTime.size() != 0)
            if (examTime.get(0) == null && examTime.size() == 1)
                examTime = new ArrayList<>();
        modelAndView.addObject("examTime", examTime);
        modelAndView.setViewName("print");
        return modelAndView;
    }

    @RequestMapping(value = "/print-getSearch", method = RequestMethod.POST)
    @ResponseBody
    public String getSearch(HttpServletRequest request, @RequestParam(value = "examTime") String examTime, @RequestParam(value = "subject") String subject, @RequestParam(value = "level") String level,
                            @RequestParam(value = "reportPlace") String reportPlace, @RequestParam(value = "subPlace") String subPlace) {
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        String sql = "from message where isDelete = 0 and isPay = true and classPlace IS NOT NULL and examPlace IS NOT NULL ";
        String sql1 = "";
        String sql2 = "";
        String sql3 = "";
        String sql4 = "";
        String sql5 = "";
        if (!examTime.equals("0") || !subject.equals("0") || !level.equals("0") || !reportPlace.equals("0") || !subPlace.equals("0"))
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
        if (!examTime.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("") || !sql3.equals("") || !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time = '" + examTime + "'";
        }
        sql += sql1 + sql2 + sql3 + sql4 + sql5 + sql6;
        List<message> list = messageDao.findAll(sql,request);
        return JSONArray.fromObject(list).toString();
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.addObject("levelList",JSONArray.fromObject(levelList).toString());
//        modelAndView.setViewName("print_search");
//        return modelAndView;
    }

    @RequestMapping(value = "/print-detail", method = RequestMethod.GET)
    public ModelAndView print_detail(HttpServletRequest request, @RequestParam(value = "examTime") String examTime, @RequestParam(value = "subject") String subject, @RequestParam(value = "level") String level,
                                     @RequestParam(value = "reportPlace") String reportPlace, @RequestParam(value = "subPlace") String subPlace, @RequestParam(value = "remark") String remark, @RequestParam(value = "title") String title) {
        searchSql search = new searchSql();
        String sql6 = search.getSession(request);
        String sql = "from message where isDelete = 0 and isPay = true ";
        String sql1 = "";
        String sql2 = "";
        String sql3 = "";
        String sql4 = "";
        String sql5 = "";
        if (!examTime.equals("0") || !subject.equals("0") || !level.equals("0") || !reportPlace.equals("0") || !subPlace.equals("0"))
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
        if (!examTime.equals("0")) {
            if (!sql1.equals("") || !sql2.equals("") || !sql3.equals("") || !sql4.equals(""))
                sql5 += " and ";
            sql5 += "time = '" + examTime + "'";
        }
        sql += sql1 + sql2 + sql3 + sql4 + sql5 + sql6 + " and examPlace IS NOT NULL and classPlace IS NOT NULL";
        List<message> list = messageDao.findAll(sql,request);
        String Subject = "";
        char[] sub;
        for (message x : list) {
            sub = x.getSubject().toCharArray();
            for (int i = 0; i < sub.length; i++) {
                if (sub[i] == '￥') {
                    for (int m = i + 1; m < sub.length; m++)
                        Subject += sub[m];
                    break;
                }
            }
            x.setSubject(Subject);
            x.setReportPlace(x.getCardNumber().substring(2, 6));
            Subject = "";
            sub = null;
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", list);
        modelAndView.addObject("remark", remark);
        modelAndView.addObject("title", title);
        modelAndView.setViewName("print-detail");
        return modelAndView;
    }
}
