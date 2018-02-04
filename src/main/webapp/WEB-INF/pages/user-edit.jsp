<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 石高磊
  Date: 2017/12/2
  Time: 23:06
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
                <h1 class="page-header">修改用户信息</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='user'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1">
                    <tbody>
                    <c:forEach items="${userList}" var="item">
                        <tr>
                            <td>用户名</td>
                            <td><input class="form-control" id="username" value="${item.username}"/></td>
                        </tr>
                        <tr id='passwordTr'>
                            <td>密码</td>
                            <td><input class="form-control" id="password"/></td>
                        </tr>
                        <tr>
                            <td>权限</td>
                            <td><select  id="power" class="form-control"onchange="javascript:setReportPlaceShow()">
                                <c:if test="${item.power == 'school'}">
                                    <option value="school" selected="selected" >报名机构</option>
                                    <option value="schoolNoPrint" >报名机构(非打印)</option>
                                    <option value="admin" >超级管理员</option>
                                </c:if>
                                <c:if test="${item.power == 'admin'}">
                                    <option value="school"  >报名机构</option>
                                    <option value="schoolNoPrint" >报名机构(非打印)</option>
                                    <option value="admin" selected="selected" >超级管理员</option>
                                </c:if>
                                <c:if test="${item.power == 'schoolNoPrint'}">
                                    <option value="school"  >报名机构</option>
                                    <option value="schoolNoPrint"  selected="selected" >报名机构(非打印)</option>
                                    <option value="admin">超级管理员</option>
                                </c:if>
                            </select></td>
                        </tr>
                            <tr id='reportPlaceTr'>
                                <td>报名省市</td>
                                <td>
                                    <select id="reportPlace"class="form-control" onchange="javascript:setSubPlace()">
                                        <option value="${item.place}" selected="selected" >${item.place}</option>
                                        <c:forEach items="${place}" var="it">
                                            <c:if test="${it != item.place}">
                                                <option value="${it}" >${it}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr id='subPlaceTr'>
                                <td>机构名称</td>
                                <td>
                                    <select id="subPlace" class="form-control">
                                        <option value="${item.subPlace}" selected="selected" >${item.subPlace}</option>
                                        <c:forEach items="${subPlace}" var="ite">
                                            <c:if test="${ite != item.subPlace}">
                                                <option value="${ite}" >${ite}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal" onclick="resetPassword()">重置密码</button>
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
        $(function(){
            setReportPlaceShow();
            document.getElementById('passwordTr').style.display = 'none';
        });
        function reload(){
            location.href="user";
        }
        function resetPassword() {
            document.getElementById('passwordTr').style.display = 'table-row';
        }
        function setReportPlaceShow() {
            var power=$('#power option:selected').val();
            if(power == "admin"){
                document.getElementById('reportPlaceTr').style.display = 'none';
                document.getElementById('subPlaceTr').style.display = 'none';
            } else {
                document.getElementById('reportPlaceTr').style.display = 'table-row';
                document.getElementById('subPlaceTr').style.display = 'table-row';
            }
        }
        function setSubPlace(){
            var place=$('#reportPlace option:selected').val();
            $.ajax({
                url:"message-getSubPlace",
                type:"post",
                dataType:"json",
                data:{
                    place:place,
                },
                success:function(data){
                    var row="<option value='0'>机构名称</option>";
                    $(data).each(function(index){
                        row+="<option value='"+data[index].subPlace+"' >"+data[index].subPlace+"</option>";
                    })
                    $("#subPlace").html(row);
                }
            })
        }

        function editUser(){
            var username = $("#username").val();
            var password =$('#password').val();
            var power=$('#power option:selected').val();
            var place=$('#reportPlace option:selected').val();
            var subPlace=$('#subPlace option:selected').val();
            var changePassword;
            if(username == ""){
                $("#message").html("输入账号不能为空");
                $('#false').modal('show');
                return 0;
            }
            if(power =="school" && (place=="0" || subPlace=="0")){
                $("#message").html("必须选择对应报考机构");
                $('#false').modal('show');
                return 0;
            }
            if(password == ""){
                changePassword = "";
            } else {
                changePassword = $.md5($.md5(password));
            }
            $.ajax({
                url:"user-edit1",
                type:"post",
                data:{
                    id:'${id}',
                    username:username,
                    password:changePassword,
                    power:power,
                    place:place,
                    subPlace:subPlace
                },
                success:function(data){
                    if(data=="success")
                        $('#success').modal('show');
                    else if(data == "is_exist"){
                        $("#message").html("用户名已存在");
                        $('#false').modal('show');
                    } else if(data == "no_place"){
                        $("#message").html("报名机构不存在");
                        $('#false').modal('show');
                    }
                }
            })
        }
    </script>
</body>
</html>
