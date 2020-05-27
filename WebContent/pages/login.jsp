<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>登录页面</title>
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet">
   <style type="text/css">
   	.red{color:red}
   	.green{color:green}
   </style>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
   <script>	
   	var flag=false;
	 $(document).ready(function(){
		$("#inputCode").blur(function (){	
		var vCode=$("#inputCode").val();
	 	 if(!!vCode){
	 	 	$.ajax({  
                type:"POST", //请求方式 
                url:"${pageContext.request.contextPath}/user/validCode.action",
                dataType:"json", //返回数据类型
                data:{//请求参数
               		vCode:vCode
                },
                success:function(data){ //请求成功后
                	if(data.msg=='1'){
                      	flag=true;
                   	 	//alert("验证码正确！");
                   	 	$("#error_html").removeClass("red").html("");
                   	 	$("#error_html").addClass("green").html("验证码正确!");
                    }else{
                     	//alert("验证码不正确！");
                     	$("#error_html").addClass("red").html("验证码不正确!");
                     	flag=false;
                    }
                },
                error:function (){
                	alert("系统出现异常！");
                }    
	         }); 
         }else{
           flag=false;
           $("#error_html").addClass("red").html("验证码不能为空")
         }
		});
	});
	//回车登录
	$(function(){
		// jQuery
		$("body").keydown(function(ev){
			//console.log("回车登录" + ev.keyCode );
			if(ev.keyCode==13){
				login();	
			}else{
				$("#userNameError").removeClass("red").html("");
				$("#passwordError").removeClass("red").html("");
				$("#error_html").removeClass("red").html("");
			}
		});
	});
	//cookie
	$(document).ready(function(){
		if($.cookie("remMe")){
			$("#inputEmail").val($.cookie("userCode"));
			$("#inputPassword").val($.cookie("userPsw"));
			$("input[name='rememberMe']").prop("checked",true);
		}
	});
	function login(){
		var userCode=$("#inputEmail").val();//获取用户名
		var userPsw=$("#inputPassword").val();
		var vCode=$("#inputCode").val();
		
		if(!/^\w{4,16}$/.test(userCode)){
			//alert("用户名不合法! 4-16位，字母，数字，下划线");
			$("#userNameError").addClass("red").text("用户名不合法! 4-16位，字母，数字，下划线");
			return false;
		}else if(!/^\w{6,16}$/.test(userPsw)){
			$("#passwordError").addClass("red").text("密码不合法! 6-16位，字母，数字，下划线");
			return false;
		}else if(null==vCode || vCode==""){
			$("#error_html").addClass("red").html("验证码不能为空！");
			return false;
		}else{
			$.ajax({  
                type:"POST",  
                url:"${pageContext.request.contextPath}/user/login.action",
                dataType:"json",  
                data:{
                	vCode:vCode,
               		userPwd:userPsw,
                	userCode:userCode
                },  
                success:function(data){
//                	console.log("&&&&&&***************"+data.res);
                  if( data.res=="1"){
	                  //登录成功
	                  var chc=$("input[name='rememberMe']").prop("checked"); 
	                  console.log("####"+!chc);
	                  //判断checkbox是否被选中
	                  if(!!chc){
	                    $.cookie("userCode", userCode,{expires:30});
	                   	$.cookie("userPsw", userPsw,{expires:30});
	                   	$.cookie("remMe","true",{expires:30});
	                  }else{
	                  	//清空
	                  	$("input[name='rememberMe']:checkbox").attr("checked",false);
	                	$.cookie("remMe",null);
	                  	$.cookie("userCode",null);
	                    $.cookie("userPsw", null);
	                   } 
                 	  window.location.href="${pageContext.request.contextPath}/user/index.action";
                  }else if(data.res=="0"){
                	  $("#error_html").addClass("red").html("验证码不正确!");
                  	return false;
                  }else if(data.res=="3"){
                	  alert("账号未审核!");
                  	return false;
                  }else if(data.res=="2"){
                	  alert("账号或密码错误!");
                  	return false;
                  }else{
                  	alert("登录失败");
                  	return false;
                  }
                },
                error:function (){
                   alert("系统错误！");
                }   
        	});
		}
	}
</script>
		<%-- <%
			Cookie[] cooks=request.getCookies();
	     	String username="";
	     	String password="";
	     	if(null!=cooks){
	     		for(Cookie cook:cooks){
	     			if(cook.getName().equals("UTNAME")){
	     				username=URLDecoder.decode(cook.getValue(), "UTF-8");
	     			}
	     			if(cook.getName().equals("UTPASS")){
	     				password=cook.getValue();
	     			}
	     		}
	     	}
	     %> --%>
  </head>
  <body>
    	<form class="form-signin" method="post">
			<h3 class="form-signin-heading">请登录</h3>
			<label for="inputEmail" class="sr-only">用户名</label>
			<input type="text" id="inputEmail" class="form-control class123456" placeholder="请输入用户名！"  name="userCode" maxlength="16">
			<label id="userNameError"></label><br/>
			<label for="inputPassword" class="sr-only">密码</label>
			<input type="password"  id="inputPassword" class="form-control" placeholder="请输入密码!" name="userPsw" maxlength="10">
		   	<label id="passwordError"></label><br/>
			<label for="inputEmail" class="sr-only" >验证码</label>
			<input type="text" id="inputCode" placeholder="验证码" name="code" tabindex="6" style="width:80px;text-transform:uppercase;ime-mode:disabled" maxlength="4">
			<img id="vdimgck"  src="${pageContext.request.contextPath}/pages/image.jsp?d=" alt="看不清？点击更换"  width="75" style="cursor:pointer" onclick="this.src=this.src+'?'" />
			<label id="error_html" style="font-size:18px;"></label>
		   <div class="checkbox" id="checkboxid">
			  <label>
				<input type="checkbox" name="rememberMe" id="remMe"> 记住我&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </label>
			</div>
			<p class="bg-warning">${error}</p>
			<input class="btn btn-lg btn-primary btn-block" type="button" onclick="return login()" value="登录" />
     </form>
	</body>
</html>
