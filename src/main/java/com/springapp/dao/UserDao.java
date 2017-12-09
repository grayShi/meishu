package com.springapp.dao;

import com.springapp.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 石高磊 on 2017/2/28.
 */
@Repository
public class UserDao extends BaseDao {
    public List<User> getList(){
        return this.findAll("from User");
    }
    public List<User> getId(Long id){
        return this.findAll("from User where id="+id);
    }
}
