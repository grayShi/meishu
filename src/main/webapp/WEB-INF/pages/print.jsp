<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/9/2
  Time: 2:28
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
    .row-top{
        margin-top: 1%;
        margin-bottom: 1%;
    }
</style>
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%--<jsp:include page="public.jsp" flush="true">--%>
    <%--</jsp:include>--%>
    <%@include file="public.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">打印准考证</h1>
            </div>
        </div>
            <div class="row">
                <div class="col-lg-12 row-top">
                    <div class="col-lg-2">
                        <span>考试时间</span>
                        <select id="examTime" class="form-control">
                            <option value="0" selected="selected">考试时间</option>
                            <c:forEach items="${examTime}" var="item">
                                <option value="${item}">${item}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <span>科目</span>
                        <select id="subject" onchange="javaScript:setLevel()" class="form-control">
                            <option value="0" selected="selected">报考科目</option>
                            <c:forEach items="${subjectList}" var="item">
                                <option value="${item.id}￥${item.subject}">${item.subject}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <span>级别</span>
                        <select id="level" class="form-control">
                            <option value="0" selected="selected">报考级别</option>
                            <c:forEach items="${levelList}" var="item">
                                <option value="${item}">${item}级</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <span>报名省市</span>
                        <select id="reportPlace" onchange="javaScript:setSubPlace()" class="form-control">
                            <option value="0" selected="selected">报名省市</option>
                            <c:forEach items="${reportPlaceList}" var="item">
                                <option value="${item}" >${item}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <span>机构名称</span>
                        <select id="subPlace" class="form-control">
                            <option value="0" selected="selected">机构名称</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" type="button" onclick="getSearch()">搜索</button>
                    <div class="col-lg-12 search-row">
                        添加备注信息：<input id="remark" type="text" class="form-control"/>
                    </div>
                </div>
                <div class="col-lg-12 text-center table-title">
                    <button class="btn btn-primary" type="button" onclick="cardPrint()">打印</button>
                </div>
            </div>
            <div class="row">
                <div class="table-responsive table-bordered">
                    <div class="col-lg-12 text-center">
                        <table class="table table-striped table-bordered table-hover row-top">
                            <thead>
                            <tr>
                                <th>姓名</th>
                                <th>出生日期</th>
                                <th>科目名称</th>
                                <th>级别</th>
                                <th>考试时间</th>
                                <th>准考证号</th>
                            </tr>
                            </thead>
                            <tbody id="table">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- /.col-lg-12 -->



    </div>
</div>

<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="dist/js/sb-admin-2.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="vendor/metisMenu/metisMenu.min.js"></script>

<script>
    $(function(){
        $("#distribute").dropdown('toggle');
    });
    function setLevel(){
        var subject = $("#subject option:selected").val();
        if(subject!='0'){
            $.ajax({
                url:"data/setLevel",
                type:"post",
                dataType:"json",
                data:{
                    subject:subject
                },
                success: function(data){
                    var str="<option value='0' selected='selected'>报考级别</option>";
                    $(data).each(function(index){
                        str+="<option value='"+data[index]+"'>"+data[index]+"级</option>";
                    })
                    $("#level").html(str);
                }
            })
        }
        else{
            var str="<option value='0' selected='selected'>报考级别</option>";
            var level=JSON.parse('${levelList}');
            for(var i=0;i<level.length;i++){
                str+="<option value='"+level[i]+"'>"+level[i]+"级</option>";
            }
            $("#level").html(str);
        }
    }
    function setSubPlace(){
        var reportPlace = $("#reportPlace option:selected").val();
        if(reportPlace!='0'){
            $.ajax({
                url:"data/setSubPlace",
                type:"post",
                dataType:"json",
                data:{
                    reportPlace:reportPlace
                },
                success: function(data){
                    var str="<option value='0' selected='selected'>机构名称</option>";
                    $(data).each(function(index){
                        var subPlace1="";
                        var subPlace=data[index];
                        for(var i=0;i<subPlace.length;i++){
                            if(subPlace[i]=="￥"){
                                for(var j=i+1;j<subPlace.length;j++) {
                                    subPlace1 += subPlace[j];
                                }
                                break;
                            }
                        }
                        str+=" <option value='"+data[index]+"'>"+subPlace1+"</option>"
                    })
                    $("#subPlace").html(str);
                }
            })
        }
        else{
            var str="<option value='0' selected='selected'>机构名称</option>";
            $("#subPlace").html(str);
        }
    }
    var subject="";
    function getSearch(){
        var ExamTime = $("#examTime option:selected").val();
        var Subject = $("#subject option:selected").val();
        var Level = $("#level option:selected").val();
        var ReportPlace = $("#reportPlace option:selected").val();
        var SubPlace = $("#subPlace option:selected").val();
        $.ajax({
            url:"getSearch",
            type:"post",
            dataType:"json",
            data:{
                examTime:ExamTime,
                subject:Subject,
                level:Level,
                reportPlace:ReportPlace,
                subPlace:SubPlace,
            },
            success: function(data){
                var str="";
                var subject;
                for(var m = 0;m<data.length;m++){
                    var sub="";
                    subject=data[m].subject;
                    for(var i=0;i<subject.length;i++){
                        if(subject[i]=="￥"){
                            for(var j=i+1;j<subject.length;j++) {
                                sub += subject[j];
                            }
                            break;
                        }
                    }
                    str+="<tr> <td>"+data[m].name+"</td><td>"+data[m].birth+"</td> <td>"+sub+"</td> <td>"+data[m].level+"级</td> <td>"+data[m].time+"</td> <td>"+data[m].cardNumber+"</td> </tr>"
                }
                $("#table").html(str);
            }
        })
    }
    function  cardPrint(){
        var ExamTime = $("#examTime option:selected").val();
        var Subject = $("#subject option:selected").val();
        var Level = $("#level option:selected").val();
        var ReportPlace = $("#reportPlace option:selected").val();
        var SubPlace = $("#subPlace option:selected").val();
        var remark = $("#remark").val();
        window.open("print-detail?examTime="+ExamTime+"&subject="+Subject+"&level="+Level+"&reportPlace="+ReportPlace+"&subPlace="+SubPlace+"&remark="+remark);
    }
</script>
</body>
</html>
