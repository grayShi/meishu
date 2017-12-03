package com.springapp.dao;

import com.springapp.entity.message;

import java.util.List;

/**
 * Created by hello on 2016/7/23.
 */
public class examinationDao extends BaseDao {
    public List<message> getId(Long id){
        return this.findAll("from message where isDelete = 0 and id="+id,message.class);
    }
}
