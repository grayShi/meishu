package com.springapp.dao;

import com.springapp.entity.examTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sgl on 2017/5/4.
 */
@Repository
public class ExamTimeDao extends BaseDao{
    public List<examTime> getId(Long id){
        return this.findAll("from examTime where id="+id);
    }

}
