package com.springapp.dao;

import com.springapp.entity.cost;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hello on 2016/7/12.
 */
@Repository
public class CostDao extends BaseDao {
        public List<cost> getId(Long id, HttpServletRequest request){
            return this.findAll("from cost where id="+id,request);
        }
}
