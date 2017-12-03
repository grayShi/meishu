<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/27
  Time: 3:48
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
                <h1 class="page-header">手动录入报考信息</h1>
            </div>
            <div id="table" class="col-lg-12 text-center">
                <table class="table table-striped table-bordered table-hover">
                    <tbody>
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
                        <td>考生姓名</td>
                        <td><input class="form-control" id="name"/></td>
                    </tr>
                    <tr>
                        <td>性别</td>
                        <td><select id="sex" class="form-control">
                            <option value="男" selected="selected">男</option>
                            <option value="女">女</option>
                        </select>
                        </td>

                    </tr>
                    <tr>
                        <td>出生年月</td>
                        <td><input class="form-control" type="text" id="birth"/></td>
                    </tr>

                    <tr>
                        <td>国籍</td>
                        <td><input class="form-control" id="country"/></td>
                    </tr>
                    <tr>
                        <td>民族</td>
                        <td><input class="form-control" id="nation"/></td>
                    </tr>
                    <tr>
                        <td>联系地址</td>
                        <td><input class="form-control" id="address"/></td>
                    </tr>
                    <tr>
                        <td>电话</td>
                        <td><input class="form-control" id="phoneNumber"/></td>
                    </tr>
                    <tr>
                        <td>报考科目1</td>
                        <td><select id="subject1" class="form-control" onchange="javascript:setLevel1()">
                            <option value="0" selected="selected">科目</option>
                            <c:forEach items="${subject}" var="item">
                                <option value="${item.id}￥${item.subject}" >${item.subject}</option>
                            </c:forEach>
                        </select>
                            <select id="level1" class="form-control">
                                <option value="0" selected="selected">级别</option>

                            </select></td>
                    </tr>
                    <tr>
                        <td>报考科目2</td>
                        <td><select id="subject2" class="form-control" onchange="javascript:setLevel2()">
                            <option value="0" selected="selected">科目</option>
                            <c:forEach items="${subject}" var="item">
                                <option value="${item.id}￥${item.subject}" >${item.subject}</option>
                            </c:forEach>
                        </select>
                            <select  id="level2" class="form-control">
                                <option value="0" selected="selected">级别</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>报考科目3</td>
                        <td><select  id="subject3" class="form-control" onchange="javascript:setLevel3()">
                            <option value="0" selected="selected" >科目</option >
                            <c:forEach items="${subject}" var="item">
                                <option value="${item.id}￥${item.subject}" >${item.subject}</option>
                            </c:forEach>
                        </select>
                            <select id="level3" class="form-control">
                                <option value="0" selected="selected">级别</option>
                            </select></td>
                    </tr>
                    </tbody>
                </table>
                <div>说明：如果以前报考过，只输入姓名，性别，出生年月 点击搜索查询，就可查询出该考生信息</div>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">

            <div class="col-lg-4 col-lg-offset-5 col-md-4 col-md-offset-5 col-sm-4 col-sm-offset-4">
                <button class="btn btn-default" data-toggle="modal" id="button">新增</button>
                <button class="btn btn-default" onclick="getSearch()" >检索</button>
            </div>


        </div>


    </div>
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
                    <button type="button" class="btn btn-danger" data-dismiss="modal" >确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="dist/js/sb-admin-2.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="vendor/metisMenu/metisMenu.min.js"></script>
<script>
    $(function(){
        setSubPlace();
    });
