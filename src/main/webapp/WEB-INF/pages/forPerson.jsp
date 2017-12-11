<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/9/2
  Time: 1:14
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

    <link href="src/body-tags.css" rel="stylesheet">
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
                <h1 class="page-header">个人考场安排</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="row row-top">
                    <div class="col-lg-3">
                        <span>姓名</span>
                        <input type="text" id="name" list="lista" placeholder="输入姓名关键字筛选" class="form-control"/>
                        <datalist id="lista">
                            <c:forEach items="${message}" var="item">
                                <option value="${item.name}-${item.birth}">${item.name}-${item.birth}</option>
                            </c:forEach>
                        </datalist>
                    </div>
                    <div class="col-lg-1">
                        <span>操作</span>
                        <button class="btn btn-primary form-control" type="button" onclick="addName()">添加</button>
                    </div>
                </div>
                <div class="row row-top">
                    <div class="col-lg-4">
                        <span>考试时间</span>
                            <select id="time" onchange="javaScript:setExamPlace()" class="form-control">
                                <option value="0" selected="selected" >考试时间</option>
                                <c:forEach items="${timeList}" var="item">
                                    <option value="${item.startTime}">${item.startTime}</option>
                                </c:forEach>
                            </select>
                    </div>
                    <div class="col-lg-4">
                        <span>考点地址-考场地址</span>
                        <select id="examPlace" class="form-control">
                            <option value="0" selected="selected">考点地址</option>

                        </select>
                    </div>
                </div>
                <div class="row row-top">
                    <div class="col-lg-12">
                        <button class="btn btn-primary" onclick="startExam()">开始分配</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <table class="table">
                            <thead>
                            <tr>
                                <th colspan="6" class="text-center"><h2 class="page-header">分配考生</h2></th>
                            </tr>
                            </thead>
                            <tbody id="nameList">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">分配成功</h4>
                </div>
                <div class="modal-body text-center">
                    <p>分配成功</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" onclick="reload()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">分配失败</h4>
                </div>
                <div class="modal-body text-center">
                    <p id="message"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>


<script>
    function reload(){
        location.href="forPerson";
    }
    var NABI =[];  //name-birth
    var NAMELIST =[];
    var BIRTHLIST =[];
    function addName() {
        var nabi = $("#name").val();
        var list=[];
        if(nabi!="") {
            if($.inArray(nabi, JSON.parse('${nameBirth}')) < 0){
                $('#message').html('不存在此考生');
                $('#false').modal('show');
            }else {
                if ($.inArray(nabi, NABI) >= 0) {
                    $('#message').html('已添加过次考生');
                    $('#false').modal('show');
                } else {
                    NABI.push(nabi);
                    list = nabi.split("-");
                    NAMELIST.push(list[0]);
                    BIRTHLIST.push(list[1]);
                    setHTML();
                }
            }
        }
    }
    function setHTML() {
        var htmlStr = "<tr>";
        for(var i=0;i<NAMELIST.length;i++){
            if( i % 5 == 0 && i!=0){
                htmlStr += "<tr>";
            }
            htmlStr +="<td class='tag'>"+NAMELIST[i]+"-"+BIRTHLIST[i]+"&nbsp;&nbsp;<a href='javascript:void(0)' onclick='getDelete("+i+")'>x</a></td>"
            if( i % 5 == 0 && i!=0){
                htmlStr += "/<tr>";
            }
        }
        htmlStr +="</tr>";
        $("#nameList").html(htmlStr);
    }
    function getDelete(index) {
        NAMELIST.splice(index,1);
        BIRTHLIST.splice(index,1);
        NABI.splice(index,1);
        setHTML();
    }
    function startExam() {
        var examPlace=$("#examPlace option:selected").val();

        var time = $("#time option:selected").val();
        var exam=examPlace.split("￥");
        var examPlace,classPlace;
        if(exam[0]!="0"&& NAMELIST.length!=0 && BIRTHLIST.length!=0 && time!="0") {
            examPlace = exam[0];
            classPlace = exam[1];
            $.ajax({
                url: "forPerson-startExam",
                data: {
                    nameList: NAMELIST,
                    birthList: BIRTHLIST,
                    examPlace:examPlace,
                    classPlace:classPlace,
                    time:time,
                },
                type: "post",
                traditional: true,
                success: function (data) {
                    if(data =="success"){
                        $('#success').modal('show');
                        NAMELIST.length=0;
                        BIRTHLIST.length=0;
                        NABI.length=0;
                    }
                }
            })
        }else{
            $('#message').html('分配为空');
            $('#false').modal('show');
        }
    }
    function setExamPlace() {
        var time = $("#time option:selected").val();
        var row='<option value="0" selected="selected">考点地址</option>';
        if(time !="0") {
            $.ajax({
                url: "forPerson-setExamPlace",
                dataType: "json",
                type: "post",
                data: {
                    time: time,
                },
                async:false,
                success: function (data) {
                    $(data).each(function (index) {
                        row += '<option value="' + data[index].place + '￥' + data[index].classPlace + '">' + data[index].place + '-' + data[index].classPlace + '</option>';
                    })
                }
            })
        }
        $("#examPlace").html(row);
    }
</script>
</body>
</html>
