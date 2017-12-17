package com.springapp.dao;

import com.springapp.entity.subject;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/12.
 */
@Repository
public class SubjectDao extends BaseDao {
    public List<subject> getId(Long id, HttpServletRequest request){
        return this.findAll("from subject where id="+id,request);
    }
}
