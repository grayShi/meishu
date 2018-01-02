<%--
  Created by IntelliJ IDEA.
  User: 石高磊
  Date: 2017/8/27
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>上海市美术考级管理系统</title>
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
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%--<jsp:include page="public.jsp" flush="true">--%>
    <%--</jsp:include>--%>
    <%@include file="public.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">录入结果</h1>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading" id="line">
                    </div>
                    <div class="panel-body" id="line2">
                    </div>
                    <div class="panel-footer">
                        请勿刷新页面,点击&nbsp;&nbsp;<a href="message1"><input type="button" class="btn btn-default" value="返回"/></a>
                    </div>
                </div>
            </div>
        </div>

    </div>


<script>
    $(function(){
        var lineNum="${lineNum}";
        var fileName='${fileName}';
        var line = lineNum.split(',');
        var htm="上传文件为："+fileName;
        $("#line").html(htm);
        var row="Excel中,</br>";
        row+=line[line.length-1]+",</br>";
        for(var i=0;i<line.length-1;i++){
            row+="第"+line[i]+"行,";
        }
        row+="</br>未提交";
        $("#line2").html(row);
    });
    document.onkeydown = function()
    {
        /*
         (ctrlKey == true && keyCode == 82)   Ctrl+R   ---刷新
         (keyCode == 116)                     F5       ---刷新
         (ctrlKey == true && keyCode == 116)  Ctrl+F5  ---强制刷新
         */
        //window.alert(event.keyCode);
        var k = event.keyCode;
        if((event.ctrlKey == true && k == 82) || (k == 116) || (event.ctrlKey == true && k == 116))
        {
            //return (window.confirm("关闭?"));
            event.keyCode = 0;
            event.returnValue = false;
            event.cancelBubble = true;
        }
    }
</script>
</body>
</html>
