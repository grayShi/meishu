package com.springapp.dao;

import com.springapp.entity.time;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hello on 2016/7/14.
 */
@Repository
public class TimeDao extends BaseDao{
    public List<time> getId(Long id){
        return this.findAll("from time where id="+id,time.class);
    }
}
