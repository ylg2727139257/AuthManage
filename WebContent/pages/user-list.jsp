<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>用户管理 - 用户列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
    <style>
    	table{text-align:center;vertical-align:text-bottom;font-size:16px;font-weight: bold;font-family: "黑体"}
    	#tit{font-size:18px;}
    	#userCode{display: inline-block;margin-left:40%;width:15%;height:1%;}
    	.caozuo{text-align:left;}
    	button{font-size:18px;font-weight:bold;font-family: "黑体";}
    	.red{color:red;}
    	.green{color:green;}
    	.date{margin-left:15%;}
    </style>
  </head>
  <body>
  ${USER==null?"<script>alert('亲 ， 还 未 登 录 哦 !');location.href='../pages/login.jsp';</script>":"" }
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">用户列表</h1>
          <div class="row placeholders">
          <div id="tit">
<!--  导出数据 -->
   <button type="button" class="btn btn-warning" id="export-data" data-toggle="modal" data-target="#export-user-data">导出数据</button>
   <div class="modal fade " id="export-user-data" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="role-form-title">导出数据</h4>
			</div>
			<div class="modal-body">
	<button type="button" style="width:150px;" class="btn btn-primary date" id="curr-data" data-dismiss="modal">导出本页数据</button>
	<button type="button" style="width:150px;" class="btn btn-primary date" id="all-data" data-dismiss="modal">导出所有数据</button>
</div></div></div></div>
<!--添加用户-->
  <button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">添加用户</button>
     <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
       <div class="modal-dialog modal-sm" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title" >添 加 用 户</h4>
           </div>
           <div class="modal-body">
           	<form class="user-form" >
               <div class="form-group">
                 <label for="userCodeInput">用户名</label>
                 <input type="text" name="userCode" class="form-control" id="addUserCode" placeholder="用户名">
               	<label id="addUserCodeError" class="red"></label><br/>
               </div>
               <div class="form-group">
                 <label for="passwordInput">部门</label>
                  <select name="groupId" id="addGroupId">
				 	<option value="" style="display:none;">部门</option>
				 	<c:forEach items="${USERGROUPS }" var="group">
				 		<option value="${group.groupId }" >${group.groupName }</option>
				 	</c:forEach>
				 </select>
				 <label id="addGroupIdError" class="red"></label><br/>
               </div>
               <div class="form-group">
                 <label for="passwordInput">密码</label>
                 <input type="password" name="userPwd" class="form-control" id="addUserPwd" placeholder="密码">
               	<label id="addUserPwdError" class="red"></label><br/>
               </div>
               <div class="form-group">
                 <label for="passwordInput">确认密码</label>
                 <input type="password" name="password" class="form-control" id="addPassword" placeholder="密码">
               	<label id="addPasswordError" class="red"></label><br/>
               </div>
              </form>
           </div>
           <div class="modal-footer">
             <input type="reset" class="btn btn-default" id="cancel" data-dismiss="modal" value="取消"/>
             <button type="button" class="btn btn-primary add-user-submit">添加 </button>
           </div>
         </div>
       </div>
     </div>
 <!-- 搜索 -->     
 <input type="text"  id="userCode" name="userCode"  placeholder="用户名" value="${USERCODE }">
 <select name="userType" id="userType">
 	<option value="" ${empty USERTYPE?"selected":"" } style="display:none;">用户类型</option>
 	<c:forEach items="${ROLES }" var="type">
 		<option value="${type.roleId }" ${USERTYPE eq type.roleId?"selected":"" }>${type.roleName }</option>
 	</c:forEach>
 	<option value="" >全 部</option>
 </select>
 <select name="userState" id="userState">
 	<option value="" ${empty USERSTATE?"selected":"" } style="display:none;">用户状态</option>
 	<option value="1" ${USERSTATE eq "1" ? "selected":"" }>启  用</option>
 	<option value="0" ${(not empty USERSTATE and USERSTATE eq "0") ?"selected":"" }>禁  用</option>
 	<option value="" >全  部</option>
 </select>
