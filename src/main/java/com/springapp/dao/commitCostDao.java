package com.springapp.dao;

import com.springapp.entity.commitCost;
import com.springapp.entity.cost;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Repository
public class commitCostDao extends BaseDao {
    public List<commitCost> getId(Long[] id, HttpServletRequest request){
        String listString = "(";
        String str = "";
        for(int i = 0; i<id.length; i++){
            if(i+1 ==id.length){
                str += id[i];
            } else {
                str += id[i]+",";
            }

        }
        listString += str+")";
        return this.findAll("from commitCost where id in"+listString,request);
    }
}
