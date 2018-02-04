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
        public Double cashbackRules(int realCount, int totalCount) {
            Double cashBack = 0.0;
            if(totalCount>=10 && totalCount <=30){
                cashBack += 10*realCount;
            }
            else if(totalCount>=31 && totalCount <=100){
                cashBack += 30*realCount;
            }
            else if(totalCount>=101 && totalCount <=200){
                cashBack += 31*realCount;
            }
            else if(totalCount>=201 && totalCount <=300){
                cashBack += 32*realCount;
            }
            else if(totalCount>=301 && totalCount <=400){
                cashBack += 33*realCount;
            }
            else if(totalCount>=401 && totalCount <=500){
                cashBack += 34*realCount;
            }
            else if(totalCount>=501 && totalCount <=600){
                cashBack += 35*realCount;
            }
            else if(totalCount>=600 && totalCount <=700){
                cashBack += 36*realCount;
            }
            else if(totalCount>=701 && totalCount <=800){
                cashBack += 37*realCount;
            }
            else if(totalCount>=801 && totalCount <=900){
                cashBack += 38*realCount;
            }
            else if(totalCount>=901 && totalCount <=1000){
                cashBack += 39*realCount;
            }
            else if(totalCount>=1001 && totalCount <=2000){
                cashBack += 40*realCount;
            }
            else if(totalCount>=2001){
                cashBack += 50*realCount;
            }
            return cashBack;
        }
}
