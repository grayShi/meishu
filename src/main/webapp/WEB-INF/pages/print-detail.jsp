<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/4/29
  Time: 3:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>上海市美术考级管理系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
</head>
<style>
    @media print {
        .noPrint {display: none;}
        .nextPage {page-break-after:always;}
    }
</style> 
&nbsp;&nbsp;&nbsp;
<body style="margin: 0;padding: 0">
<%--纸张大小 宽 121cm  高93.1cm--%>
<div id="top"style="margin: 0;padding: 0">
<c:forEach items="${list}" var="item" varStatus="status">
    <%--<div style="height: 77mm; overflow: hidden;margin: 8mm 9mm;" class="nextPage">--%>
    <div class="nextPage" style="margin-top: 1.5mm">
        <table style="border-bottom: #000000 1px solid; border-left: #000000 1px solid; height: 72mm; border-top: #000000 1px solid; border-right: #000000 1px solid;" title=第${status.count}张 border=0 cellSpacing=1 cellPadding=0 width=363 align=center>
            <tbody>
    <tr> <td style="line-height: 20px" height=42 colSpan=3 align=center><span style="font-size: 15px; font-weight: 600">全国美术考级准考证</span><br>
    <span style="text-align: left; padding-left: 5px; width: 100%; font-size: 14px">准考证号:<u>${item.cardNumber}</u></span></td></tr>
    <tr><td style="padding-left: 6px; font-size: 13px" height=30 width=147>姓名:<u>${item.name}</u></td> <td style="padding-left: 6px; font-size: 13px" height=30 width=89 white-space: nowrap>性别:<u>${item.sex}</u></td>
    <td style="padding-right: 8px; font-size: 12px" rowSpan=5 width=121 align=center>
    <table style="border-bottom: #333333 1px solid; border-left: #333333 1px solid; border-top: #333333 1px solid; border-right: #333333 1px solid" border=0 cellSpacing=0 cellPadding=0 width=104 align=center height=137>
<tbody> <tr> <td width=110 align=center> <div style="width: 100%; font-size: 12px">二寸照片二张<br>(写上姓名及考号)一张贴此处，一张贴背面</div></td></tr></tbody></table></td></tr>
    <tr> <td style="padding-left: 6px; font-size: 13px" height=30>出生日期: <u>${item.birth}</u> </td>
    <td style="padding-left: 6px; font-size: 13px" height=30 white-space: nowrap>编号:<u>${item.reportPlace}</u></td></tr>
    <tr> <td style="padding-left: 6px; font-size: 13px" height=30>国籍:<u>${item.country}</u></td>
    <td style="padding-left: 6px; font-size: 13px" height=30>民族:<u>${item.nation}</u></td></tr>
    <tr> <td style="padding-left: 6px; font-size: 13px" height=30>科目:<u>${item.subject}</u></td>
    <td style="padding-left: 6px; font-size: 13px" height=30>级别:<u>${item.level}级</u></td></tr>
    <tr> <td style="padding-left: 6px; font-size: 13px" height=30 white-space: nowrap>时间: <u>${item.time}</u> </td>
    <td style="padding-left: 6px; font-size: 13px" height=30>时长:<u>${item.examTime}</u>分钟</td></tr>
    <tr> <td style="padding-left: 6px; font-size: 13px" height=30 colSpan=3>考点:<u>${item.examPlace}</u></td></tr>
<tr> <td style="padding-left: 6px; font-size: 13px" height=25 colSpan=2>考场:<u>${item.classPlace}</u></td>
    <td height=25px>&nbsp;</td></tr>
    <tr> <td style="font-size: 13px" height=21 colSpan=3 align=center>${remark}</td></tr></tbody>
        </table>
    </div> 
</c:forEach>

<div class="noPrint" style="position: static;right: 0;left: 0;bottom: 0">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading" id="line">
                纸张大小
            </div>
            <div class="panel-body" id="line2">
                宽 121cm  高93.1cm
            </div>
            <div class="panel-footer text-center" >
                <p>
                    <OBJECT id=WebBrowser classid=clsid:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0>     
                    </OBJECT>
                    IE浏览器点击右侧按钮：
                    <input type="button" class="btn btn-info" value=打印 onclick=document.all.WebBrowser.ExecWB(6,1)>          
                    <input type="button" class="btn btn-default" value=页面设置 onclick=document.all.WebBrowser.ExecWB(8,1)>
                    <input type="button" class="btn btn-default" value=打印预览 onclick=document.all.WebBrowser.ExecWB(7,1)>     
                </p>
                <p>其他浏览器点击右侧按钮：  
                    <input type="button" class="btn btn-primary" value=打印 onclick="window.print()"></p>
            </div>
        </div>
    </div>
</div>
</div> 
<script>

</script>
</body>
</html>
