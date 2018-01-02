<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/9/3
  Time: 22:56
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
                <h1 class="page-header">收费信息</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 search-row">
                <%--<div class="col-lg-3">--%>
                    <%--<span>级别</span>--%>
                    <%--<select id="level" class="form-control">--%>
                        <%--<option value="0" selected="selected">报考级别</option>--%>
                        <%--<c:forEach items="${levelList1}" var="item">--%>
                            <%--<option value="${item}">${item}级</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <div class="col-lg-3">
                    <span>报名省市</span>
                    <select id="reportPlace" onchange="javaScript:setSubPlace()" class="form-control">
                        <option value="0" selected="selected">报名省市</option>
                        <c:forEach items="${reportPlaceList}" var="item">
                            <option value="${item}" >${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3" >
                    <span>机构名称</span>
                    <select id="subPlace" class="form-control">
                        <option value="0" selected="selected">机构名称</option>
                    </select>
                </div>
                    <div class="col-lg-3">
                        <span> 报名截止日期</span>
                        <select id="endSignUpTime"class="form-control" >
                            <option value="0" selected="selected">报名截止日期</option>
                            <c:forEach items="${endTimeList}" var="item">
                                <option value="${item}">${item}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-1">
                        <span>操作</span>
                        <button class="btn btn-primary form-control" type="button" onclick="getSearch()">查看</button>
                    </div>
            </div>
            <div class="col-lg-12 text-center">
                <h2 class="page-header">收费情况</h2>
            </div>

        </div>

        <div class="row">
            <div class="col-lg-12 text-center">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>考点编号</th>
                        <th>报名省市 机构名称</th>
                        <th>考试时间</th>
                        <th>报考人数</th>
                        <th>报名费</th>
                        <th>考务费</th>
                        <th>证书费</th>
                        <th>合计</th>
                    </tr>
                    </thead>
                    <tbody id="costTable">
                    <%--<c:forEach items="${totalCostList}" var="item">--%>
                        <%--<tr>--%>
                            <%--<td>${item.subID}</td>--%>
                            <%--<td><a href='javascript:void(0)' onclick='searchPlace("${item.subID}")'>${item.reportPlace}  ${item.subPlace}</a></td>--%>
                            <%--<td>${item.startTime}</td>--%>
                            <%--<td>${item.count}</td>--%>
                            <%--<td>${item.baomingfei}</td>--%>
                            <%--<td>${item.kaowufei}</td>--%>
                            <%--<td>${item.zhengshufei}</td>--%>
                            <%--<td>${item.remark}</td>--%>
                        <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--<tr>--%>
                        <%--<td colspan="3" style="text-align:center">合&nbsp;&nbsp;&nbsp;&nbsp;计</td>--%>
                        <%--<td>${totalCost.count}</td>--%>
                        <%--<td>${totalCost.baomingfei}</td>--%>
                        <%--<td>${totalCost.kaowufei}</td>--%>
                        <%--<td>${totalCost.zhengshufei}</td>--%>
                        <%--<td>${totalCost.remark}</td>--%>
                    <%--</tr>--%>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script>
    function setSubPlace(){
        var reportPlace = $("#reportPlace option:selected").val();
        if(reportPlace!='0'){
            $.ajax({
                url:"data-setSubPlace",
                type:"post",
                dataType:"json",
                data:{
                    reportPlace:reportPlace
                },
                success: function(data){
                    var str="<option value='0' selected='selected'>机构名称</option>";
                    $(data).each(function(index){
                        var subPlace1="";
                        var subPlace=data[index];
                        for(var i=0;i<subPlace.length;i++){
                            if(subPlace[i]=="￥"){
                                for(var j=i+1;j<subPlace.length;j++) {
                                    subPlace1 += subPlace[j];
                                }
                                break;
                            }
                        }
                        str+=" <option value='"+data[index]+"'>"+subPlace1+"</option>"
                    })
                    $("#subPlace").html(str);
                }
            })
        }
        else{
            var str="<option value='0' selected='selected'>机构名称</option>";
            $("#subPlace").html(str);
        }
    }
    function getSearch(){
        var reportPlace = $("#reportPlace option:selected").val();
        var subPlace = $("#subPlace option:selected").val();
        var endSignUpTime = $("#endSignUpTime option:selected").val();
        $.ajax({
            url:"cost1-getSearch",
            type:"post",
            dataType:"json",
            data:{
                reportPlace:reportPlace,
                subPlace:subPlace,
                endSignUpTime:endSignUpTime
            },
            success:function(data){
                var str="";
                for(var i=0;i<data.length-1;i++){
                    str+="<tr> <td>"+data[i].subID+"</td>" +
                        "<td><a href='#' onclick='searchPlace(\""+data[i].subID+"\")'>"+data[i].reportPlace+" "+data[i].subPlace+"</a></td> " +
                        "<td>"+data[i].startTime+"</td>" +
                        "<td>"+data[i].count+"</td>" +
                        " <td>"+data[i].baomingfei+"</td> " +
                        "<td>"+data[i].kaowufei+"</td> " +
                        "<td>"+data[i].zhengshufei+"</td> " +
                        "<td>"+data[i].remark+"</td> </tr>";
                }
                str+="<tr> <td colspan='3' style='text-align:center'>合&nbsp;&nbsp;&nbsp;&nbsp;计</td>" +
                    "<td>"+data[data.length-1].count+"</td>" +
                    " <td>"+data[data.length-1].baomingfei+"</td> " +
                    "<td>"+data[data.length-1].kaowufei+"</td> " +
                    "<td>"+data[data.length-1].zhengshufei+"</td> " +
                    "<td>"+data[data.length-1].remark+"</td> </tr>";
                $("#costTable").html(str);
            }
        })
    }
    function searchPlace(subID) {
        window.location="cost1-detail?subID="+subID;
    }


</script>
</body>
</html>
