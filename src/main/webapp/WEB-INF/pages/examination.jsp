<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/31
  Time: 23:45
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

    <%@include file="public.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">整体分配考场</h1>
            </div>
        </div>
            <div class="row">
                <div class="col-lg-1 text-center">
                    考试时间
                </div>
                <div class="col-lg-2">
                    <select id="time" class="form-control">
                        <c:forEach items="${timeList}" var="item">
                            <option value="${item}" >${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-9">
                    <button class="btn btn-default" type="button" onclick="getExamPlace()">查看考点</button>
                    <button class="btn btn-info" type="button" onclick="getSubplace()">开始分配</button>
                    <%--<button class="btn btn-primary" type="button" onclick="showList()">查看分配情况</button>--%>
                    <button class="btn btn-danger" type="button" onclick="getCancel()">取消分配</button>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 table-responsive table-bordered"  style="max-height: 70%;overflow:auto;">
                    <table class="table table-striped table-bordered table-hover" style="margin-top: 2%">
                        <thead>
                        <tr>
                            <th>考点编号</th>
                            <th>报名省市</th>
                            <th>机构名称</th>
                        </tr>
                        </thead>
                        <tbody id="place">

                        </tbody>
                    </table>
                </div>
                <div class="col-lg-4 table-responsive table-bordered"  style="max-height: 70%;overflow:auto;">
                    <table class="table table-striped table-bordered table-hover" style="margin-top: 2%">
                        <thead>
                        <tr>
                            <th>科目</th>
                            <th>级别</th>
                            <th>未分配</th>
                            <th>总人数</th>
                        </tr>
                        </thead>
                        <tbody id="subject">

                        </tbody>
                    </table>
                </div>
                <div class="col-lg-4 table-responsive table-bordered"  style="max-height: 70%;overflow:auto;">
                    <table class="table table-striped table-bordered table-hover" style="margin-top: 2%">
                        <thead>
                        <tr>
                            <th>考点地址</th>
                            <th>考场地址</th>
                            <th>空位数</th>
                            <th>总位数</th>
                        </tr>
                        </thead>
                        <tbody id="examPlace">

                        </tbody>
                    </table>
                </div>
            </div>


    </div><!-- /#page-wrapper -->
        <div class="modal fade" id="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">分配失败</h4>
                    </div>
                    <div class="modal-body text-center">
                        <p id="modalMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" >确定</button>
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
                        <p>考场分配成功</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >确定</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <div class="modal fade" id="cancel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">取消分配</h4>
                    </div>
                    <div class="modal-body">
                        <div>报名省市-机构名称 <select id="reportPlaceName" class="form-control"></select></div>
                        <div style="padding-top: 5%">考点地址-考场地址<select id="examPlaceName" class="form-control"></select></div>
                    </div>
                    <div class="modal-footer">
                        <div style="text-align: center">取消<p class="text-info">"报名省市-机构名称"</p>所有考生在<p class="text-info">"考点地址-考场地址"</p>的分配,二者均为选填.</div>
                        <button type="button" class="btn btn-success" onclick="setCancel()" >确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</div>

<script>
    $(function(){
        $("#distribute").dropdown('toggle');
    });
    var ReportPlace=[];
    var SubPlace=[];
    function getSearch(){
    ReportPlace.length=0;
    SubPlace.length=0;
    $.ajax({
        url:"examination/getSearch",
        type:"post",
        dataType:"json",
        data:{
        },
        success:function(data){
            var row="";
            for(var i=0;i<data.length;i++) {
                var sub=data[i];
                var subplace1=sub[1];
                ReportPlace.push(sub[0]);
                SubPlace.push(sub[1]);
                var subp1="";
                var subID="";
                for(var x=0;x<subplace1.length;x++){
                    if(subplace1[x]=="￥"){
                        for(var j=x+1;j<subplace1.length;j++) {
                            subp1 += subplace1[j];
                        }
                        break;
                    }
                    subID+=subplace1[x];
                }
                row+="<tr><td>"+subID+"</td><td><a href='javascript:void(0)' onclick='searchPlace(\""+sub[0]+"\",\""+sub[1]+"\")'>"+sub[0]+"</a></td><td><input name='subPlace' type='checkbox' />"+subp1+"</td></tr>";
            }
            $("#place").html(row);
            $('#subject').html("");

        }
    })
    }
    var Subject=[];
    var Level=[];
    var REPORTPLACE;
    var SUBPLACE;
    var TIME;
    function searchPlace(reportPlace,subPlace){
    Subject.length=0;
    Level.length=0;
    REPORTPLACE=reportPlace;
    SUBPLACE=subPlace;
    $.ajax({
        url:"examination/searchSubject",
        dataType:"json",
        type:"post",
        data:{
            reportPlace:reportPlace,
            subPlace:subPlace,
        },
        success:function(data){
            var row="";
            for(var i=0;i<data.length;i++) {
                var sub=data[i];
                var sub1=sub[0];
                Subject.push(sub[0]);
                Level.push(sub[1]);
                var subjcet1="";
                for(var x=0;x<sub1.length;x++){
                    if(sub1[x]=="￥"){
                        for(var j=x+1;j<sub1.length;j++) {
                            subjcet1 += sub1[j];
                        }
                        break;
                    }
                }
                getPlaceCount(sub[0],sub[1],reportPlace,subPlace);
                row+="<tr><td><input name='subject' type='checkbox' />"+subjcet1+"</td><td>"+sub[1]+"</td><td>"+otherCount+"</td><td>"+totalCount+"</td></tr>";
            }
            $("#subject").html(row);
        }
    })
    }
    var totalCount;
    var otherCount;
    function getPlaceCount(subject,level,reportPlace,subPlace){
    $.ajax({
        url:"examination/getPlaceCount",
        dataType:"json",
        type:"post",
        async:false,
        data:{
            subject:subject,
            level:level,
            reportPlace:reportPlace,
            subPlace:subPlace
        },
        success:function(data){
            totalCount=data[1];
            otherCount=data[0];
        }
    })
    }
    var changeList=[];        ////////////////////存储分配完成的List
    function getSubplace(){
    var realSubject=[];
    var realLevel=[];
    var realExamPlace=[];
    var realClassPlace=[];
    var realCount=[];
    var realReportPlace=[];
    var realSubPlace=[];
    var realExamTime=[];
    var subPlace=document.getElementsByName("subPlace");
    var count3=0;          //选中个数
    for(var i=0;i<subPlace.length;i++) {
        if(subPlace[i].checked) {
            realReportPlace.push(ReportPlace[i]);
            realSubPlace.push(SubPlace[i]);
            count3++;
        }
    }
    var examPlace=document.getElementsByName("examPlace");
    var count2=0;
    for(var i=0;i<examPlace.length;i++) {
        if(examPlace[i].checked) {
            realExamPlace.push(ExamPlace[i]);
            realClassPlace.push(ClassPlace[i]);
            realExamTime.push(ExamTime[i]);
            realCount.push(count[i]);
            count2++;
        }
    }
    if(count2==0) {
        $("#modalMessage").html('未选考场');
        $("#false").modal('show');
        count2=0;
        return 0;
    }
    if(count3!=0) {
        $.ajax({
            url: "examination/startPlace",
            type: "post",
            dataType:"json",
            traditional: true,
            async: false,
            data: {
                reportPlace: realReportPlace,
                subPlace: realSubPlace,
                time: TIME,
                realExamPlace: realExamPlace,
                realExamTime:realExamTime,
                realClassPlace: realClassPlace,
                realCount: realCount
            },
            success: function (data) {
                if (data.length!=0) {
                    for(var i = 0;i<data.length;i++){
                        changeList.push(data[i]);
                    }
                    ExamTime.length = 0;
                    ExamPlace.length = 0;
                    ClassPlace.length = 0;
                    count.length = 0;
                    getSearch();
                    getExamPlace();
                    $("#success").modal('show');
                }else{
                    $('#modalMessage').html('分配0人,请检查科目未分配人数或考场空位数');
                    $("#false").modal('show');
                }
            }
        })
    }
    else {
        var subject = document.getElementsByName("subject");
        var count1 = 0;          //选中个数
        for (var i = 0; i < subject.length; i++) {
            if (subject[i].checked) {
                realSubject.push(Subject[i]);
                realLevel.push(Level[i]);
                count1++;
            }
        }
        if (count1 == 0) {
            $('#modalMessage').html('未选报名点或未选科目');
            $("#false").modal('show');
            count1 = 0;
            return 0;
        }
        $.ajax({
            url: "examination/start",
            type: "post",
            dataType:"json",
            traditional: true,
            async: false,
            data: {
                reportPlace: REPORTPLACE,
                subPlace: SUBPLACE,
                time: TIME,
                realSubject: realSubject,
                realLevel: realLevel,
                realExamPlace: realExamPlace,
                realClassPlace: realClassPlace,
                realExamTime:realExamTime,
                realCount: realCount
            },
            success: function (data) {
                if (data.length!=0) {
                    for(var i = 0;i<data.length;i++){
                        changeList.push(data[i]);
                    }
                    ExamPlace.length = 0;
                    ClassPlace.length = 0;
                    ExamTime.length = 0;
                    count.length = 0;
                    searchPlace(REPORTPLACE, SUBPLACE, TIME);
                    getExamPlace();
                    $("#success").modal('show');
                }else{
                    $('#modalMessage').html('分配0人,请检查科目未分配人数或考场空位数');
                    $("#false").modal('show');
                }
            }
        })
    }
    }
    var ExamPlace=[];
    var ClassPlace=[];
    var ExamTime=[];
    var count=[];
    $(function(){
    getSearch();
    })
    function getExamPlace(){
    var time = $("#time option:selected").val();
    TIME=time;
    $.ajax({
        url:"examination/examPlace",
        dataType:"json",
        type:"post",
        async:false,
        data:{
            time:time,
        },
        success:function(data){
            var row="";
            var otherExamPlace;
            ExamPlace.length=0;
            ClassPlace.length=0;
            ExamTime.length=0;
            count.length = 0;
            $(data).each(function(index){
                ExamPlace.push(data[index].place);
                ClassPlace.push(data[index].classPlace);
                if(data[index].examTime=="")
                    ExamTime.push("noTime");
                else
                    ExamTime.push(data[index].examTime);
                getExamPlaceCount(data[index].place,data[index].classPlace);
                otherExamPlace=data[index].count-examCount;
                count.push(otherExamPlace);
                row+="<tr> <td><input name='examPlace' type='checkbox' />  "+data[index].place+"</td> <td>"+data[index].classPlace+"</td> <td>"+otherExamPlace+"</td> <td>"+data[index].count+"</td> </tr>"
            })
            $("#examPlace").html(row);
        }
    })
    }
    var examCount;
    function getExamPlaceCount(examPlace,classPlace){
    $.ajax({
        url:"examination/getExamPlaceCount",
        dataType:"json",
        type:"post",
        async:false,
        data:{
            examPlace:examPlace,
            classPlace:classPlace
        },
        success:function(data){
            examCount=data;
        }
    })
    }
    function getCancel() {
    getConfigExamList();
    getConfigReportList();
    $("#cancel").modal('show');
    }
    function getConfigExamList(){
    $.ajax({
        url:"examination/getConfigExamList",
        dataType:"json",
        type:"post",
        async:"false",
        data:{},
        success:function (data) {
            var row ="<option value='0' selected='selected'>考点地址-考场地址</option>";
            for(var i = 0;i<data.length;i++){
                row+="<option value='"+data[i]+"'>"+data[i][0]+"-"+data[i][1]+"</option>";
            }
            $("#examPlaceName").html(row);
        }
    })
    }
    function getConfigReportList(){
    $.ajax({
        url:"examination/getConfigReportList",
        dataType:"json",
        type:"post",
        async:"false",
        data:{},
        success:function (data) {
            var row ="<option value='0' selected='selected'>报名省市-机构名称</option>";
            for(var x = 0;x<data.length;x++){
                var subPlace1="";
                var subPlace=data[x][1];
                for(var i=0;i<subPlace.length;i++){
                    if(subPlace[i]=="￥"){
                        for(var j=i+1;j<subPlace.length;j++) {
                            subPlace1 += subPlace[j];
                        }
                        break;
                    }
                }
                row+="<option value='"+data[x]+"'>"+data[x][0]+"-"+subPlace1+"</option>";
            }
            $("#reportPlaceName").html(row);
        }
    })
    }


    function setCancel() {
    var reportPlaceName = $("#reportPlaceName option:selected").val();
    var examPlaceName = $("#examPlaceName option:selected").val();
    var examPlace="";
    var classPlace ="";
    var reportPlace = "";
    var subPlace ="";
    var isAllCancel = false;
    if(reportPlaceName == '0' && examPlaceName == '0'){
        if(confirm("确定取消全部考场分配 ?")) {
            isAllCancel = true;
        }else{
            return "";
        }
    }else {
        if (reportPlaceName != "0") {
            reportPlace = reportPlaceName.split(",")[0];
            subPlace = reportPlaceName.split(",")[1];
        }
        if (examPlaceName != "0") {
            examPlace = examPlaceName.split(",")[0];
            classPlace = examPlaceName.split(",")[1];
        }
    }
    $.ajax({
        url:"examination/startCancel",
        data:{
            reportPlace:reportPlace,
            subPlace:subPlace,
            examPlace:examPlace,
            classPlace:classPlace,
            isAllCancel:isAllCancel
        },
        dataType:"json",
        type:"post",
        success:function(data){
            alert("共取消"+data.length+"人");
            location.reload();
        }
    })

    }

</script>
</body>
</html>
