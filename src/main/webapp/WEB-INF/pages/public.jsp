<%--
  Created by IntelliJ IDEA.
  User: gray shi
  Date: 2017/8/26
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String power= (String) session.getAttribute("power");
    String username = (String) session.getAttribute("username");
%>
<nav class="navbar navbar-default navbar-static-top navbar-fixed-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index">上海市美术考级管理系统</a>
    </div>
    <!-- /.navbar-header -->

    <ul class="nav navbar-top-links navbar-right">
        <!-- /.dropdown -->
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-user fa-fw"></i><%=username %> <i class="fa fa-caret-down"></i>
            </a>
            <ul class="dropdown-menu dropdown-message">
                <li><a href="#"><i class="fa fa-gear fa-fw"></i> 修改密码</a>
                </li>
                <li class="divider"></li>
                <li><a href="/login"><i class="fa fa-sign-out fa-fw"></i>注销</a>
                </li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
    </ul>
    <!-- /.navbar-top-links -->

    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
                <li>
                    <a href="index"><i class="fa fa-dashboard fa-fw"></i>首页</a>
                </li>
                <% if(power.equals("admin")){%>
                    <li>
                        <a href="javascript:void(0)"><i class="fa fa-bar-chart-o fa-fw"></i> 考试管理 <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                                <li><a href="subject">考试科目管理</a></li>

                            <li><a href="place">报考地点管理</a></li>
                            <li><a href="place1">考试地点管理</a></li>
                            <li><a href="examTime">考试持续时间管理</a></li>
                            <li><a href="time">考试时间管理</a></li>
                            <li><a href="cost">收费信息管理</a></li>
                        </ul>
                    </li>
                <% }%>
                <li>
                    <a href="javascript:void(0)"><i class="fa fa-bar-chart-o fa-fw"></i> 数据录入 <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <% if(power.equals("admin")){%>
                            <li><a href="message">手动录入报考信息</a></li>
                        <% }%>
                        <li><a href="message1">excel录入报考信息</a></li>
                        <li><a href="delete">管理信息</a></li>
                    </ul>
                </li>
                <% if(power.equals("admin")){%>
                    <li>
                        <a href="javascript:void(0)"><i class="fa fa-bar-chart-o fa-fw"></i> 数据分析 <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li><a href="data">图表统计</a></li>
                            <li><a href="cost1">收费情况</a></li>
                        </ul>
                    </li>
                <% } %>
                <li>
                    <a  href="javascript:void(0)"><i class="fa fa-bar-chart-o fa-fw"></i> 考场安排 <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a href="examination">整体考场分配</a></li>
                        <li><a href="forPerson">单人考场分配</a></li>
                        <li><a href="print">打印准考证</a></li>
                    </ul>
                </li>
                <% if(power.equals("admin")){%>
                <li>
                    <a href="javascript:void(0)"><i class="fa fa-bar-chart-o fa-fw"></i> 用户管理<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a href="user">用户信息</a></li>
                    </ul>
                </li>
                <% } %>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
    <div class="navbar-fixed-bottom navbar-default" style="text-align: right">
        Copyright © 2018 -2020. All rights reserved.
    </div>
</nav>
<div id="wrap">
    <button type="button" class="btn btn-default btn-circle btn-lg" id="btn_top"><i class="fa fa-arrow-up"></i>
    </button>
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
    $("#btn_top").hide();         //刚进入页面时设置为隐藏
    $("#btn_top").bind("click",function(){     //单击时返回顶部
        $('html, body').animate({scrollTop: 0},300);return false;
    });
    $(window).bind('scroll resize',function(){   //判断页面所在的位置，小于300就隐藏，否则就显示
        if($(window).scrollTop()<=300){
            $("#btn_top").hide();
        }else{
            $("#btn_top").show();
        }
    });
</script>
<style>
    @media (min-width: 768px) {
        #wrap {
            display: block;
            bottom: 21px;
            right: 1px !important;
            width: 200px;
            line-height: 30px;
            position: fixed;
            text-align: right;
        }
    }
    @media (max-width: 768px) {
        #wrap {
            display: none;
        }
    }
</style>
