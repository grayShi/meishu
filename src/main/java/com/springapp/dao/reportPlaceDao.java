package com.springapp.dao;

import com.springapp.entity.reportPlace;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/14.
 */
@Repository
public class reportPlaceDao extends BaseDao{
    public List<reportPlace> getId(Long id, HttpServletRequest request){
        return this.findAll("from reportPlace where id="+id,request);
    }
}
