<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 22:51
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
    <link href="vendor/datetimepicker/jquery.datetimepicker.css" rel="stylesheet">
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
                <h1 class="page-header">excel录入报考信息</h1>
            </div>
            <div class="col-lg-12">
                <button type="button" class="btn btn-info" id="getModel" onclick="getExcel()">下载模板</button>
            </div>
            <div class="col-lg-12 time-row">
                <form action="message2" enctype="multipart/form-data" method="POST" id="fileUpload">
                    <table class="table" id="queryCondition">
                        <tbody class="tbd">
                        <tr>
                            <td>报名截止日期<input class="form-control" id="date" name="endSignUpdate" /></td>
                        </tr>
                        <tr>
                            <td align="right" style="padding-right: 2px">
                                <input name="myfiles" id="myfiles" style="display: none;" onchange="document.getElementById('filePath').value=this.value" type="file">
                                <div class="input-group">
                                    <input name="filePath" class="form-control" id="filePath" type="text" disabled>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info" id="btn_check">请选择文件</button>
                                    </span>
                                </div>
                            </td>
                            <td align="left" style="padding-left: 2px">
                                <button type="button" class="btn btn-info" id="upload" onclick="submitExcel()">导入</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>

            </div>
            <!-- /.col-lg-12 -->
        </div>


    </div>
    <div class="modal fade" id="commit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">提交提示</h4>
                </div>
                <div class="modal-body text-center">
                    <p>系统正在提交表格，请等待</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
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
</div>

<script src="vendor/datetimepicker/jquery.datetimepicker.js"></script>
<script>
    function submitExcel(){
        var excelFile = $("#myfiles").val();
        var date = $('#date').val();
        if(excelFile=='') {$("#message").html('请选择需上传的文件!'); $("#false").modal('show');return false;}
        else if(excelFile.indexOf('.xls')==-1){$("#message").html("文件格式不正确，请选择正确的Excel文件(后缀名.xls)!");$("#false").modal('show');return false;}
        else if(date ==''){$("#message").html('请选择报名截止日期!'); $("#false").modal('show');return false;}
        else {
            $("#commit").modal('show');
            $("#fileUpload").submit();
        }
    }

    $(function() {
        $('#date').datetimepicker({
            format:    'Y/m/d',
            formatDate: 'Y/m/d',
            timepicker: false,
            step: 30,
            roundTime: 'round',
        });
        $("#btn_check").click(function() {
            $("#myfiles").trigger('click');
        });
//        $("#filePath").click(function() {
//            $("#myfiles").trigger('click');
//        });
    });
    function getExcel(){
        location.href="<%=request.getContextPath()%>/message1/getExcel";
    }
</script>
</body>
</html>
