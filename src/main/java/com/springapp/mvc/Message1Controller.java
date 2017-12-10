package com.springapp.mvc;
import com.springapp.classes.FileService;
import com.springapp.entity.*;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;


/**
 * Created by hello on 2016/7/26.
 */
@Controller
public class Message1Controller extends BaseController{

    @RequestMapping(value = "/message1",method = RequestMethod.GET)
    public ModelAndView home(ModelAndView modelAndView) {
        modelAndView.setViewName("message1");
        return modelAndView;
    }
    @RequestMapping(value = "/message2", method = RequestMethod.POST)
    public ModelAndView loanData(@RequestParam MultipartFile[] myfiles,@RequestParam(value = "endSignUpdate")String endSignUpTime,
                           HttpServletRequest request) throws IOException {
        // 如果只是上传一个文件，则只需要MultipartFile类型接收文件即可，而且无需显式指定@RequestParam注解
        // 如果想上传多个文件，那么这里就要用MultipartFile[]类型来接收文件，并且还要指定@RequestParam注解
        // 并且上传多个文件时，前台表单中的所有<input type="file">的name都应该是myfiles，否则参数里的myfiles无法获取到所有上传的文件
        File[] files = new File[myfiles.length];
        String lineNum="";
        String FileName="";
        HttpSession session= request.getSession();
        String place = (String) session.getAttribute("place");
        String subPlace = (String) session.getAttribute("subPlace");
        String power = (String) session.getAttribute("power");
        Boolean isAdmin = false;
        if(power.equals("admin")){
            isAdmin = true;
        }
        for (MultipartFile myfile : myfiles) {
            if (myfile.isEmpty()) {
                System.out.println("文件未上传");
            } else {
                FileName=myfile.getOriginalFilename();
                // 如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\WEB-INF\\upload\\文件夹中
                String realPath = request.getSession().getServletContext().getRealPath("/files/upload/loanData");
                // 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉，我是看它的源码才知道的
                File file = new File(realPath, myfile.getOriginalFilename());
                FileUtils.copyInputStreamToFile(myfile.getInputStream(), file);
                if(myfile.getOriginalFilename().toLowerCase().endsWith("xls")){
                    lineNum=readXls(myfile.getInputStream(),lineNum, endSignUpTime,place ,subPlace, isAdmin );
                }else{
                    //xlsx格式
                }
            }
        }
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject("lineNum",lineNum);
        modelAndView.addObject("fileName",FileName);
        modelAndView.setViewName("message2");
        return modelAndView;
    }

//    private void readXlsx(String fileName) throws IOException {
//        //String fileName = "D:\\excel\\xlsx_test.xlsx";
//        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileName);
//
//        // 循环工作表Sheet
//        for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
//            XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
//            if (xssfSheet == null) {
//                continue;
//            }
//
//            // 循环行Row
//            for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
//                XSSFRow xssfRow = xssfSheet.getRow(rowNum);
//                if (xssfRow == null) {
//                    continue;
//                }
//
//                // 循环列Cell
//                for (int cellNum = 0; cellNum <= xssfRow.getLastCellNum(); cellNum++) {
//                    XSSFCell xssfCell = xssfRow.getCell(cellNum);
//                    if (xssfCell == null) {
//                        continue;
//                    }
//                    System.out.print("   " + getValue(xssfCell));
//                }
//                System.out.println();
//            }
//        }
//    }
//    @SuppressWarnings("static-access")
//    private String getValue(XSSFCell xssfCell) {
//        if (xssfCell.getCellType() == xssfCell.CELL_TYPE_BOOLEAN) {
//            return String.valueOf(xssfCell.getBooleanCellValue());
//        } else if (xssfCell.getCellType() == xssfCell.CELL_TYPE_NUMERIC) {
//            return String.valueOf(xssfCell.getNumericCellValue());
//        } else {
//            return String.valueOf(xssfCell.getStringCellValue());
//        }
//    }

