<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 石高磊
  Date: 2017/12/2
  Time: 23:05
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
                <h1 class="page-header">用户信息管理</h1>
            </div>
            <div class="col-lg-12">
                <a href="user-add" ><p class="fa fa-plus">新增用户</p></a>
            </div>
            <div class="col-lg-12 table-responsive table-bordered">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>用户名</th>
                        <th>角色</th>
                        <th>机构名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${user}" var="item">
                        <tr>
                            <td>${item.username}</td>
                            <td>${item.power}</td>
                            <td>${item.place}&nbsp;${item.subPlace}</td>
                            <td><button type="button" onclick="editUser('${item.id}')" class="btn btn-default">编辑</button>
                                <button type="button" data-toggle="modal" data-target="#delete" onclick="getId('${item.id}')" class="btn btn-default">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- /.col-lg-12 -->
        </div>


    </div>
    <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">删除提示</h4>
                </div>
                <div class="modal-body text-center">
                    <p>你确定要删除吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn btn-danger" data-dismiss="modal" onclick="deleteUser()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>


<script>
    function editUser(id)
    {
        location.href="user-edit?id="+id;
    }
    var id;
    function getId(Id){
        id=Id;
    }
    function deleteUser(){
        $.ajax({
            url:"user-delete",
            type:"post",
            data:{
                id:id
            },
            success:function(data){
                if(data=="success")
                    location.reload();
            }
        })
    }
</script>
</body>
</html>

