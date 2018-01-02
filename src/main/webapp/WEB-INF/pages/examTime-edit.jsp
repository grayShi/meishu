<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 2:42
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
                <h1 class="page-header">修改考试持续时间</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='examTime'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1">
                    <tbody>
                    <c:forEach items="${examTimeLi}" var="item">
                        <tr>
                            <td>科目名称</td>
                            <td><select id="subject" class="form-control" >
                                <option value="0">科目名称</option>
                                <option value="${item.subject}" selected="selected">${item.subject}</option>
                            </select></td>
                        </tr>
                        <tr>
                            <td>级别</td>
                            <td><select id="level" class="form-control">
                                <option value="0">级别</option>
                                <option value="${item.level}"selected="selected">${item.level}级</option>
                            </select></td>
                        </tr>
                        <tr>
                            <td>持续时间(分钟)</td>
                            <td><input id="duration" class="form-control" value="${item.duration}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal"  onclick="editExamTime()">提交</button>
            </div>
        </div>


    </div><!-- /#page-wrapper -->
    <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">成功提示</h4>
                </div>
                <div class="modal-body text-center">
                    <p>已经成功提交</p>
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
                    <h4 class="modal-title">提交失败</h4>
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


    <script>
        function reload(){
            location.href="examTime";
        }
        function setLevel() {
            var subject = $("#subject option:selected").val();
            $.ajax({
                url:"examTime-getlevel",
                type:"post",
                dataType:"json",
                data:{
                    subject:subject,
                },
                success:function(data){
                    var str="<option value='0' selected='selected'>级别</option>";
                    $(data).each(function(index){
                        for(var i = 1;i <= data[index].level;i++) {
                            str += "<option value='" + i + "'>" + i + "级</option>";
                        }
                    })
                    $("#level").html(str);
                }
            })
        }
        function editExamTime(){
            var subject=$("#subject option:selected").val();
            var level=$("#level option:selected").val();
            var duration=$("#duration").val();
            if(subject=="0"||level=="0"||duration==""){
                $("#message").html("科目名称、级别未选或持续时间未填");
                $('#false').modal('show');
                return 0;
            }
            if(isNaN(duration)){
                $("#message").html("持续时间必须为数字");
                $('#false').modal('show');
                return 0;
            }
            $.ajax({
                url:"examTime-edit1",
                type:"post",
                data:{
                    id:'${id}',
                    subject:subject,
                    level:level,
                    duration:duration,
                },
                success:function(data){
                    if(data=="success")
                        $('#success').modal('show');
                    else{
                        $("#message").html("考试科目不存在");
                        $('#false').modal('show');
                    }
                }
            })
        }
    </script>
</body>
</html>
