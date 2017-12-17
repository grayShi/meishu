package com.springapp.dao;

import com.springapp.entity.time;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/14.
 */
@Repository
public class TimeDao extends BaseDao{
    public List<time> getId(Long id, HttpServletRequest request){
        return this.findAll("from time where id="+id,request);
    }
}
