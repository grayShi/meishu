<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/28
  Time: 0:07
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
<style>
    .row-top{
        margin-top: 1%;
        margin-bottom: 1%;
    }
</style>
<body>
<div id="wrapper">
    <!-- Sidebar -->
    <%--<jsp:include page="public.jsp" flush="true">--%>
    <%--</jsp:include>--%>
    <%@include file="public.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">考试信息修改</h1>
            </div>
        </div>
        <div class="row">
                <div class="col-lg-12 row-top">
                    <div class="col-lg-3">
                        <span>姓名</span>
                        <input class="form-control" id="name"/>
                    </div>
                    <div class="col-lg-3">
                        <span>报考科目</span>
                        <select id="subject" onchange="javaScript:setLevel()" class="form-control">
                            <option value="0" selected="selected">科目</option>
                            <c:forEach items="${subjectList}" var="item">
                                <option value="${item.id}￥${item.subject}" >${item.subject}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-3">
                        <span>报考级别</span>
                        <select id="level" class="form-control">
                            <option value="0" selected="selected">报考级别</option>
                            <c:forEach items="${levelList}" var="item">
                                <option value="${item}">${item}级</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-3">
                        <span>准考证号</span>
                        <input class="form-control" id="number"/>
                    </div>
                </div>
            <div class="col-lg-12 row-top">
                <div class="col-lg-3">
                    <span> 报名截止日期</span>
                    <select id="endSignUpTime"class="form-control" >
                        <option value="0" selected="selected">报名截止日期</option>
                        <c:forEach items="${endTimeList}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span> 考试时间</span>
                    <select id="time"class="form-control" >
                        <option value="0" selected="selected">考试时间</option>
                        <c:forEach items="${timeList}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span> 报名省市-机构名称</span>
                    <select id="reportPlace"class="form-control" >
                        <option value="0" selected="selected">报名省市</option>

                    </select>
                </div>
                <div class="col-lg-3">
                    <span> 考点地址-考场地址</span>
                    <select id="examPlace" class="form-control">
                        <option value="0" selected="selected">考点地址</option>
                        <c:forEach items="${examPlaceList}" var="item">
                            <option value="${item.place}￥${item.classPlace}">${item.place}-${item.classPlace}</option>
                        </c:forEach>
                    </select>
                </div>
                </div>
                <div class="col-lg-12 text-center">
                    <input type="checkbox" id="checkDelete" name="checkAll" />查看删除考生
                    <button type='button' data-toggle='modal' class='btn btn-default' data-target='#delete-total'>批量删除</button>
                    <button class="btn btn-primary" type="button" onclick="getSearch()">搜索</button>
                    <button class="btn btn-primary" onclick="getExcel()">导出EXCEL</button>
                </div>

            </div>
        <div class="row">
            <div class="table-responsive table-bordered">
                <table class="table table-striped table-bordered table-hover row-top" id="table">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll" name="checkAll" /></th>
                        <th>准考证号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>出生日期</th>
                        <th>考试时间</th>
                        <th>考试科目</th>
                        <th>级别</th>
                        <th>报名省市 机构名称</th>
                        <th>考点地址 考场地址</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="list">

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
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="deleteMessage()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="delete-total" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="totalDelete()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="rollback" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="rollbackById()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">修改信息</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="form-group">
                            <label>姓名</label>
                            <input id="editName" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label>性别</label>
                            <select id="editSex" class="form-control">
                                <option value="男" selected="selected">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>出生日期</label><input id="editBirth" class="form-control"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-info"  onclick="saveMessage()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<script src="js/checkBox.js"></script>

