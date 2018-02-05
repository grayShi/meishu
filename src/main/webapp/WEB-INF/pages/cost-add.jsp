<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 3:27
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
                <h1 class="page-header">新增收费信息</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-primary" onclick="location='cost'"><i class="fa fa-chevron-circle-left"></i>返回</button>
            </div>
            <div class="col-lg-6 col-lg-offset-3">
                <table class="table vertical-table vertical-table1">
                    <tbody>
                    <tr>
                        <td>考试级别</td>
                        <td>
                            <select id="level" class="form-control">

                            </select></td>
                    </tr>
                    <tr>
                        <td>考务费</td>
                        <td><input class="form-control" id="kaowufei"/></td>
                    </tr>
                    <tr>
                        <td>报名费</td>
                        <td><input class="form-control" id="baomingfei"/></td>
                    </tr>
                    <tr>
                        <td>证书费</td>
                        <td><input class="form-control" id="zhengshufei"/></td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td id="remark"></td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal"  onclick="addCost()">提交</button>
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
        $(function(){
            var cos=JSON.parse('${costList}');
            var realCost=[];
            for(var i=0;i<cos.length;i++){
                realCost.push(cos[i].level);
            }
            var row="";
            var level=[1,2,3,4,5,6,7,8,9,10];
            for(var i=0;i<level.length;i++){
                if(realCost.indexOf(level[i])== -1){
                    row+='<option value="'+level[i]+'">'+level[i]+'级</option>';
                }
            }
            $("#level").html(row);
        })
        function addCost(){
            var level=$("#level option:selected").val();
            var kaowufei=$("#kaowufei").val();
            var baomingfei=$("#baomingfei").val();
            var zhengshufei=$("#zhengshufei").val();
            if(kaowufei=="" || baomingfei =="" || zhengshufei =="" ){
                $("#message").html("输入数据不能为空");
                $('#false').modal('show');
                return 0;
            }
            if(isNaN(kaowufei)||isNaN(baomingfei)||isNaN(zhengshufei)){
                $("#message").html("费用必须为数字");
                $('#false').modal('show');
                return 0;
            }
            var remark =(parseFloat(kaowufei)+parseFloat(baomingfei)+parseFloat(zhengshufei)).toFixed(1);
            document.getElementById("remark").innerHTML=remark;

            $.ajax({
                url:"cost-add1",
                type:"post",
                data:{
                    level:level,
                    kaowufei:kaowufei,
                    baomingfei:baomingfei,
                    zhengshufei:zhengshufei,
                    remark:remark
                },
                success:function(data){
                    if(data=="success")
                        $('#success').modal('show');
                }
            })
        }
        function reload(){
            location.href="cost";
        }
        $("#kaowufei").keyup(function(){
            var kaowufei=$("#kaowufei").val();
            var baomingfei=$("#baomingfei").val();
            var zhengshufei=$("#zhengshufei").val();
            if(kaowufei!="" && baomingfei !="" && zhengshufei !="" ){
                if(!isNaN(kaowufei) && !isNaN(baomingfei) && !isNaN(zhengshufei)) {
                    var remark = (parseFloat(kaowufei) + parseFloat(baomingfei) + parseFloat(zhengshufei)).toFixed(1);
                    document.getElementById("remark").innerHTML = remark;

                }
            }
        })
        $("#baomingfei").keyup(function(){
            var kaowufei=$("#kaowufei").val();
            var baomingfei=$("#baomingfei").val();
            var zhengshufei=$("#zhengshufei").val();
            if(kaowufei!="" && baomingfei !="" && zhengshufei !="" ){
                if(!isNaN(kaowufei) && !isNaN(baomingfei) && !isNaN(zhengshufei)) {
                    var remark = (parseFloat(kaowufei) + parseFloat(baomingfei) + parseFloat(zhengshufei)).toFixed(1);
                    document.getElementById("remark").innerHTML = remark;

                }
            }
        })
        $("#zhengshufei").keyup(function(){
            var kaowufei=$("#kaowufei").val();
            var baomingfei=$("#baomingfei").val();
            var zhengshufei=$("#zhengshufei").val();
            if(kaowufei!="" && baomingfei !="" && zhengshufei !="" ){
                if(!isNaN(kaowufei) && !isNaN(baomingfei) && !isNaN(zhengshufei)) {
                    var remark = (parseFloat(kaowufei) + parseFloat(baomingfei) + parseFloat(zhengshufei)).toFixed(1);
                    document.getElementById("remark").innerHTML = remark;

                }
            }
        })
    </script>
</body>
</html>
