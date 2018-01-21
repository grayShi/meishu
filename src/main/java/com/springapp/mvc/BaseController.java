package com.springapp.mvc;

import com.springapp.dao.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;

/**
 * Created by anc on 15/3/13.
 */
public class BaseController{
    /*
    @Autowired
    protected SignInfoDao signInfoDao;
    */
    public SimpleDateFormat simpleDateFormat;
    @Autowired
    protected UserDao userDao;
    @Autowired
    protected BaseDao baseDao;
    @Autowired
    protected CostDao costDao;
    @Autowired
    protected SubjectDao subjectDao;
    @Autowired
    protected reportPlaceDao reportPlaceDao;
    @Autowired
    protected PlaceDao placeDao;
    @Autowired
    protected TimeDao timeDao;
    @Autowired
    protected ExamPlaceDao examPlaceDao;
    @Autowired
    protected MessageDao messageDao;
    @Autowired
    protected ExamTimeDao examTimeDao;
    @Autowired
    protected commitCostDao costCommitDao;
    public BaseController(){
       simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd");
    }
    /*@InitBinder
    protected void initBinder(HttpServletRequest request,
                              ServletRequestDataBinder binder) throws Exception {
        //对于需要转换为Date类型的属性，使用DateEditor进行处理
       // binder.registerCustomEditor(Date.class, new DateEditor());
    }*/

}
