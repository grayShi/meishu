package com.springapp.dao;

import com.springapp.entity.Place;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 石高磊 on 2017/4/5.
 */
@Repository
public class PlaceDao extends BaseDao{
    public long getPlaceCount(String place, HttpServletRequest request){
        return this.getCount("select count (*) from Place where place= '"+place+"'",request);
    }
    public long setId(String place){
        List<Place> find = this.findAll("from Place where place= '"+place+"'");
        return find.get(0).getId();
    }
    public List<Place> getId(Long id){
        return this.findAll("from Place where id="+id);
    }
}