//    $('#birth').datetimepicker({
//        lang:'ch',
//        format:"Y-m-d",
//        formatDate:'Y/m/d',
//        timepicker:false,
//        yearStart: 1990,
//        yearEnd: 2050
//    });
    function setSubPlace(){
        var place=$('#reportPlace option:selected').val();
        $.ajax({
            url:"message/getSubPlace",
            type:"post",
            dataType:"json",
            data:{
                place:place,
            },
            success:function(data){
                var row="<option value='0'>机构名称</option>";
                $(data).each(function(index){
                    row+="<option value='"+data[index].subPlaceId+"￥"+data[index].subPlace+"' >"+data[index].subPlace+"</option>";
                })
                $("#subPlace").html(row);
            }
        })
    }
    function setLevel1(){
        var subject=$("#subject1 option:selected").val();
        var subject1="";
        for(var i=0;i<subject.length;i++){
            if(subject[i]=="￥"){
                for(var j=i+1;j<subject.length;j++) {
                    subject1 += subject[j];
                }
                break;
            }
        }
        $.ajax({
            url:"message/getLevel",
            type:"post",
            dataType:"json",
            async:false,
            data:{
                subject:subject1,
            },
            success:function(data){
                var row='<option value="0" selected="selected">级别</option>'
                $(data).each(function(index){
                    for(var i=1;i<=data[index].level;i++){
                        row+='<option value="'+i+'">'+i+'级</option>'
                    }
                })
                $("#level1").html(row);
            }
        })
    }
    function setLevel2(){
        var subject=$("#subject2 option:selected").val();
        var level1=$("#level1 option:selected").val();
        var subject1=$("#subject1 option:selected").val();
        var subject2="";
        for(var i=0;i<subject.length;i++){
            if(subject[i]=="￥"){
                for(var j=i+1;j<subject.length;j++) {
                    subject2 += subject[j];
                }
                break;
            }
        }

        $.ajax({
            url:"message/getLevel",
            type:"post",
            dataType:"json",
            async:false,
            data:{
                subject:subject2,
            },
            success:function(data){
                var row='<option value="0" selected="selected">级别</option>';
                if(subject==subject1){
                    $(data).each(function(index){
                        for(var i=1;i<=data[index].level;i++){
                            if(i!=Number(level1)) {
                                row += '<option value="' + i + '">' + i + '级</option>';
                            }
                        }
                    })
                }else{
                    $(data).each(function(index){
                            for(var i=1;i<=data[index].level;i++){
                                row+='<option value="'+i+'">'+i+'级</option>';
                            }
                        }
                    )}
                $("#level2").html(row);
            }
        })
    }
    function setLevel3(){
        var subject=$("#subject3 option:selected").val();
        var level1=$("#level1 option:selected").val();
        var subject1=$("#subject1 option:selected").val();
        var level2=$("#level2 option:selected").val();
        var subject2=$("#subject2 option:selected").val();
        var subject3="";
        for(var i=0;i<subject.length;i++){
            if(subject[i]=="￥"){
                for(var j=i+1;j<subject.length;j++) {
                    subject3 += subject[j];
                }
                break;
            }
        }
        $.ajax({
            url:"message/getLevel",
            type:"post",
            dataType:"json",
            async:false,
            data:{
                subject:subject3,
            },
            success:function(data){
                var row='<option value="0" selected="selected">级别</option>';
                if(subject==subject1 && subject!=subject2){
                    $(data).each(function(index){
                        for(var i=1;i<=data[index].level;i++){
                            if(i!=Number(level1)) {
                                row += '<option value="' + i + '">' + i + '级</option>';
                            }
                        }
                    })
                }
                else if(subject==subject2 && subject!=subject1){
                    $(data).each(function(index){
                        for(var i=1;i<=data[index].level;i++){
                            if(i!=Number(level2)) {
                                row += '<option value="' + i + '">' + i + '级</option>';
                            }
                        }
                    })
                }
                else if(subject==subject1 && subject==subject2){
                    $(data).each(function(index){
                        for(var i=1;i<=data[index].level;i++){
                            if(i!=Number(level2) && i!=Number(level1)) {
                                row += '<option value="' + i + '">' + i + '级</option>';
                            }
                        }
                    })
                }else {
                    $(data).each(function (index) {
                        for (var i = 1; i <= data[index].level; i++) {
                            row += '<option value="' + i + '">' + i + '级</option>'
                        }
                    })
                }
                $("#level3").html(row);
            }
        })
    }

    function saveMessage(){
        var reportPlace=$("#reportPlace option:selected").val();
        var subPlace=$("#subPlace option:selected").val();
        var name=$("#name").val();
        var sex=$("#sex option:selected").val();
        var birth=$("#birth").val();
        var country=$("#country").val();
        var nation=$("#nation").val();
        var address=$("#address").val();
        var phoneNumber=$("#phoneNumber").val();
        var subject1=$("#subject1 option:selected").val();
        var level1=$("#level1 option:selected").val();
        var subject2=$("#subject2 option:selected").val();
        var level2=$("#level2 option:selected").val();
        var subject3=$("#subject3 option:selected").val();
        var level3=$("#level3 option:selected").val();
        if(reportPlace==''||subPlace==''||subject1==''||level1==''||name==""||birth==""){
            $("#message").html('报名省市，机构名称，名字，生日，科目一，级别一不可为空');
            $('#false').modal('show');
            return 0;
        }
        if(nation==''){
            if(country=="中国") {
                $("#message").html("民族为空");
                $('#false').modal('show');
                return 0;
            }
        }
        var subj1="";
        var subj2="";
        var subj3="";
        for(var i=0;i<subject1.length;i++){
            if(subject1[i]=="￥"){
                for(var j=i+1;j<subject1.length;j++) {
                    subj1 += subject1[j];
                }
                break;
            }
        }
        for(var i=0;i<subject2.length;i++){
            if(subject2[i]=="￥"){
                for(var j=i+1;j<subject2.length;j++) {
                    subj2 += subject2[j];
                }
                break;
            }
        }
        for(var i=0;i<subject3.length;i++){
            if(subject3[i]=="￥"){
                for(var j=i+1;j<subject3.length;j++) {
                    subj3 += subject1[j];
                }
                break;
            }
        }
        searchTime(subj1,level1)
        if(str=="false"){
            document.getElementById("message").innerHTML=subj1+" "+level1+"级考试时间未定";
            $('#false').modal('show');
            return 0;
        }
        if(subject2!='0' && level2!= '0') {
            searchTime(subj2,level2)
            if(str=="false"){
                document.getElementById("message").innerHTML=subj2+" "+level2+"级考试时间未定";
                $('#false').modal('show');
                return 0;
            }
        }
        if(subject3!='0' && level3!= '0') {
            searchTime(subj3,level3)
            if(str=="false"){
                document.getElementById("message").innerHTML=subj3+" "+level3+"级考试时间未定";
                $('#false').modal('show');
                return 0;
            }
        }
        save(reportPlace,subPlace,name,sex,birth,country,nation,address,phoneNumber,subject1,level1);
        realCount++;
        if(subject2!='0' && level2!= '0') {
            save(reportPlace, subPlace, name, sex, birth,  country, nation, address, phoneNumber, subject2, level2);
            realCount++;
        }
        if(subject3!='0' && level3!= '0') {
            save(reportPlace, subPlace, name, sex, birth,  country, nation, address, phoneNumber, subject3, level3);
            realCount++;
        }
        if(count==realCount){
            $("#success").modal('show');
            count=0;
            realCount=0;
        }
    }
    var str="";
    function searchTime(subject,level){
        $.ajax({
            url:"message/searchTime",
            type:"post",
            async:false,
            data:{
                subject:subject,
                level:level
            },
            success: function (data) {
                str=data;
            }
        })
    }
    var count=0;
    var realCount=0;
    function save(reportPlace,subPlace,name,sex,birth,country,nation,address,phoneNumber,subject,level){
        var birth1="";
        for(var i=0;i<birth.length;i++){
            if(birth[i]!="-"){
                birth1+=birth[i];
            }
        }
        $.ajax({
            url:"message/saveMessage",
            type:"post",
            async:false,
            data:{
                reportPlace:reportPlace,
                subPlace:subPlace,
                name:name,
                birth:birth1,
                sex:sex,
                country:country,
                nation:nation,
                address:address,
                phoneNumber:phoneNumber,
                subject:subject,
                level:level
            },
            success: function (data) {
                if(data=='success'){
                    count++;
                }else{
                    $("#message").html("存在重复数据")
                    $("#false").modal('show');
                }
            }
        })
    }
    var subjectList=[];
    var levelList=[];
    var setId=[];
    function reload(){
        location.reload();
    }
    function getSearch(){
        document.getElementById("button").innerHTML = "保存";
        var name=$("#name").val();
        var sex=$("#sex option:selected").val();
        var birth=$("#birth").val();
        var birth1="";
        for(var i=0;i<birth.length;i++){
            if(birth[i]!="-"){
                birth1+=birth[i];
            }
        }
        if(name==""||sex==""||birth==""){
            $("#message").html("检索时名字，生日不可为空")
            $('#false').modal('show');
        }
        else{
            $.ajax({
                url:"message/getSearch",
                dataType:"json",
                type:"post",
                data:{
                    name:name,
                    sex:sex,
                    birth:birth1
                },
                success:function(data){
                    if(data.length==0){
                        $('#fail').modal('show');
                    }
                    for(var i=0;i<data.length;i++){
                        setId.push(data[i].id);
                    }
                    var sex='';
                    var reportPlace=data[0].reportPlace;
                    var subPlace=data[0].subPlace;
                    var rep=JSON.parse('${placeList}');
                    var report='';
                    for(var i=0;i<rep.length;i++){
                        if(rep[i]==reportPlace)
                            report+='<option value="'+rep[i]+'" selected="selected">'+rep[i]+'</option>';
                        else
                            report+='<option value="'+rep[i]+'">'+rep[i]+'</option>';
                    }
                    $("#reportPlace").html(report);
                    var place=$('#reportPlace option:selected').val();
                    $.ajax({
                        url:"message/getSubPlace",
                        type:"post",
                        dataType:"json",
                        data:{
                            place:place,
                        },
                        success:function(data){
                            var row="";
                            $(data).each(function(index){
                                if(subPlace==data[index].subPlace)
                                    row+="<option value='"+data[index].id+'￥'+data[index].subPlace+"' selected='selected' >"+data[index].subPlace+"</option>";
                                else
                                    row+="<option value='"+data[index].id+'￥'+data[index].subPlace+"' >"+data[index].subPlace+"</option>";
                            })
                            $("#subPlace").html(row);
                        }
                    })
                    document.getElementById("name").value=data[0].name;
                    document.getElementById("country").value=data[0].country;
                    document.getElementById("nation").value=data[0].nation;
                    document.getElementById("address").value=data[0].address;
                    document.getElementById("phoneNumber").value=data[0].phoneNumber;
                    document.getElementById("name").value=data[0].name;
                    if(data[0].sex=="男"){
                        sex+='<option value="男" selected="selected">男</option> <option value="女">女</option>';
                    }
                    else
                        sex+='<option value="男" >男</option> <option value="女" selected="selected">女</option>';
                    $("#sex").html(sex);

                    for(var i=0;i<data.length;i++){
                        subjectList.push(data[i].subject);
                        levelList.push(data[i].level);
                    }
                    setSubject();
                    subjectList.length=0;
                    levelList.length=0;
                }
            })
        }
    }
    function setSubject(){
        var subject1='';
        var sub=JSON.parse('${subjectList}');
        for(var j=0;j<subjectList.length;j++) {
            for (var i = 0; i < sub.length; i++) {
                if ((sub[i].id+'￥'+sub[i].subject) == subjectList[j]) {
                    subject1 += '<option value="' +sub[i].id+'￥'+ sub[i].subject + '"selected="selected" >' + sub[i].subject + '</option>';
                }
                else {
                    subject1 += '<option value="' +sub[i].id+'￥'+ sub[i].subject + '" >' + sub[i].subject + '</option>';
                }
            }
            $("#subject"+(Number(j)+1)+"").html(subject1);
            subject1='';
        }
        if(subjectList.length>0){
            var subject=$("#subject1 option:selected").val();
            var subject1="";
            for(var i=0;i<subject.length;i++){
                if(subject[i]=="￥"){
                    for(var j=i+1;j<subject.length;j++) {
                        subject1 += subject[j];
                    }
                    break;
                }
            }
            $.ajax({
                url:"message/getLevel",
                type:"post",
                dataType:"json",
                async:false,
                data:{
                    subject:subject1,
                },
                success:function(data){
                    var row='';
                    $(data).each(function(index){
                        for(var i=1;i<=data[index].level;i++){
                            if(levelList[0]==i)
                                row+='<option value="'+i+'"selected="selected">'+i+'</option>';
                            else
                                row+='<option value="'+i+'">'+i+'</option>';
                        }
                    })
                    $("#level1").html(row);
                }
            })
        }

        if(subjectList.length>1) {
            var subject=$("#subject2 option:selected").val();
            var level1=$("#level1 option:selected").val();
            var subject1=$("#subject1 option:selected").val();
            var subject2="";
            for(var i=0;i<subject.length;i++){
                if(subject[i]=="￥"){
                    for(var j=i+1;j<subject.length;j++) {
                        subject2 += subject[j];
                    }
                    break;
                }
            }
            $.ajax({
                url:"message/getLevel",
                type:"post",
                dataType:"json",
                async:false,
                data:{
                    subject:subject2,
                },
                success:function(data){
                    var row='';
                    if(subject==subject1){
                        $(data).each(function(index){
                            for(var i=1;i<=data[index].level;i++){
                                if(i!=Number(level1)) {
                                    if(levelList[1]==i)
                                        row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                    else
                                        row += '<option value="' + i + '">' + i + '级</option>';
                                }
                            }
                        })
                    }else{
                        $(data).each(function(index){
                                for(var i=1;i<=data[index].level;i++){
                                    if(levelList[1]==i)
                                        row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                    else
                                        row+='<option value="'+i+'">'+i+'级</option>';
                                }
                            }
                        )}
                    $("#level2").html(row);
                }
            })
        }
        if(subjectList.length>2){
            var subject=$("#subject3 option:selected").val();
            var level1=$("#level1 option:selected").val();
            var subject1=$("#subject1 option:selected").val();
            var level2=$("#level2 option:selected").val();
            var subject2=$("#subject2 option:selected").val();
            var subject3="";
            for(var i=0;i<subject.length;i++){
                if(subject[i]=="￥"){
                    for(var j=i+1;j<subject.length;j++) {
                        subject3 += subject[j];
                    }
                    break;
                }
            }
            $.ajax({
                url:"message/getLevel",
                type:"post",
                dataType:"json",
                async:false,
                data:{
                    subject:subject3,
                },
                success:function(data){
                    var row='<option value="0" selected="selected">级别</option>';
                    if(subject==subject1 && subject!=subject2){
                        $(data).each(function(index){
                            for(var i=1;i<=data[index].level;i++){
                                if(i!=Number(level1)) {
                                    if(levelList[2]==i)
                                        row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                    else
                                        row += '<option value="' + i + '">' + i + '级</option>';
                                }
                            }
                        })
                    }
                    else if(subject==subject2 && subject!=subject1){
                        $(data).each(function(index){
                            for(var i=1;i<=data[index].level;i++){
                                if(i!=Number(level2)) {
                                    if(levelList[2]==i)
                                        row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                    else
                                        row += '<option value="' + i + '">' + i + '级</option>';
                                }
                            }
                        })
                    }
                    else if(subject==subject1 && subject==subject2){
                        $(data).each(function(index){
                            for(var i=1;i<=data[index].level;i++){
                                if(i!=Number(level2) && i!=Number(level1)) {
                                    if(levelList[2]==i)
                                        row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                    else
                                        row += '<option value="' + i + '">' + i + '级</option>';
                                }
                            }
                        })
                    }else {
                        $(data).each(function (index) {
                            for (var i = 1; i <= data[index].level; i++) {
                                if(levelList[2]==i)
                                    row+='<option value="'+i+'"selected="selected">'+i+'级</option>';
                                else
                                    row += '<option value="' + i + '">' + i + '级</option>'
                            }
                        })
                    }
                    $("#level3").html(row);
                }
            })
        }

    }
    $("#button").click(function(){
        var Button = document.getElementById("button").innerHTML;
        if(Button=="新增")
            saveMessage();
        else{
            editMessage();
        }
    })
    function editMessage(){
        var reportPlace=$("#reportPlace option:selected").val();
        var subPlace=$("#subPlace option:selected").val();
        var name=$("#name").val();
        var sex=$("#sex option:selected").val();
        var birth=$("#birth").val();
        var country=$("#country").val();
        var nation=$("#nation").val();
        var address=$("#address").val();
        var phoneNumber=$("#phoneNumber").val();
        var subject1=$("#subject1 option:selected").val();
        var level1=$("#level1 option:selected").val();
        var subject2=$("#subject2 option:selected").val();
        var level2=$("#level2 option:selected").val();
        var subject3=$("#subject3 option:selected").val();
        var level3=$("#level3 option:selected").val();
        if(reportPlace==''||subPlace==''||subject1==''||level1==''||name==""||birth==""){
            $("#message").html('报名省市，机构名称，名字，生日，科目一，级别一不可为空');
            $('#false').modal('show');
            return 0;
        }
        if(nation==''){
            if(country=="中国") {
                document.getElementById("message").innerHTML = "民族为空";
                $('#false').modal('show');
                return 0;
            }
        }
        var subj1="";
        var subj2="";
        var subj3="";
        for(var i=0;i<subject1.length;i++){
            if(subject1[i]=="￥"){
                for(var j=i+1;j<subject1.length;j++) {
                    subj1 += subject1[j];
                }
                break;
            }
        }
        for(var i=0;i<subject2.length;i++){
            if(subject2[i]=="￥"){
                for(var j=i+1;j<subject2.length;j++) {
                    subj2 += subject2[j];
                }
                break;
            }
        }
        for(var i=0;i<subject3.length;i++){
            if(subject3[i]=="￥"){
                for(var j=i+1;j<subject3.length;j++) {
                    subj3 += subject1[j];
                }
                break;
            }
        }
        searchTime(subj1,level1)
        if(str=="false"){
            document.getElementById("message").innerHTML=subj1+" "+level1+"级考试时间未定";
            $('#false').modal('show');
            return 0;
        }
        if(subject2!='0' && level2!= '0') {
            searchTime(subj2,level2)
            if(str=="false"){
                document.getElementById("message").innerHTML=subj2+" "+level2+"级考试时间未定";
                $('#false').modal('show');
                return 0;
            }
        }
        if(subject3!='0' && level3!= '0') {
            searchTime(subj3,level3)
            if(str=="false"){
                document.getElementById("message").innerHTML=subj3+" "+level3+"级考试时间未定";
                $('#false').modal('show');
                return 0;
            }
        }
        edit(setId[0],reportPlace,subPlace,name,sex,birth,country,nation,address,phoneNumber,subject1,level1);
        realCount++;
        if(subject2!='0' && level2!= '0') {
            if(setId.length>1)
                edit(setId[1],reportPlace, subPlace, name, sex, birth,  country, nation, address,  phoneNumber, subject2, level2);
            else
                save(reportPlace, subPlace, name, sex, birth,  country, nation, address,  phoneNumber, subject2, level2);
            realCount++;
        }
        if(subject3!='0' && level3!= '0') {
            if(setId.length>2)
                edit(setId[2],reportPlace, subPlace, name, sex, birth,  country, nation, address,  phoneNumber, subject3, level3);
            else
                save(reportPlace, subPlace, name, sex, birth,  country, nation, address,  phoneNumber, subject3, level3);
            realCount++;
        }
        if(count==realCount){
            $("#success").modal('show');
            count=0;
            realCount=0;
        }
    }
    var count=0;
    var realCount=0;
    function edit(id,reportPlace,subPlace,name,sex,birth,country,nation,address,phoneNumber,subject,level){
        var birth1="";
        for(var i=0;i<birth.length;i++){
            if(birth[i]!="-"){
                birth1+=birth[i];
            }
        }
        $.ajax({
            url:"message/editMessage",
            type:"post",
            async:false,
            data:{
                id:id,
                reportPlace:reportPlace,
                subPlace:subPlace,
                name:name,
                birth:birth1,
                sex:sex,
                country:country,
                nation:nation,
                address:address,
                phoneNumber:phoneNumber,
                subject:subject,
                level:level
            },
            success: function (data) {
                if(data=='success'){
                    count++;
                }
                else{
                    $("#message").html("对应级别的科目未设置考试持续时间")
                    $("#false").modal('show');
                }
            }
        })
    }
</script>
</body>
</html>
