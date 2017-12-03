<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 1:40
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
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%--<jsp:include page="public.jsp" flush="true">--%>
    <%--</jsp:include>--%>
    <%@include file="public.jsp"%>

    <div id="page-wrapper">


        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">新增报名地址</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='place'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1" id="table">
                    <tbody>
                    <tr>
                        <td>报名省市</td>
                        <td><input id="report" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>机构名称</td>
                        <td><input id="subReport1"class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td><input id="mark" class="form-control"/></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal" onclick="editSubPlace()">添加机构名称</button>
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

<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="dist/js/sb-admin-2.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="vendor/metisMenu/metisMenu.min.js"></script>

<script>
    function reload(){
        location.href="place";
    }
    function addPlace(){
        if($('#subReport1').val()=="" || $('#report').val()==""){
            $('#message').html('没有报考点');
            $('#false').modal('show');
            return 0;
        }
        var place;
        var remark;
        var subPlace;
        var sub=[];
        for(var i=1;i<=count;i++) {
            subPlace=$('#subReport' + i).val();
            if (subPlace != "") {
                sub.push(subPlace);
                realCount++;
            }
            else
                count1--;
        }
        place = $('#report').val();
        remark = $('#mark').val();
        if(realCount == count1) {
            $.ajax({
                url: "place-add1",
                type: "post",
                traditional: true,
                data: {
                    place: place,
                    remark: remark,
                    subPlace: sub
                },
                success: function (data) {
                    if (data == "success") {
                        $('#success').modal('show');
                        realCount = 0;
                        count1 = 1;
                    }else{
                        $("#message").html("存在"+data+"条数据重复未提交")
                        $('#false').modal('show');
                    }

                }
            })
        }else{
            $("#message").html("报名机构数量存在问题")
            $('#false').modal('show');
        }


    }
    var count=1;   //子报名地址个数
    var realCount=0;
    var count1=1;
    function editSubPlace(){
        count++;
        count1++;
        var table = document.getElementById('table');
        var row=table.insertRow(count);
        var cell1=row.insertCell(0);
        var cell2=row.insertCell(1);
        cell1.innerHTML="机构名称";
        cell2.innerHTML="<td><input class='form-control' id='subReport"+count+"'/></td>";
    }
</script>
</body>
</html>
