<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hello
  Date: 2018/1/21
  Time: 22:08
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
                <h1 class="page-header">审核提交收费</h1>
            </div>
            <div class="col-lg-12 table-responsive table-bordered">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>报名点编号</th>
                        <th>报名省市</th>
                        <th>机构名称</th>
                        <th>等级</th>
                        <th>人数</th>
                        <th>费用</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${allCostList}" var="item" varStatus="status">
                        <tr>
                            <td>${item.subID}</td>
                            <td>${item.reportPlace}</td>
                            <td>${item.subPlace}</td>
                            <td>${item.level}</td>
                            <td>${item.count}</td>
                            <td>${item.remark}</td>
                            <td><button type="button" onclick="commitCost('${item.id}')" class="btn btn-default">确认缴费</button>
                                <button type="button" data-toggle="modal" data-target="#delete" onclick="getId('${item.id}')" class="btn btn-default">取消</button>
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
                    <p>你确定要取消吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn btn-danger" data-dismiss="modal" onclick="deleteCommit()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">提交成功</h4>
                </div>
                <div class="modal-body text-center">
                    <p>确认成功</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="reloadPage()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="fail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">提交失败</h4>
                </div>
                <div class="modal-body text-center">
                    <p id="errMessage"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" >确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
</div>

<script>
    function commitCost(id)
    {
        $.ajax({
        url:"commitCost-commit",
        type:"post",
        data:{id:[].concat(id)},
            traditional: true,
        success:function(data){
            if(data=='success'){
                $("#success").modal('show');
            } else {
                $("#errMessage").html(data);
                $("#fail").modal('show');
            }

        }
    })

    }
    var id;
    function getId(Id){
        id=Id;
    }
    function deleteCommit(){
        $.ajax({
            url:"commitCost-delete",
            type:"post",
            data:{id:[].concat(id)},
            traditional: true,
            success:function(data){
                if(data=='success'){
                    location.reload();
                }
            }
        })
    }
    function reloadPage(){
        location.reload();
    }

</script>
</body>
</html>