<button type="button" class="btn btn-warning" id="findUser"> 搜 索 </button>
 </div>
 <div class="space-div"></div>
<!-- 用户信息 -->
 <table class="table table-hover table-bordered user-list">
 	<tr>
         <td>编号</td>
         <td>用  户  名</td>
         <td>部  门</td>
         <td>用 户 类 型</td>
         <td>用户状态</td>
         <td>创  建  时  间</td>
         <td>操&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作</td>
     </tr>
     <c:forEach items="${page.resultList }" var="user">
     	<tr>
     		<td class="userId">${user.userId }</td>
     		<td class="userCode">${user.userCode }</td>
     		<td class="groupId">${user.userGroup.groupName }</td>
     		<td class="userType">${user.role.roleName }</td>
     		<td class="userState">${user.userState==1?"<font color='green'>启  用</font>":"<font color='red'>禁  用</font>" }</td>
     		<td><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
          <td class="caozuo">
          	<a class="glyphicon glyphicon-wrench show-userrole-form" aria-hidden="true" title="修改用户" href="javascript:void(0);" data-toggle="modal" data-target="#update-userrole-dialog"></a>
          	<a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);"></a>
          	<button type="button" class="btn btn-warning asAble" >${user.userState==0 ? "启 用" : "禁 用" }</button>
          	<c:if test="${user.userState==1 }">
	           	<button type="button" class="btn btn-primary reset-password">重置密码</button>
	           	<button type="button" class="btn btn-primary assign-roles" data-toggle="modal" data-target="#assign-roles">分配角色</button>
	           	<button type="button" class="btn btn-primary update-user-auth" >更改权限</button>
          	</c:if>
          </td>
     	</tr>
     </c:forEach>
 </table>
   <jsp:include page="standard.jsp"/>
<!--修改用户-->
        <div class="modal fade " id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改用户</h4>
              </div>
              <div class="modal-body">
              <form class="update-userrole-form" action="${pageContext.request.contextPath}/user/updateUser.action?pageNum=${page.pageNum}&pageSize=${page.pageSize}" method="post">
               <div class="form-group" style="display:none;">
                 <label for="userIdInput">编号</label>
                 <input type="text" name="userId1" style="color:red;text-align:center;font-size:20px;" class="form-control" id="updateUserId" readonly/>
               </div>
               <div class="form-group">
                 <label for="userCodeInput">用户名<font color="red">(不可修改)</font></label>
                 <input type="text" style="color:red;text-align:center;font-size:20px;" class="form-control" id="updateUserCode" readonly/>
               </div>
               <div class="form-group" style="font-size:20px;">
                 <label for="passwordInput">用户类型</label>
                  <select name="userType" id="updateUserType">
                 	<option value="" style="display:none;">用户类型</option>
				 	<c:forEach items="${ROLES }" var="type">
				 		<option value="${type.roleId }" class="updateUserType">${type.roleName }</option>
				 	</c:forEach>
				 </select>
               </div>
               <div class="form-group" style="font-size:20px;">
                <label for="passwordInput">部门</label>
                  <select name="groupId" id="updateGroupId">
				 	<option value="" style="display:none;">部门</option>
				 	<c:forEach items="${USERGROUPS }" var="group">
				 		<option value="${group.groupId }" class="updateGroupId">${group.groupName }</option>
				 	</c:forEach>
				 </select>
               </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <input type="submit" class="btn btn-primary" value="提交" />
              </div>
              </form>
              </div>
            </div>
          </div>
        </div>
      </div>          
    </div>
	</div>
<!-- 提示框 -->
<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
    	<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" >提示信息</h4>
      </div>
      <div class="modal-body" id="op-tips-content">
      </div>
    </div>
  </div>
