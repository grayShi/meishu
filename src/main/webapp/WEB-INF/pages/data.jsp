<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/9/3
  Time: 22:23
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
                <h1 class="page-header">图表统计</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12 search-row">
                <div class="col-lg-3">
                    <span>报考科目</span>
                    <select  id="subject" onchange="javaScript:setLevel()" class="form-control">
                        <option value="0" selected="selected">报考科目</option>
                        <c:forEach items="${subjectList}" var="item">
                            <option value=${item.id}￥${item.subject}>${item.subject}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span>报考级别</span>
                    <select id="level"class="form-control" >
                        <option value="0" selected="selected">报考级别</option>
                        <c:forEach items="${levelList}" var="item">
                            <option value="${item}">${item}级</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span>报名省市</span>
                    <select id="reportPlace" onchange="javaScript:setSubPlace()" class="form-control">
                        <option value="0" selected="selected">报名省市</option>
                        <c:forEach items="${reportPlaceList}" var="item">
                            <option value="${item}" >${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span>机构名称</span>
                    <select id="subPlace"class="form-control">
                        <option value="0" selected="selected">机构名称</option>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span>考试年份</span>
                    <select id="year"class="form-control">
                        <option value="0" selected="selected">考试年份</option>
                        <c:forEach items="${yearList}" var="item">
                            <option value="${item}" >${item}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3">
                    <span>统计方式</span>
                    <select id="getSearch" class="form-control">
                        <option value="0" selected="selected">统计条件</option>
                        <option value="level">报考级别</option>
                        <option value="sex">性别</option>
                        <option value="subject">报考科目</option>
                        <option value="year">考试时间</option>
                    </select>
                </div>
                <div class="col-lg-1">
                    <span>操作</span>
                    <button class="btn btn-primary form-control" type="button" onclick="getSearch()">统计</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2 class="page-header">报表管理</h2>
            </div>
            <div class="col-lg-12 text-center" id="table"  align="center" style="border:1px solid darkgray;margin: 0 0 0 0;">

            </div>
        </div>
    </div>
    <div class="modal fade" id="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">检索失败</h4>
                </div>
                <div class="modal-body text-center">
                    <p id="message">未选择检索条件</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
</div>


<script type="text/javascript" src="js/highcharts.js"></script>
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
    function getSearch(){
        var search= $("#getSearch option:selected ").val();
        if(search==0){
            $("#message").html("未选择检索条件")
            $("#false").modal('show');
        }
        else {
            showHighCharts(search);
        }
    }
    var chart;
    function showHighCharts(search) {
        var options= {
            chart: {
                renderTo: 'table',//对应div的id
                defaultSeriesType: 'column'//默认为柱状图
                //		type: 'column'
            },
            title: {
                //text:     //设置标题栏名称
                style: {
                    margin: '10px 10px 0 0', // center it
                    font: 'normal 25px Verdana, sans-serif'//设置标题字体的样式
                }
            },
            xAxis: {
                categories: [ //设置X轴坐标值

                ],
                labels: {//X轴坐标值样式
                    //					rotation: -45,
                    //					align: 'right',
                    style: {
                        font: 'normal 14px Verdana, sans-serif'
                        //					 color: 'white'
                    },
                    // 标签旋转度数
                    rotation: 20,
// 标签交错显示的行数
                    staggerLines: 1
                },
// X轴的步进值，决定隔多少个显示一个
                tickInterval: 1,
// 坐标轴标题
                title: {

                }
            },


            yAxis: {
                tickInterval: 5,	//自定义刻度
                //max: 100,           //Y轴最大值
                title: {
                    text: '人数',
                    //				tickPixelInterval:10,
                    margin: 50
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            plotOptions: {
                column: {
                    dataLabels: {
                        enabled: true,
                        color: '#808080',
                        formatter: function() {
                            if(this.point.y==0)
                                return '';
                            else
                                return this.point.y;  // 重新设置节点显示数据
                        },
                    }
                }
            },        /////柱状图上方柱状标识
            /* legend: {
             layout: 'vertical',
             backgroundColor: '#6E6E6E',
             align: 'right',
             style: {
             left: 'auto',
             right:'5px',
             top: '180px',
             bottom: 'auto'
             }
             }, */
            tooltip: {//鼠标放在图形上时的提示信息
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y;
                }
            }
        };

        //下面的代码主要是为了构造形如以下的数据:
        /* [{
         name: 'BF',
         data: [150, 270, 120, 230, 300, 220, 250, 120, 100, 200, 90, 60]
         }, {
         name: 'LF',
         data: [230, 160, 150, 100, 290, 300, 200, 160, 500, 100, 86, 25]
         }, {
         name: 'TJ',
         data: [60, 90, 100, 200, 330, 120, 120, 300, 80, 200, 39, 10]
         }] */
//        options.series = [];
//        // data它是从数据库中查出来的值的列表, 是一个list
//        for(var i=0; i<data.length; i++){
//            options.series[i] = {
//                name: data[i].WEEK,
//                //         type: 'column',
        //colorByPoint: true, //为每个柱子显示不同颜色
//                data: [parseFloat(data[i].RL_30),parseFloat(data[i].RL_60),
//                    parseFloat(data[i].RL_120),parseFloat(data[i].RM_120)]
//            };
//
//        }
        var Subject = $("#subject option:selected").val();
        var Level = $("#level option:selected").val();
        var ReportPlace = $("#reportPlace option:selected").val();
        var SubPlace = $("#subPlace option:selected").val();
        var year = $("#year option:selected").val();
        if(search=="level") {
            $.ajax({
                url:"data-getLevel",
                type:"post",
                dataType:"json",
                async:false,
                data:{
                    Subject:Subject,
                    Level:Level,
                    ReportPlace:ReportPlace,
                    SubPlace:SubPlace,
                    year:year
                },
                success:function(data){
                    options.title.text = "考生报考级别情况柱状图";
                    options.xAxis.title.text = "级别";
                    options.xAxis.categories = ['1级', '2级', '3级', '4级', '5级', '6级', '7级', '8级', '9级', '10级'];
                    options.series =[];
                    if(data.length==0)
                        options.series[0] = {
                            name: '',
                            //type: 'column',
                            colorByPoint: true, //为每个柱子显示不同颜色
                            data: [0,0,0,0,0,0,0,0,0,0]
                        };
                    else {
                        for (var i = 0; i < data.length; i++) {
                            options.series[i] = {
                                name: data[i].subject,
                                //type: 'column',
                                colorByPoint: true, //为每个柱子显示不同颜色
                                data: [data[i].levelCount1, data[i].levelCount2, data[i].levelCount3, data[i].levelCount4, data[i].levelCount5, data[i].levelCount6,
                                    data[i].levelCount7, data[i].levelCount8, data[i].levelCount9, data[i].levelCount10]
                            };
                        }
                    }
                }
            })


        }
        else if(search=="subject"){
            $.ajax({
                url: "data-getSubject",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    Subject: Subject,
                    Level: Level,
                    ReportPlace: ReportPlace,
                    SubPlace: SubPlace,
                    year:year
                },
                success: function (data) {
                    options.title.text = "考生报考科目情况柱状图";
                    options.xAxis.title.text = "科目";
                    options.series =[];
                    var xTitle=[];
                    var xData=[];
                    $(data).each(function(index){
                        xTitle.push(data[index].subject);
                        xData.push(data[index].levelCount1);    //科目人数
                    });
                    options.xAxis.categories = xTitle;
                    options.series[0] = {
                        name: '报考科目',
                        //type: 'column',
                        colorByPoint: true, //为每个柱子显示不同颜色
                        data: xData
                    };
                }
            })
        }
        else if(search=="sex") {
            $.ajax({
                url: "data-getSex",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    Subject: Subject,
                    Level: Level,
                    ReportPlace: ReportPlace,
                    SubPlace: SubPlace,
                    year:year
                },
                success: function (data) {
                    options.title.text = "考生报考性别情况柱状图";
                    options.xAxis.title.text = "性别";
                    options.series = [];
                    var xTitle=[];
                    var xData=[];
                    $(data).each(function(index){
                        xTitle.push(data[index].subject);       //性别
                        xData.push(data[index].levelCount1);    //性别人数
                    });
                    options.xAxis.categories = xTitle;
                    options.series[0] = {
                        name: '性别',
                        //type: 'column',
                        colorByPoint: true, //为每个柱子显示不同颜色
                        data: xData
                    };
                }
            })
        }
        else if(search=="year") {
            if(year == "0"){
                $("#message").html("未选择考试时间")
                $("#false").modal('show');
                return 0;
            }else{
                $.ajax({
                    url: "data-getYear",
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: {
                        Subject: Subject,
                        Level: Level,
                        ReportPlace: ReportPlace,
                        SubPlace: SubPlace,
                        year:year
                    },
                    success: function (data) {
                        options.title.text = "考生"+year+"报考情况柱状图";
                        options.xAxis.title.text = "月份";
                        options.series = [];
                        var xTitle=[];
                        var xData=[];
                        $(data).each(function(index){
                            xTitle.push(data[index].subject);
                            xData.push(data[index].levelCount1);
                        });
                        options.xAxis.categories = xTitle;
                        options.series[0] = {
                            name: '月份',
                            //type: 'column',
                            colorByPoint: true, //为每个柱子显示不同颜色
                            data: xData
                        };
                    }
                })
            }
        }
        chart = new Highcharts.Chart(options);
    }





</script>
</body>
</html>