<script>
    $(function(){
        var reportList = JSON.parse('${messageReport}');
        var row ='<option value="0" selected="selected">报名省市</option>';
        for(var j=0;j<reportList.length;j++){
            var subPlace1=reportList[j];
            var sub3="";
            for(var x=0;x<subPlace1[1].length;x++){
                if(subPlace1[1][x]=="￥"){
                    for(var y=x+1;y<subPlace1[1].length;y++) {
                        sub3 += subPlace1[1][y];
                    }
                    break;
                }
            }
            row+="<option value='"+subPlace1+"'>"+subPlace1[0]+"-"+sub3+"</option>";
        }
        $("#reportPlace").html(row);

        <%--var message=JSON.parse('${messageList}');--%>
        <%--var list="";--%>
        <%--for(var i=0;i<message.length;i++){--%>
            <%--var subject=message[i].subject;--%>
            <%--var sub1="";--%>
            <%--for(var x=0;x<subject.length;x++){--%>
                <%--if(subject[x]=="￥"){--%>
                    <%--for(var j=x+1;j<subject.length;j++) {--%>
                        <%--sub1 += subject[j];--%>
                    <%--}--%>
                    <%--break;--%>
                <%--}--%>
            <%--}--%>
            <%--var subPlace=message[i].subPlace;--%>
            <%--var sub2="";--%>
            <%--for(var x=0;x<subPlace.length;x++){--%>
                <%--if(subPlace[x]=="￥"){--%>
                    <%--for(var j=x+1;j<subPlace.length;j++) {--%>
                        <%--sub2 += subPlace[j];--%>
                    <%--}--%>
                    <%--break;--%>
                <%--}--%>
            <%--}--%>
            <%--list+="<tr> " +--%>
                    <%--"<td><input type='checkbox' name='checkItem' value="+message[i].id+"/></td>"+--%>
                <%--"<td>"+message[i].cardNumber+"</td>"+--%>
                <%--"<td>"+message[i].name+"</td>"+--%>
                <%--"<td>"+message[i].sex+"</td>"+--%>
                <%--"<td>"+message[i].birth+"</td>"+--%>
                <%--"<td>"+message[i].time+"</td>"+--%>
                <%--"<td>"+sub1+"</td>"+--%>
                <%--"<td>"+message[i].level+"</td>"+--%>
                <%--"<td>"+message[i].reportPlace+" "+sub2+"</td>"+--%>
                <%--"<td>"+message[i].examPlace+" "+message[i].classPlace+"</td>"+--%>
                <%--"<td><button type='button' onclick='editMessage(\""+message[i].id+"\",\""+message[i].name+"\",\""+message[i].sex+"\",\""+message[i].birth+"\")' class='btn btn-default'>编辑</button> " +--%>
                <%--"<button type='button' data-toggle='modal' data-target='#delete' onclick='getId("+message[i].id+")' class='btn btn-default'>删除</button> </td>"--%>
        <%--}--%>
        <%--$("#list").html(list);--%>
        <%--initTableCheckbox();--%>
    });
    var id;
    function getId(Id){
        id=Id;
    }
    function deleteMessage(){
        $.ajax({
            url:"delete-start",
            type:"post",
            data:{
                id:id
            },
            success:function(data){
                if(data=="success"){
                    getSearch();
                }
            }
        })
    }
    function rollbackById() {
        $.ajax({
            url:"delete-rollback",
            type:"post",
            data:{
                id:id
            },
            success:function(data){
                if(data=="success"){
                    getSearch();
                }
            }
        })
    }
    function totalDelete() {
        var deleteArray = getCheck();
        console.log(deleteArray);
        $.ajax({
            url:"delete-startTotal",
            type:"post",
            traditional: true,
            data:{
                deleteArray:deleteArray
            },
            success:function(data){
                if(data=="success"){
                    getSearch();
                }
            }
        })
    }
    var NAME="";
    var SUBJECT="0";
    var CARDNUMBER="";
    var LEVEL="0";
    var EXAMPLACE="0";
    var CLASSPLACE="0";
    var REPORTPLACE ="0";
    var SUBPLACE ="0";
    var TIME ="0";
    var ENDSIGNTIME = "0";
    var CHECKDELETE = "0";
    function getSearch(){
        CHECKDELETE = $("#checkDelete")[0].checked;
        NAME=$("#name").val();
        SUBJECT=$("#subject option:selected").val();
        LEVEL = $("#level option:selected").val();
        CARDNUMBER=$("#number").val();
        TIME = $('#time').val();
        ENDSIGNTIME = $('#endSignUpTime').val();
        var examPlace=$("#examPlace option:selected").val();
        var reportPlace = $("#reportPlace option:selected").val();
        var exam=examPlace.split("￥");
        if(exam[0]!="0") {
            EXAMPLACE = exam[0];
            CLASSPLACE = exam[1];
        }else{
            EXAMPLACE = "0";
            CLASSPLACE = "0";
        }
        var report=reportPlace.split(",");
        if(report[0]!="0") {
            REPORTPLACE = report[0];
            SUBPLACE = report[1];
        }else{
            REPORTPLACE = "0";
            SUBPLACE = "0";
        }
        var list="";
        $.ajax({
            url:"delete-search",
            type:"post",
            dataType:"json",
            async:false,
            data:{
                name:NAME,
                subject:SUBJECT,
                level:LEVEL,
                cardNumber:CARDNUMBER,
                examPlace:EXAMPLACE,
                classPlace:CLASSPLACE,
                reportPlace:REPORTPLACE,
                subPlace:SUBPLACE,
                time:TIME,
                endSignUpTime:ENDSIGNTIME,
                isDelete: CHECKDELETE,
            },
            success:function(data){
                $(data).each(function(index) {
                    var subject = data[index].subject;
                    var sub1 = "";
                    for (var x = 0; x < subject.length; x++) {
                        if (subject[x] == "￥") {
                            for (var j = x + 1; j < subject.length; j++) {
                                sub1 += subject[j];
                            }
                            break;
                        }
                    }
                    var subPlace = data[index].subPlace;
                    var sub2 = "";
                    for (var x = 0; x < subPlace.length; x++) {
                        if (subPlace[x] == "￥") {
                            for (var j = x + 1; j < subPlace.length; j++) {
                                sub2 += subPlace[j];
                            }
                            break;
                        }
                    }
                    if (!CHECKDELETE) {
                        list += "<tr> " +
                            "<td><input type='checkbox' name='checkItem' value=" + data[index].id + "></td>" +
                            "<td>" + data[index].cardNumber + "</td>" +
                            "<td>" + data[index].name + "</td>" +
                            "<td>" + data[index].sex + "</td>" +
                            "<td>" + data[index].birth + "</td>" +
                            "<td>" + data[index].time + "</td>" +
                            "<td>" + sub1 + "</td>" +
                            "<td>" + data[index].level + "</td>" +
                            "<td>" + data[index].reportPlace + " " + sub2 + "</td>" +
                            "<td>" + data[index].examPlace + " " + data[index].classPlace + "</td>" +
                            "<td><button type='button' onclick='editMessage(\"" + data[index].id + "\",\"" + data[index].name + "\",\"" + data[index].sex + "\",\"" + data[index].birth + "\")' class='btn btn-default'>编辑</button> " +
                            "<button type='button' data-toggle='modal' data-target='#delete' onclick='getId(" + data[index].id + ")' class='btn btn-default'>删除</button> </td></tr>";
                    } else {
                        list += "<tr> " +
                            "<td><input type='checkbox' name='checkItem' value=" + data[index].id + "></td>" +
                            "<td>" + data[index].cardNumber + "</td>" +
                            "<td>" + data[index].name + "</td>" +
                            "<td>" + data[index].sex + "</td>" +
                            "<td>" + data[index].birth + "</td>" +
                            "<td>" + data[index].time + "</td>" +
                            "<td>" + sub1 + "</td>" +
                            "<td>" + data[index].level + "</td>" +
                            "<td>" + data[index].reportPlace + " " + sub2 + "</td>" +
                            "<td>" + data[index].examPlace + " " + data[index].classPlace + "</td>" +
                            "<td><button type='button' onclick='editMessage(\"" + data[index].id + "\",\"" + data[index].name + "\",\"" + data[index].sex + "\",\"" + data[index].birth + "\")' class='btn btn-default'>编辑</button> " +
                            "<button type='button' data-toggle='modal' data-target='#rollback' onclick='getId(" + data[index].id + ")' class='btn btn-default'>撤销</button> </td></tr>";
                    }
                    });
                $("#list").html(list);
                initTableCheckbox('table','checkAll',true);
            }
        })
    }
    function setLevel(){
        var subject = $("#subject option:selected").val();
        if(subject!='0'){
            $.ajax({
                url:"data-setLevel",
                type:"post",
                dataType:"json",
                data:{
                    subject:subject
                },
                success: function(data){
                    var str="<option value='0' selected='selected'>报考级别</option>";
                    $(data).each(function(index){
                        str+="<option value='"+data[index]+"'>"+data[index]+"级</option>";
                    })
                    $("#level").html(str);
                }
            })
        }
        else{
            var str="<option value='0' selected='selected'>报考级别</option>";
            var level=JSON.parse('${levelList}');
            for(var i=0;i<level.length;i++){
                str+="<option value='"+level[i]+"'>"+level[i]+"级</option>";
            }
            $("#level").html(str);
        }
    }
    function getExcel() {
        CHECKDELETE = $("#checkDelete")[0].checked;
        NAME=$("#name").val();
        SUBJECT=$("#subject option:selected").val();
        LEVEL = $("#level option:selected").val();
        CARDNUMBER=$("#number").val();
        TIME = $('#time').val();
        ENDSIGNTIME = $('#endSignUpTime').val();
        var examPlace=$("#examPlace option:selected").val();
        var reportPlace = $("#reportPlace option:selected").val();
        var exam=examPlace.split("￥");
        if(exam[0]!="0") {
            EXAMPLACE = exam[0];
            CLASSPLACE = exam[1];
        }else{
            EXAMPLACE = "0";
            CLASSPLACE = "0";
        }
        var report=reportPlace.split(",");
        if(report[0]!="0") {
            REPORTPLACE = report[0];
            SUBPLACE = report[1];
        }else{
            REPORTPLACE = "0";
            SUBPLACE = "0";
        }
        location.href="delete-getExcel?name="+NAME+"&subject="+SUBJECT+"&cardNumber="+CARDNUMBER+"&level="+LEVEL+"&examPlace="
            +EXAMPLACE+"&classPlace="+CLASSPLACE+"&reportPlace="+REPORTPLACE+"&subPlace="+SUBPLACE+"&time="+TIME+"&endSignUpTime="+ENDSIGNTIME+"&isDelete="+CHECKDELETE;
    }
    var ID;
    function editMessage(id,name,sex,birth) {
        ID=id;
        $("#editName").val(name);
        $("#editSex").val(sex);
        $("#editBirth").val(birth);
        $("#edit").modal('show');
    }
    function saveMessage() {
        var editName = $("#editName").val();
        var editSex = $("#editSex option:selected").val();
        var editBirth = $("#editBirth").val();
        if(editName!=""&& editBirth!="") {
            $.ajax({
                url: "delete-editMessage",
                type: "post",
                data: {
                    id: ID,
                    editName: editName,
                    editSex: editSex,
                    editBirth: editBirth
                },
                success: function (data) {
                    if(data == "success"){
                        getSearch();
                        $("#edit").modal('hide');
                        alert("修改成功");
                    }
                }
            })
        }else{
            alert("输入数据不允许为空");
        }
    }
</script>
</body>
</html>
