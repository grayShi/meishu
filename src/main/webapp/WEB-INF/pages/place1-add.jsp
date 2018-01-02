<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 2:25
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
                <h1 class="page-header">新增考点地址</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='place1'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1" id="table">
                    <tbody>
                    <tr>
                        <td>考点地址</td>
                        <td><input class="form-control" id="place"/></td>
                    </tr>
                    <tr>
                        <td>考场地址</td>
                        <td><input class="form-control" id="classPlace"/></td>
                    </tr>
                    <tr>
                        <td>容纳人数</td>
                        <td><input class="form-control" id="count"/></td>
                    </tr>
                    <tr>
                        <td>报名省市</td>
                        <td>
                            <select id="reportPlace"class="form-control" onchange="javascript:setSubPlace()">
                                <option value="0">报名省市</option>
                                <c:forEach items="${place}" var="item">
                                    <option value="${item}" >${item}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>机构名称</td>
                        <td>
                            <select id="subPlace" class="form-control">
                                <option value="0">机构名称</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td><input class="form-control" id="remark"/></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal" onclick="addPlace()">保存</button>
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
        function addPlace(){
            if($('#place').val()=="" || $('#classPlace').val()=="" || $('#count').val()==""){
                $("#message").html('含有空输入');
                $('#false').modal('show');
                return 0;
            }
            if(isNaN($("#count").val())){
                $("#message").html("人数必须为数字");
                $('#false').modal('show');
                return 0;
            }
            var place = $('#place').val();
            var classPlace =$('#classPlace').val();
            var count=$('#count').val();
            var remark = $('#remark').val();
            var reportPlace=$("#reportPlace option:selected").val();
            var subPlace=$("#subPlace option:selected").val();
            if(reportPlace =="0" || subPlace =="0"){
                $("#message").html("报名省市.机构名称不能为空");
                $('#false').modal('show');
                return 0;
            }
            $.ajax({
                url: "place1-add1",
                type: "post",
                data: {
                    place: place,
                    remark: remark,
                    classPlace: classPlace,
                    count:count,
                    reportPlace:reportPlace,
                    subPlace:subPlace
                },
                success: function (data) {
                    if (data == "success")
                        $('#success').modal('show');
                    else if(data == "is_exist") {
                        $("#message").html("存在相同数据");
                        $('#false').modal('show');
                    }
                }
            })

        }
        function reload(){
            location.href="place1";
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
    </script>
</body>
</html>
