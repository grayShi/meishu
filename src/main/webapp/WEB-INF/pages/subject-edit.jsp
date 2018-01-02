<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 石高磊
  Date: 2017/8/27
  Time: 1:16
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
                <h1 class="page-header">修改考试科目</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='subject'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1">
                    <tbody>
                    <c:forEach items="${subjectEdit}" var="item">
                        <tr>
                            <td>科目名称</td>
                            <td><input class="form-control" id="subject" value="${item.subject}"/></td>

                        </tr>
                        <tr>
                            <td>备注</td>
                            <td><select  id="level" class="form-control">
                                <c:choose>
                                    <c:when test="${item.level!=0}">
                                        <option value="1"<c:if test="${item.level == 1 }"> selected="selected"</c:if> >1——1级</option>
                                        <option value="2"<c:if test="${item.level == 2 }"> selected="selected"</c:if>>1——2级</option>
                                        <option value="3"<c:if test="${item.level == 3 }"> selected="selected"</c:if>>1——3级</option>
                                        <option value="4"<c:if test="${item.level == 4 }"> selected="selected"</c:if>>1——4级</option>
                                        <option value="5"<c:if test="${item.level == 5 }"> selected="selected"</c:if>>1——5级</option>
                                        <option value="6"<c:if test="${item.level == 6 }"> selected="selected"</c:if>>1——6级</option>
                                        <option value="7"<c:if test="${item.level == 7 }"> selected="selected"</c:if>>1——7级</option>
                                        <option value="8"<c:if test="${item.level == 8 }"> selected="selected"</c:if>>1——8级</option>
                                        <option value="9"<c:if test="${item.level == 9 }"> selected="selected"</c:if>>1——9级</option>
                                        <option value="10"<c:if test="${item.level == 10 }"> selected="selected"</c:if>>1——10级</option>
                                    </c:when>
                                </c:choose>

                            </select></td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal"  onclick="editSubject()">提交</button>
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
        location.href="subject";
    }
    function editSubject(){
        var subject=$("#subject").val();
        var level=$("#level option:selected").val();
        if(subject==""){
            $('#message').html('没有输入考试科目');
            $('#false').modal('show');
            return 0;
        }
        $.ajax({
            url:"subject-edit1",
            type:"post",
            data:{
                id:'${id}',
                subject:subject,
                level:level,
            },
            success:function(data){
                if(data=="success")
                    $('#success').modal('show');
                else{
                    $("#message").html("已存在考试科目");
                    $('#false').modal('show');
                }
            }
        })
    }
    function reload(){
        location.href="subject";
    }

</script>
</body>
</html>
