package com.springapp.classes;

import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

/**
 * Created by Leon on 2015/4/9.
 */
@Service
public class FileService {

    /**
     *
     * @param response
     * @param titles 表的头部索引
     * @return
     */
    public HttpServletResponse writeEnrollCode(HttpServletResponse response,String[] titles,Map<String,Object> datas,String filename){
        HSSFWorkbook wb = new HSSFWorkbook();
        // 在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("sheet1");
        // 在sheet中添加表头第0行
        HSSFRow row = sheet.createRow((int) 0);
        // 创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        headStyle.setBorderBottom((short)1);
        headStyle.setBorderLeft((short)1);
        headStyle.setBorderTop((short)1);
        headStyle.setBorderRight((short)1);

        HSSFRow titleRow = sheet.createRow((int) 0);
        HSSFCell cell;
        int i=0;
        for(String title :titles){
            cell=titleRow.createCell((short)i);
            cell.setCellValue(title);
            cell.setCellStyle(headStyle);
            i++;
        }
        HSSFDataFormat format = wb.createDataFormat();
        HSSFCellStyle style = wb.createCellStyle();
        style.setDataFormat(format.getFormat("@"));
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);


        HSSFRow exampleRow = sheet.createRow((int) 1);
        HSSFCell cell2;

        i=0;
        for(String title :titles){
            cell2=exampleRow.createCell((short)i);
            cell2.setCellValue(String.valueOf(datas.get(title)));
            cell2.setCellStyle(style);
            i++;
        }

        response.reset();
        // 设置response的Header
        response.setHeader("pragma", "no-cache");
        response.setHeader("Content-Disposition", "attachment; filename="+filename+".xls");
        response.setContentType("application/*");
        try {
            wb.write(response.getOutputStream());
            response.flushBuffer();
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return response;
    }

    public HttpServletResponse outputExcel(HttpServletResponse response,List<Map<String,Object>> dataList,String[] titles,String[] keys,String filename) throws UnsupportedEncodingException {
        HSSFWorkbook wb = new HSSFWorkbook();
        // 在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("sheet1");
        sheet.autoSizeColumn(1);
        // 创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        headStyle.setBorderBottom((short)1);
        headStyle.setBorderLeft((short)1);
        headStyle.setBorderTop((short)1);
        headStyle.setBorderRight((short)1);

        HSSFRow firstRow = sheet.createRow(0);
        HSSFRow row;
        HSSFCell cell;
        int i=0;
        for(String title :titles){
            cell=firstRow.createCell((short)i);
            cell.setCellValue(title);
            cell.setCellStyle(headStyle);
            i++;
        }
        HSSFDataFormat format = wb.createDataFormat();
        HSSFCellStyle style = wb.createCellStyle();
        style.setDataFormat(format.getFormat("@"));
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        i=1;
        for(Map map:dataList){
            row = sheet.createRow(i);
            row.setRowStyle(style);
            int j=0;
            for(String key:keys){
                String value="";
                Object object=map.get(key);
                if(object!=null){
                    value=object.toString();
                }

                cell = row.createCell(j);
                cell.setCellValue(String.valueOf(value));
                cell.setCellStyle(style);
                j++;
            }
            i++;
        }

        response.reset();
        // 设置response的Header
        response.setHeader("pragma", "no-cache");
        response.setHeader("Content-Disposition", "attachment; filename="+new String(filename.getBytes("gb2312"), "ISO8859-1")+".xls");
        response.setContentType("application/*");
        try {
            wb.write(response.getOutputStream());
            response.flushBuffer();
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return response;
    }



}