</div>
<!-- 分配角色 -->
<div class="modal fade " id="assign-roles" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
<div class="modal-dialog modal-sm" role="document">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title" >分配角色</h4>
    </div>
    <div class="modal-body">
    	<form class="update-userrole-form" action="${pageContext.request.contextPath}/user/updateUserRole.action?pageNum=${page.pageNum}&pageSize=${page.pageSize}" method="post">
          <div class="form-group" style="display:none;">
            <label for="userIdInput">编号</label>
            <input type="text" name="userId" style="color:red;text-align:center;font-size:20px;" class="form-control" id="assignRolesUserId" readonly/>
          </div>
          <div class="form-group">
            <label for="userCodeInput">用户名<font color="red">(不可修改)</font></label>
            <input type="text" style="color:red;text-align:center;font-size:20px;" class="form-control" id="assignRolesUserCode" readonly/>
          </div>
          <div class="form-group">
            <label for="passwordInput">角色</label><br/>
            <c:forEach items="${ROLES }" var="type">
            	<input type="checkbox" name="roleIds" value="${type.roleId }" class="choose-roles" /><font size="4%">${type.roleName }</font>
            </c:forEach>
          </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <input type="submit" class="btn btn-primary" value="确认"/>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script>
//更改权限
$(".user-list").on("click",".update-user-auth",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	location.href="${pageContext.request.contextPath}/user/findUserAuth.action?pageNum="
		+${page.pageNum}+"&pageSize="+${page.pageSize}+"&userId="+userId;
});
//导出数据
$("#all-data").click(function(){
	location.href="${pageContext.request.contextPath}/user/asData.action?dataNo=0";
}); 
$("#curr-data").click(function(){
	location.href="${pageContext.request.contextPath}/user/asData.action?dataNo=1";
}); 
//分配角色
$(".user-list").on("click",".assign-roles",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	$("#assignRolesUserId").val(userId);
	var userCode=userTr.find(".userCode").html();
	$("#assignRolesUserCode").val(userCode);
	var roles=$(".choose-roles");
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/user/findRole.action",
		data:{
			userId:userId,
		},
		dataType:"json",
		success:function(data){
			console.log(data);
			for(var j=0;j<roles.length;j++){
				roles[j].checked=false;
				for(var i=0;i<data.length;i++){
					if(data[i].roleId==roles[j].value){
						roles[j].checked=true;
					}
				}
			}
		}
	}); 	
});
//重置密码
$(".user-list").on("click",".reset-password",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	var userCode=userTr.find(".userCode").html();
	var userState=$(this).html()=="启 用"?1:0;
	if(confirm('确认将用户   '+userCode+' 的密码重置为    “123456”  吗？')){
		location.href="${pageContext.request.contextPath}/user/updateUser.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&userId="+userId
			+"&userPwd=123456";
	}
});
//禁用/启用
$(".user-list").on("click",".asAble",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	var userCode=userTr.find(".userCode").html();
	var userState=$(this).html()=="启 用"?1:0;
	if(confirm('确 认   '+$(this).html()+'   用 户 ---'+userCode+'--- 吗？')){
		location.href="${pageContext.request.contextPath}/user/updateUser.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&userId="+userId+"&userState="
			+userState;
	}
});
//修改用户
$(".user-list").on("click",".show-userrole-form",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	$("#updateUserId").val(userId);
	var userCode=userTr.find(".userCode").html();
	$("#updateUserCode").val(userCode);
	var userType=userTr.find(".userType").html();
	var updateUserType=$(".updateUserType");
	for(var i=0;i<updateUserType.length;i++){
		if(userType==updateUserType[i].innerHTML){
			updateUserType[i].selected=true;
		}
	}
	var groupId=userTr.find(".groupId").html();
	var updateGroupId=$(".updateGroupId");
	for(var i=0;i<updateGroupId.length;i++){
		if(groupId==updateGroupId[i].innerHTML){
			updateGroupId[i].selected=true;
		}
	}
	console.log(userType+"***"+userCode+"***"+groupId+"&&&"+userId);
});
//查询用户
$("#findUser").click(function(){
	var userCode=$("#userCode").val();
	var userType=$("#userType").val();
	var userState=$("#userState").val();
	location.href="${pageContext.request.contextPath}/user/list.action?userCode0=" + 
		userCode + "&userType0=" + userType + "&userState0=" + userState ;
});
//提示
$(function(){
	if(${num }>0){
		showTips("操作成功！");
	}
});
function showTips(content){
  	$("#op-tips-content").html(content);
	$("#op-tips-dialog").modal("show");
}
//按键
$(function(){
	// jQuery
	$("#add-user-form").keydown(function(ev){
		console.log("按键" + ev.keyCode );
		if(ev.keyCode!=13){
			$("#userCodeError").removeClass("red").html("");
			$("#userTypeError").removeClass("red").html("");
			$("#groupIdError").removeClass("red").html("");
			$("#userPwdError").removeClass("red").html("");
			$("#passwordError").removeClass("red").html("");
		}
	});
});
//添加用户
$(".show-user-form").click(function(){
	$("#userCodeError").removeClass("red").html("");
	$("#userTypeError").removeClass("red").html("");
	$("#groupIdError").removeClass("red").html("");
	$("#userPwdError").removeClass("red").html("");
	$("#passwordError").removeClass("red").html("");
});
$("#cancel").click(function(){
	console.log("**************555*************");
	location.href="../pages/user-list.jsp?pageNum="
		+${page.pageNum}+"&pageSize="+${page.pageSize}
});
$("#addUserCode").blur(function(){
	console.log("blur&&&&&&&&&&&&");
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/user/ableUser.action",
		data:{
		userCode:$(this).val(),
		},
		dataType:"json",
		success:function(data){
			console.log("%%%%%"+data.msg);
			if(data.flag=='0'){
				$("#addUserCodeError").text("用户名不可用");
			}else{
				$("#addUserCodeError").removeClass("red").addClass("green").text("用户名可用");
			}
		}
	});
});
$(".add-user-submit").click(function(){
	var userCode=$("#addUserCode").val();
	var groupId=$("#addGroupId").val();
	var userPwd=$("#addUserPwd").val();
	var password=$("#addPassword").val();
	
	if(!/^\w{4,16}$/.test(userCode)){
		$("#addUserCodeError").text("用户名不合法! 4-16位，字母，数字，下划线");
		return false;
	}else if(null==groupId || groupId==""){
		$("#addGroupIdError").text("部门不能为空");
		return false;
	}else if(!/^\w{6,16}$/.test(userPwd)){
		$("#addUserPwdError").text("密码不合法! 6-16位，字母，数字，下划线");
		return false;
	}else if(userPwd != password){
		$("#addPasswordError").text("确认密码与原密码不一致");
		return false;
	}else{
		 $.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/user/addUser.action",
			data:{
			userCode:userCode,
			groupId:groupId,
			userPwd:userPwd
			},
			dataType:"json",
			success:function(data){
				console.log("%%%%%"+data.msg);
				if(data.msg=='999'){
					$("#addUserCodeError").text("用户名不可用");
				}else if(null!=data.msg && data.msg!='' && data.msg!='0'){
					alert("用户添加成功！");
					location.href="${pageContext.request.contextPath}/user/list.action?pageNum="+${page.pageNum}+"&pageSize="+${page.pageSize};
				}
			}
		}); 
	}
});
//删除用户
$(".user-list").on("click",".delete-this-user",function(){
	var userTr=$(this).parents("tr");
	var userId=userTr.find(".userId").html();
	var userCode=userTr.find(".userCode").html();
	if(confirm('确认  删除  用户---'+userCode+'---吗？')){
		location.href="${pageContext.request.contextPath}/user/updateUser.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&userId="+userId+"&isDelete=1";
	}
});
</script>
</body>
</html>
 <!--  <tr>
   	<td><input type="checkbox" name="userIds" value="11"/></td>
       <td class="userid">1</td>
       <td class="userCode">sisu</td>
       <td><a href="javascript:void(0);" class="show-user-roles" >查看所有角色</a></td>
       <td>
       	<a class="glyphicon glyphicon-wrench show-userrole-form" aria-hidden="true" title="修改所有角色" href="javascript:void(0);" data-toggle="modal" data-target="#update-userrole-dialog"></a>
       	<a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);"></a>
       </td>${page.resultList }
   </tr>-->
