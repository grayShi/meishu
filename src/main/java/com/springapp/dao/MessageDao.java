package com.springapp.dao;

import com.springapp.entity.message;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by hello on 2016/7/17.
 */
@Repository
public class MessageDao extends BaseDao{
    public List<message> getId(Long id, HttpServletRequest request){
        return this.findAll("from message where isDelete = 0 and id="+id,request);
    }
    public String getDate(HSSFCell hssfCell){
        DecimalFormat df = new DecimalFormat("#");
        if(hssfCell == null){
            return "";
        }
        switch (hssfCell.getCellType()){
            case HSSFCell.CELL_TYPE_NUMERIC:
                if(HSSFDateUtil.isCellDateFormatted(hssfCell)){
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

                    return sdf.format(hssfCell.getDateCellValue());
                }

                return df.format(hssfCell.getNumericCellValue());
            case HSSFCell.CELL_TYPE_STRING:
                return hssfCell.getStringCellValue();
            case HSSFCell.CELL_TYPE_FORMULA:
                return hssfCell.getCellFormula();
            case HSSFCell.CELL_TYPE_BLANK:
                return "";

        }
        return "";


    }
}