    private synchronized String readXls(InputStream is,String lineNum, String endSignUpTime, String place, String subPlace,Boolean isAdmin) throws IOException {
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
        int inputTotal=0;
        Boolean isSheetSuccess = true;
        // 循环工作表Sheet
        for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
            HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
            if (hssfSheet == null) {
                continue;
            }
            HSSFRow titleTssfRow = hssfSheet.getRow(0);
            for (int cellNum = 0; cellNum <= 10; cellNum++) {
                HSSFCell hssfCell = titleTssfRow.getCell(cellNum);
                if (hssfCell == null ||
                        (cellNum == 0 && !getValue(hssfCell).equals("*姓名"))||
                        (cellNum == 1 && !getValue(hssfCell).equals("*国籍"))||
                        (cellNum == 2 && !getValue(hssfCell).equals("*民族"))||
                        (cellNum == 3 && !getValue(hssfCell).equals("*性别"))||
                        (cellNum == 4 && !getValue(hssfCell).equals("*出生日期"))||
                        (cellNum == 5 && !getValue(hssfCell).equals("联系方式"))||
                        (cellNum == 6 && !getValue(hssfCell).equals("地址"))||
                        (cellNum == 7 && !getValue(hssfCell).equals("*科目"))||
                        (cellNum == 8 && !getValue(hssfCell).equals("*级别"))||
                        (cellNum == 9 && !getValue(hssfCell).equals("*报名省市"))||
                        (cellNum == 10 && !getValue(hssfCell).equals("*机构名称"))
                        ) {
                            lineNum +="Sheet"+ (numSheet+1)+"不符合模板规范,";
                            isSheetSuccess = false;
                            break;
                }
            }
            if(!isSheetSuccess)
                continue;
            // 循环行Row
            for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                if (hssfRow == null) {
                    continue;
                }
                message newMessage =new message();
                Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
                List<subject> subjectList =new ArrayList<>();
                String placeId="";
                String subPlaceId="";
                String subjectId="";
                String subject1="";
                String subPlaceIdCount="";
                String oldSubject="";
                boolean isSuccess = true;
                // 循环列Cell
                    //for (int cellNum = 0; cellNum <= hssfRow.getLastCellNum(); cellNum++) {
                for (int cellNum = 0; cellNum <= 10; cellNum++) {
                        HSSFCell hssfCell = hssfRow.getCell(cellNum);
                        if (hssfCell == null && cellNum != 6 && cellNum != 5) {            /////////空excel单元格
                            lineNum += "(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(存在空单元格),";
                            isSuccess = false;
                            break;
                        }
                        if (cellNum == 0 ) {
                            if(!getValue(hssfCell).equals("")) {
                                if(getValue(hssfCell).equals("张三(例)")){
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(示例行),";
                                    isSuccess = false;
                                    break;
                                }else{
                                    newMessage.setName(getValue(hssfCell));
                                }
                            }
                            else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(姓名为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 1 ) {
                            if(!getValue(hssfCell).equals("")) {
                                newMessage.setCountry(getValue(hssfCell));
                            }else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(国家为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 2 ) {
                            if(getValue(hssfRow.getCell(1)).equals("中国") ) {
                                if(!getValue(hssfCell).equals("")) {
                                    newMessage.setNation(getValue(hssfCell));
                                }
                                else {
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(民族为空),";
                                    isSuccess = false;
                                    break;
                                }
                            }else{
                                newMessage.setNation("");
                            }
                        }
                        else if (cellNum == 3 ) {
                            if (!getValue(hssfCell).equals("")) {
                                newMessage.setSex(getValue(hssfCell));
                            } else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(性别为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 4 ) {
                            if (!getValue(hssfCell).equals("")) {
                                try {

                                    //BigDecimal db = new BigDecimal(getValue(hssfCell));
                                    String Birth = messageDao.getDate(hssfCell);
                                    newMessage.setBirth(Birth);
                                }catch (Exception e){
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(生日格式出错),";
                                    isSuccess = false;
                                    break;
                                }
                            } else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(生日为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 5 ) {
                            if (!getValue(hssfCell).equals("")) {
                                try {
                                    BigDecimal db = new BigDecimal(getValue(hssfCell));
                                    newMessage.setPhoneNumber(db.toPlainString());
                                }catch (Exception e){
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(电话格式出错),";
                                    isSuccess = false;
                                    break;
                                }
                            } else {
                                newMessage.setPhoneNumber("");
                            }
                        }
                        else if (cellNum == 6 ) {
                            if(hssfCell == null)
                                newMessage.setAddress("");
                            else
                                newMessage.setAddress(getValue(hssfCell));
                        }
//                        else if (cellNum == 8) {
//                            if(hssfCell == null) {
//                                i = i + 13;
//                            }
//                            else{
//                                newMessage.setEmail(getValue(hssfCell));
//                                i=i+14;
//                            }
//                        }

                        else if (cellNum == 7 ) {
                            if(!getValue(hssfCell).equals("")){
                                subjectList = subjectDao.findAll("from subject where subject ='"+getValue(hssfCell)+"'");
                                oldSubject=getValue(hssfCell);
                                if(subjectList.size()!=0) {
                                    subject1 = subjectList.get(0).getId() + "￥" + subjectList.get(0).getSubject();
                                    newMessage.setSubject(subject1);
                                    if (subjectList.get(0).getId() < 10)
                                        subjectId += '0';
                                    subjectId += subjectList.get(0).getId();
                                }else {
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(科目不存在),";
                                    isSuccess = false;
                                    break;
                                }
                            }
                            else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(科目为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 8 ) {
                            if(!getValue(hssfCell).equals("")) {
                                if(pattern.matcher((int) (Double.parseDouble(getValue(hssfCell)))+"").matches()) {     ///判断是否全为为数字
                                    if(subjectList.get(0).getLevel() >= (int) (Double.parseDouble(getValue(hssfCell)))) {
                                        newMessage.setLevel((int) (Double.parseDouble(getValue(hssfCell))));
                                        List<examTime> examTimeList = examTimeDao.findAll("from examTime where subject ='"+oldSubject+"' and level ="+newMessage.getLevel());
                                        if(examTimeList.size()!=0) {
                                            newMessage.setExamTime(examTimeList.get(0).getDuration());
                                        }
                                    }else {
                                        lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(对应科目没有该级别),";
                                        isSuccess = false;
                                        break;
                                    }
                                }else{
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(级别不符合规范),";
                                    isSuccess = false;
                                    break;
                                }
                            }else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(级别为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 9 ) {
                            if(!getValue(hssfCell).equals("")) {
                                if(getValue(hssfCell) != place && !isAdmin){
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(无效报名省市),";
                                    isSuccess = false;
                                    break;
                                } else {
                                    newMessage.setReportPlace(getValue(hssfCell));
                                }
                            }else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(报名省市为空),";
                                isSuccess = false;
                                break;
                            }
                        }
                        else if (cellNum == 10 ) {
                            if(!getValue(hssfCell).equals("")) {
                                if(getValue(hssfCell) != subPlace && !isAdmin){
                                    lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(无效机构名称),";
                                    isSuccess = false;
                                    break;
                                } else {
                                    List<reportPlace> subPlaceList = reportPlaceDao.findAll("from reportPlace where isDelete = 0 and place='" + getValue(hssfRow.getCell(9)) + "' and subPlace ='" + getValue(hssfCell) + "'");
                                    if (subPlaceList.size() != 0) {
                                        if (subPlaceList.get(0).getPlaceId() < 10)
                                            subPlaceIdCount += "0" + subPlaceList.get(0).getPlaceId();
                                        else
                                            subPlaceIdCount += subPlaceList.get(0).getPlaceId() + "";
                                        if (subPlaceList.get(0).getSubPlaceId() < 10)
                                            subPlaceIdCount += "0" + subPlaceList.get(0).getSubPlaceId();
                                        else
                                            subPlaceIdCount += subPlaceList.get(0).getSubPlaceId() + "";
                                        newMessage.setSubPlace(subPlaceIdCount + "￥" + subPlaceList.get(0).getSubPlace());
                                        if (subPlaceList.get(0).getPlaceId() < 10)
                                            placeId += '0';
                                        placeId += subPlaceList.get(0).getPlaceId();
                                        if (subPlaceList.get(0).getSubPlaceId() < 10)
                                            subPlaceId += '0';
                                        subPlaceId += subPlaceList.get(0).getSubPlaceId();
                                    } else {
                                        lineNum += "(Sheet" + (numSheet + 1) + ")" + (rowNum + 1) + "(报名省市或机构名称不存在),";
                                        isSuccess = false;
                                        break;
                                    }
                                }
                            }else {
                                lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(机构名称为空),";
                                isSuccess = false;
                                break;
                            }
                            subPlaceIdCount = "";
                        }

                    }
                    if(isSuccess) {
                        Long isCount = messageDao.getCount("select count (*) from message where isDelete = 0 and name ='" + getValue(hssfRow.getCell(0)) + "'and sex='" + getValue(hssfRow.getCell(3)) + "'and birth='" + newMessage.getBirth() +"'and subject='" + subject1 + "'and level = " + getValue(hssfRow.getCell(8)));
                        if (isCount != 0) {
                            lineNum +="(Sheet"+(numSheet+1)+")"+ (rowNum + 1) + "(重复数据),";
                        } else {
                            newMessage.setIsDelete(0);
                            Date date = new Date();
                            String Id = (date.getYear() + 1900 + "").substring(2);
                            Id += placeId + subPlaceId + subjectId;
                            if ((int) (Double.parseDouble(getValue(hssfRow.getCell(8)))) < 10)
                                Id += '0';
                            Id += (int) (Double.parseDouble(getValue(hssfRow.getCell(8))));
                            Long countId = messageDao.getCount("select count (*) from message where endSignUpTime = '"+ endSignUpTime +"' and reportPlace = '"+newMessage.getReportPlace()+"'and subPlace = '"+newMessage.getSubPlace()+"'and subject='" + subject1 + "'and level = " + (int) (Double.parseDouble(getValue(hssfRow.getCell(8))))) + 1;
                            ///////搜索全表 包括isDeLETE = 0

                            if (countId < 1000)
                                Id += '0';
                            if (countId < 100)
                                Id += '0';
                            if (countId < 10)
                                Id += '0';
                            Id += countId;
                            newMessage.setCardNumber(Id);
                            newMessage.setEndSignUpTime(endSignUpTime);
                            newMessage.setPay(false);
                            messageDao.save(newMessage);
                            inputTotal++;
                        }
                    }
                    }
//                System.out.println();
            }
        return lineNum+"共导入"+inputTotal+"条数据";
    }

    @SuppressWarnings("static-access")
    private String getValue(HSSFCell hssfCell) {
        if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
            return String.valueOf(hssfCell.getBooleanCellValue());
        } else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
            return String.valueOf(hssfCell.getNumericCellValue());
        } else {
            return String.valueOf(hssfCell.getStringCellValue());
        }
    }
    @RequestMapping("/message1/getExcel")
    public void download1(HttpServletResponse resp) throws IOException {
        FileService service = new FileService();
        String[] titles = new String[]{"*姓名","*国籍","*民族","*性别","*出生日期","联系方式","地址","*科目","*级别","*报名省市","*机构名称"};
        String[] keys = new String[]{"name","country","nation","sex","birth","phoneNumber","address","subject","level","reportPlace","subPlace","mark"};
        List<Map<String,Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String,Object> map;
        map = new HashMap<String, Object>();
        map.put("name","中文或英文均可");
        map.put("country","如中国、加拿大，台港澳均应填中国");
        map.put("nation","如汉族、回族，无民族则不填");
        map.put("sex","男或女");
        map.put("birth","00000000");
        map.put("phoneNumber","固话或手机");
        map.put("address","××市××路××号××室");
        map.put("subject","素描、水粉、水彩等");
        map.put("level","1-10之间的某一级且不带单位");
        map.put("reportPlace","报名省市名称");
        map.put("subPlace","机构名称");
        map.put("mark","(*为必填)");
        dataList.add(map);
        map = new HashMap<String, Object>();
        map.put("name","张三(例)");
        map.put("country","中国");
        map.put("nation","汉族");
        map.put("sex","男");
        map.put("birth","19960113");
        map.put("phoneNumber","138********");
        map.put("address","××市××路××号××室");
        map.put("subject","素描");
        map.put("level","5");
        map.put("reportPlace","上海市");
        map.put("subPlace","××机构");
        map.put("mark","此行为模板信息，导入时请把此行删除");
        dataList.add(map);
        String filename = "全国美术考级报名信息上传模板";
        service.outputExcel(resp, dataList, titles, keys, filename);
    }
    }
