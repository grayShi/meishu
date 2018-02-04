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
        public Double cashbackRules(int count) {
            Double cashBack = 0.0;
            if(count>=10 && count <=30){
                cashBack += 10*count;
            }
            else if(count>=31 && count <=100){
                cashBack += 30*count;
            }
            else if(count>=101 && count <=200){
                cashBack += 31*count;
            }
            else if(count>=201 && count <=300){
                cashBack += 32*count;
            }
            else if(count>=301 && count <=400){
                cashBack += 33*count;
            }
            else if(count>=401 && count <=500){
                cashBack += 34*count;
            }
            else if(count>=501 && count <=600){
                cashBack += 35*count;
            }
            else if(count>=600 && count <=700){
                cashBack += 36*count;
            }
            else if(count>=701 && count <=800){
                cashBack += 37*count;
            }
            else if(count>=801 && count <=900){
                cashBack += 38*count;
            }
            else if(count>=901 && count <=1000){
                cashBack += 39*count;
            }
            else if(count>=1001 && count <=2000){
                cashBack += 40*count;
            }
            else if(count>=2001){
                cashBack += 50*count;
            }
            return cashBack;
        }
}
