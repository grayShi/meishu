<%--
  Created by IntelliJ IDEA.
  User: 石高磊
  Date: 2017/12/2
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js" lang="zh-Hans">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.5">
    <title>上海市美术考级管理系统</title>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
    <link rel="stylesheet" href="vendor/css/ani.css">
    <link rel="stylesheet" href="vendor/css/style2.css">
    <link rel="bookmark" type="image/x-icon" href="images/logo.png"/>
    <link rel="shortcut icon" href="images/logo.png">
    <link rel="icon" href="images/logo.png">
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet" />
</head>
<body>
<div class="headline-bg index-headline-bg wavesWapper" style="z-index:-1;">
    <canvas id="waves" class="waves"></canvas>
</div>
<div class="container">
    <div class="box">
        <div class="image" style="width:70%">
            <%--<img src="images/logo.png" class="pic-1">--%>
            <img src="images/word.png" class="pic-2">
        </div>
        <div class="panel">
                <div class="panel-heading">
                    <h1 class="panel-title" style="color: black;font-size: 30px;font-weight: normal">
                        登陆
                    </h1>
                </div>
            <div class="panel-body">
                <div class="form-group">
                    <span class="icon"><i class="fa fa-user" style="margin-top: 50%;margin-left: -25%"></i></span>
                    <input  type="text" class="form-control" id="username" placeholder="用户名">
                </div>
                <div class="form-group">
                    <span class="icon"><i class="fa fa-lock" style="margin-top: 50%;margin-left: -25%"></i></span>
                    <input  type="password" class="form-control" id="password" placeholder="密码">
                    <span id="logMessage"></span>
                </div>
                <button class="btn btn-warning " name="b1" id="b1" onclick="login()">登陆</button>
            </div>
        </div>
    </div>
</div>
<script src="js/vendors.js"></script>
<script src="js/login.js"></script>
<script src="js/jquery-md5.js"></script>
<script>
    document.onkeydown=function(){
        if (event.keyCode == 13){
            login();
        }
    }

    function login(){
        $('#logMessage').html("");
        var username = $("#username").val();
        var password = $("#password").val();
        if(username == "" || password ==""){
            $('#logMessage').html("输入为空");
            return false;
        }
        $.ajax({
            url:"login-check",
            data:{
                username:username,
                password:$.md5($.md5(password)),
            },
            type:"post",
            async:false,
            success:function(data){
                if(data == "success"){
                    location.href="index";
                }else if(data == "pwd_error"){
                    $('#logMessage').html("密码错误");
                }else if(data == "usr_error"){
                    $('#logMessage').html("用户不存在");
                }
            }
        })
    }
</script>
</body>
</html>

