package com.springapp.dao;

import com.springapp.entity.examPlace;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hello on 2016/7/16.
 */
@Repository
public class ExamPlaceDao extends BaseDao {
    public List<examPlace> getId(Long id){
        return this.findAll("from examPlace where id="+id);
    }
}
