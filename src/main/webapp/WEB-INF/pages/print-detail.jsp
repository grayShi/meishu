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
    <title>全国美术考级管理系统</title>
    <link rel="shortcut icon" href="images/logo.png">
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
    .table-top {
        margin-top: 20px;
        text-align: center;
    }
    .table-top-first {
        text-align: center;
    }
    .table-div {
        overflow: hidden;
        display: inline-block;
    }
    .message-table {
        padding-left: 6px;
        font-size: 13px;
        /*height: 20px;*/
    }
    .card-table {
        padding-left: 6px;
        font-size: 16px;
        height: 20px;
    }
    .table-height {
        min-height: 340px;
        float:left;
        margin-bottom:15px;
        border: #000000 1px solid;
    }
</style> 
&nbsp;&nbsp;&nbsp;
<body style="margin: 0;padding: 0">
<%--纸张大小 宽 121cm  高93.1cm--%>
<div id="top"style="margin: 0;padding: 0">
<c:forEach items="${list}" var="item" varStatus="status">
    <%--<div style="height: 77mm; overflow: hidden;margin: 8mm 9mm;" class="nextPage">--%>
    <c:if test="${status.count != list.size() && status.count != 1 }">
        <div class="nextPage table-top">
    </c:if>
        <c:if test="${status.count != list.size() && status.count == 1 }">
            <div class="nextPage table-top-first">
                </c:if>
    <c:if test="${status.count == list.size() }">
        <div class="table-top">
    </c:if>
            <div class="table-div">
                <div class="table-height">
                <table title=第${status.count}张 cellSpacing=1 cellPadding=0 width=330px align=center>
                    <tbody>
                        <tr> <td style="line-height: 20px" height=88px colSpan=3 align=center><span style="font-size: 20px; font-weight: 600">全国美术考级准考证</span></br>
                        <span style="display: block;margin-top: 10px;padding-left: 5px; width: 100%; font-size: 18px">准考证号:<u>${item.cardNumber}</u></span></td></tr>
                        <tr><td class="card-table" width=147>姓名:<u>${item.name}</u></td> <td class="card-table" width=89 white-space: nowrap>性别:<u>${item.sex}</u></td>
                        <td style="padding-right: 2px; font-size: 12px" rowSpan=7 width=121 align=center>
                            <table style="border: #333333 1px solid; height: 190px" border=0 cellSpacing=0 cellPadding=0 width=120 align=center>
                                <tbody> <tr> <td width=110 align=center> <div style="width: 100%; font-size: 12px">二寸照片一张</br>(写上姓名及考号)</div></td></tr></tbody></table>
                        <tr> <td class="card-table">生日: <u>${item.birth}</u> </td>
                        <td class="card-table" white-space: nowrap>编号:<u>${item.reportPlace}</u></td></tr>
                        <tr> <td class="card-table" >国籍:<u>${item.country}</u></td>
                        <td class="card-table">民族:<u>${item.nation}</u></td></tr>
                        <tr> <td class="card-table">科目:<u>${item.subject}</u></td>
                        <td class="card-table">级别:<u>${item.level}级</u></td></tr>
                        <tr> <td class="card-table" white-space: nowrap>时间: <u>${item.time}</u> </td></tr>
                        <tr><td class="card-table">时长:<u >${item.examTime}分钟</u></td></tr>
                        <tr> <td class="card-table" colSpan=3>考点:<u>${item.examPlace}</u></td></tr>
                        <tr> <td class="card-table" colSpan=2>考场:<u>${item.classPlace}</u></td>
                        <tr> <td class="card-table" colSpan=3 align=center>${remark}</td></tr>
                        <td height=10>&nbsp;</td></tr>
                    </tbody>
                </table>
                </div>
                <div style="margin-left: 5px" class="table-height">
                    <table title=第${status.count}张 cellSpacing=1 cellPadding=0 width=330px align=center>
                        <tbody>
                        <tr> <td style="line-height: 20px" height=60px colSpan=3 align=center><span style="font-size: 20px; font-weight: 600">考生须知</span></td></tr>
                        <tr><td class="message-table" colSpan=2>1、<span>请仔细核对信息，如有问题及时与报名老师联系。</span></td></tr>
                        <tr><td class="message-table" colSpan=1>2、<span>考生须持本准考证并按准考证上面时间和考场参加考试。家长请勿进入考场。</span></td>
                            <td style="padding-right: 2px; font-size: 12px;" rowSpan=5 width=121 align=center>
                                <table style="border: #333333 1px solid; height:190px" border=0 cellSpacing=0 cellPadding=0 width=120 align=center>
                                    <tbody> <tr> <td width=110 align=center> <div style="width: 100%; font-size: 12px">二寸照片一张</br>(写上姓名及考号)</div></td></tr></tbody></table>
                                (用于证书制作)
                            </td></tr>
                        <tr> <td class="message-table" colSpan=1>3、<span>考试工具自带，书法和国画考生要自备宣纸，书法4级以上(含4级)考生不能将画好格子的宣纸带入考场。</span></td>
                        </tr>
                        <tr> <td class="message-table" colSpan=1>4、<span>考生不得将参考资料带入考场。</span></td>
                        </tr>
                        <tr> <td class="message-table" colSpan=1>5、<span>书法、硬笔书法和国画所有级别的作品都必须有落款。</span></td></tr>
                        <tr> <td class="message-table" colSpan=1>6、<span>具体各考试要求请参照考试大纲（考级标准）。</span></td></tr>
                        <td height=10>&nbsp;</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
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
