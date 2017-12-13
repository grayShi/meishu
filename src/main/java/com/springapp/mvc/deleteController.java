package com.springapp.mvc;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springapp.classes.FileService;
import com.springapp.classes.searchSql;
import com.springapp.entity.examPlace;
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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hello on 2016/7/5.
 */
@Controller
public class deleteController extends BaseController{
    @RequestMapping(value = "/delete",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelAndView modelAndView) {
        searchSql search = new searchSql();
        String sql = search.getSession(request);
//        List<message> message = messageDao.findAll("from message where isDelete = 0 "+sql);
//        String messageList= JSONArray.fromObject(message).toString();
//        modelAndView.addObject("messageList",messageList);
        List<message> messageReportList=messageDao.findAll("select DISTINCT(reportPlace),subPlace from message where isDelete = 0 "+sql+" GROUP BY reportPlace,subPlace ");
        String messageReport= JSONArray.fromObject(messageReportList).toString();
        modelAndView.addObject("messageReport",messageReport);
        List<message> timeList = messageDao.findAll("select distinct time from message where isDelete = 0 and time IS NOT NULL "+sql+"");
        modelAndView.addObject("timeList",timeList);
        List<message> endTimeList = messageDao.findAll("select distinct endSignUpTime from message where isDelete = 0 and endSignUpTime IS NOT NULL "+sql+"");
        modelAndView.addObject("endTimeList",endTimeList);
        List<message> levelList = messageDao.findAll("select distinct level from message where isDelete = 0 "+sql+" order by level ");
        modelAndView.addObject("levelList",levelList);
        List<subject> subjectList = subjectDao.findAll("from subject");
        modelAndView.addObject("subjectList",subjectList);
        List<examPlace> examPlaceList = examPlaceDao.findAll("from examPlace where 1 = 1"+ sql);
        modelAndView.addObject("examPlaceList",examPlaceList);
        modelAndView.setViewName("delete");
        return modelAndView;
    }
    @RequestMapping(value="/delete-start",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam(value = "id") Long id, HttpServletRequest request){
        List<message> list = messageDao.getId(id);
        list.get(0).setIsDelete(1);
        messageDao.update(list,request);
        return "success";
    }
    @RequestMapping(value="/delete-rollback",method = RequestMethod.POST)
    @ResponseBody
    public String rollback(@RequestParam(value = "id") Long id, HttpServletRequest request){
        List<message> list = messageDao.findAll("from message where isDelete = 1 and id="+id);
        list.get(0).setIsDelete(0);
        messageDao.update(list,request);
        return "success";
    }
    @RequestMapping(value="/delete-startTotal",method = RequestMethod.POST)
    @ResponseBody
    public String deleteTotal(@RequestParam(value = "deleteArray") Long[] deleteArray, HttpServletRequest request){
        for(int i = 0;i<deleteArray.length;i++){
            List<message> list = messageDao.getId(deleteArray[i]);
            list.get(0).setIsDelete(1);
            messageDao.update(list,request);
        }
        return "success";
    }
    @RequestMapping(value="/delete-editMessage",method = RequestMethod.POST)
    @ResponseBody
    public String editMessage(@RequestParam(value = "id") Long id,@RequestParam(value = "editName") String editName,
                                    @RequestParam(value = "editSex") String editSex,@RequestParam(value = "editBirth") String editBirth, HttpServletRequest request){
        List<message> list = messageDao.getId(id);
        list.get(0).setName(editName);
        list.get(0).setSex(editSex);
        list.get(0).setBirth(editBirth);
        messageDao.update(list,request);
        return "success";
    }
    @RequestMapping(value="/delete-search",method = RequestMethod.POST)
    @ResponseBody
    public String search(HttpServletRequest request, @RequestParam(value = "name") String name,@RequestParam(value = "subject") String subject,
                         @RequestParam(value = "level") String level,
                         @RequestParam(value = "cardNumber") String cardNumber,
                         @RequestParam(value = "classPlace") String classPlace,
                         @RequestParam(value = "examPlace") String examPlace,
                         @RequestParam(value = "reportPlace") String reportPlace,
                         @RequestParam(value = "subPlace") String subPlace,
                         @RequestParam(value = "time") String time,
                         @RequestParam(value = "endSignUpTime") String endSignUpTime,
                         @RequestParam(value = "isDelete") Boolean isDelete
                         ){
        String str="from message where ";
        if(isDelete){
            str += "isDelete = 1 ";
        } else {
            str += "isDelete = 0 ";
        }
        if(name!="")
            str+=" and name = '"+name+"'";
        if(!subject.equals("0"))
            str+=" and subject = '"+subject+"'";
        if(!level.equals("0"))
            str+=" and level = '"+level+"'";
        if(!reportPlace.equals("0") && !subPlace.equals("0"))
            str+=" and reportPlace = '"+reportPlace+"' and subPlace = '"+subPlace+"'";
        if(!classPlace.equals("0") && !examPlace.equals("0"))
            str+=" and classPlace = '"+classPlace+"' and examPlace = '"+examPlace+"'";
        if(cardNumber!="")
            str+=" and cardNumber like '%"+cardNumber+"%'";
        if(!time.equals("0"))
            str+=" and time = '"+time+"'";
        if(!endSignUpTime.equals("0"))
            str+=" and endSignUpTime = '"+endSignUpTime+"'";
        searchSql search = new searchSql();
        String sql = search.getSession(request);
        List<message> messageList = messageDao.findAll(str + sql);
        return JSONArray.fromObject(messageList).toString();
    }
    @RequestMapping(value="/delete-getExcel",method = RequestMethod.GET)
    public void getExcel(HttpServletRequest request,@RequestParam(value = "name") String name,@RequestParam(value = "subject") String subject,
                           @RequestParam(value = "level") String level,
                         @RequestParam(value = "cardNumber") String cardNumber,@RequestParam(value = "classPlace") String classPlace,
                                        @RequestParam(value = "examPlace") String examPlace,@RequestParam(value = "reportPlace") String reportPlace,
                                        @RequestParam(value = "time") String time,
                                        @RequestParam(value = "endSignUpTime") String endSignUpTime,
                                        @RequestParam(value = "subPlace") String subPlace,@RequestParam(value = "isDelete") Boolean isDelete,HttpServletResponse resp)throws IOException{
        String searchList=search(request,name,subject,level,cardNumber,classPlace,examPlace,reportPlace,subPlace,time,endSignUpTime,isDelete);
        List<Map> search = JSONArray.fromObject(searchList);
        FileService service = new FileService();
        String[] titles = new String[]{"准考证号","姓名","国籍","民族","性别","出生日期","联系方式","地址","科目","级别","报名省市","机构名称","考点地址","考场地址","考试时间","持续时间"};
        String[] keys = new String[]{"cardNumber","name","country","nation","sex","birth","phoneNumber","address","subject","level","reportPlace","subPlace","examPlace","classPlace","time","examTime"};
        List<Map<String,Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String,Object> map;
        char [] sub;
        String Subject;
        char [] subp;
        String SubPlace;
        for(int i =0;i<search.size();i++) {
            map = new HashMap<String, Object>();
            map.put("cardNumber", search.get(i).get("cardNumber"));
            map.put("name", search.get(i).get("name"));
            map.put("country", search.get(i).get("country"));
            map.put("nation", search.get(i).get("nation"));
            map.put("sex", search.get(i).get("sex"));
            map.put("birth", search.get(i).get("birth"));
            map.put("phoneNumber", search.get(i).get("phoneNumber"));
            map.put("address", search.get(i).get("address"));
            sub = search.get(i).get("subject").toString().toCharArray();
            Subject ="";
            for(int m=0;m<sub.length;m++){
                if(sub[m]=='￥'){
                    for(int x=m+1;x<sub.length;x++)
                        Subject+=sub[x];
                    break;
                }
            }
            map.put("subject",Subject );
            map.put("level", search.get(i).get("level"));
            map.put("reportPlace", search.get(i).get("reportPlace"));
            subp = search.get(i).get("subPlace").toString().toCharArray();
            SubPlace ="";
            for(int m=0;m<subp.length;m++){
                if(subp[m]=='￥'){
                    for(int x=m+1;x<subp.length;x++)
                        SubPlace+=subp[x];
                    break;
                }
            }
            map.put("subPlace", SubPlace);
            map.put("examPlace", search.get(i).get("examPlace"));
            map.put("classPlace", search.get(i).get("classPlace"));
            map.put("time", search.get(i).get("time"));
            map.put("examTime", search.get(i).get("examTime"));
            dataList.add(map);
        }
        String filename = "全国美术考级报名信息表";
        service.outputExcel(resp, dataList, titles, keys, filename);
    }
}
