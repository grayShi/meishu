<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hello
  Date: 2017/12/10
  Time: 23:23
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
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%--<jsp:include page="public.jsp" flush="true">--%>
    <%--</jsp:include>--%>
    <%@include file="public.jsp"%>

    <div id="page-wrapper">


        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">修改密码</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="history.back(-1)"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1">
                    <tbody>
                        <tr>
                            <td>用户名</td>
                            <td><input class="form-control" readonly id="username" value="${username}"/></td>
                        </tr>
                        <tr >
                            <td>原密码</td>
                            <td><a href="javascript:void(0)" onclick="setInputType('originPassword')">
                                <p class="fa fa-eye" style="position: absolute;right: 0px;margin-right: 30px;margin-top: 10px"></p>
                                </a>
                                <input class="form-control" type="password" id="originPassword"/></td>
                        </tr>
                        <tr>
                            <td>新密码</td>
                            <td><a href="javascript:void(0)" onclick="setInputType('newPassword1')">
                                <p class="fa fa-eye" style="position: absolute;right: 0px;margin-right: 30px;margin-top: 10px"></p>
                            </a>
                                <input class="form-control" type="password" id="newPassword1"/></td>
                        </tr>
                        <tr>
                            <td>重复新密码</td>
                            <td><a href="javascript:void(0)" onclick="setInputType('newPassword2')">
                                <p class="fa fa-eye" style="position: absolute;right: 0px;margin-right: 30px;margin-top: 10px"></p>
                            </a>
                                <input class="form-control" type="password" id="newPassword2"/></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal"  onclick="editUser()">提交</button>
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

    <script src="js/jquery-md5.js"></script>
    <script>
        function setInputType(id){
            if($("#"+id).prop('type')=='password'){
                $("#"+id).prop('type','text');
            }else{
                $("#"+id).prop('type','password');
            }
        }
        function editUser(){
            var originPassword =$('#originPassword').val();
            var newPassword1 =$('#newPassword1').val();
            var newPassword2 =$('#newPassword2').val();
            if(originPassword == "" || newPassword1 == "" || newPassword2 == ""){
                $("#message").html("输入不允许为空");
                $('#false').modal('show');
                return 0;
            }
            if(newPassword1 != newPassword2){
                $("#message").html("两次输入新密码不一致");
                $('#false').modal('show');
                return 0;
            }
            $.ajax({
                url:"changePassword-user",
                type:"post",
                data:{
                    id:'${id}',
                    originPassword:$.md5($.md5(originPassword)),
                    newPassword:$.md5($.md5(newPassword1)),
                },
                success:function(data){
                    if(data=="success")
                        $('#success').modal('show');
                    else if(data == "error_origin"){
                        $("#message").html("原密码错误,请重新输入");
                        $('#false').modal('show');
                    }
                }
            })
        }
    </script>
</body>
</html>
