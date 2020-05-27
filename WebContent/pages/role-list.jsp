<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>用户管理 - 角色列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
 	<style>
    	table{text-align:center;vertical-align:text-bottom;font-size:18px;font-weight: bold;font-family: "黑体"}
    	#tit{font-size:18px;}
    	#roleName{display: inline-block;margin-left:58%;width:10%;height:1%;}
    	.caozuo{text-align:left;}
    	button{font-size:20px;font-weight:bold;font-family: "黑体";}
    	.red{color:red;}
    	.green{color:green;}
    	#add-role{margin-left:3%;}
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
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">角色列表</h1>
          <div class="row placeholders">
          	<div id="tit">                
<!--添加角色-->
<button type="button" id="add-role" class="btn btn-warning show-add-form" data-toggle="modal" data-target="#role-form-div">添加角色</button>
<div class="modal fade " id="role-form-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加角色</h4>
      </div>
      <div class="modal-body">
   	<form class="role-form">
         <div class="form-group">
           <label for="roleNameInput">名称</label>
           <input type="text" name="roleName" class="form-control" id="roleNameInput" placeholder="角色名">
         	<label id="roleNameError"></label><br/>
         </div>
         <div class="form-group">
           <label for="descInput">描述</label>
           <input type="text" name="roleDesc" class="form-control" id="descInput" placeholder="角色描述">
         	<label id="roleDescError"></label><br/>
         </div>
         <div class="form-group">
           <label for="codeInput">代码</label>
           <input type="text" name="roleCode" class="form-control" id="codeInput" placeholder="角色代码">
         	<label id="roleCodeError"></label><br/>
         </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="cancel" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary role-submit" id="add-role-submit">提交</button>
       	</div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 搜索 -->     
 <input type="text"  id="roleName" name="roleName0"  placeholder="角色名" value="${roleName }">
 <select name="roleState" id="roleState">
 	<option value="" ${empty roleState?"selected":"" } style="display:none;">角色状态</option>
 	<option value="1" ${roleState eq "1" ? "selected":"" }>启  用</option>
 	<option value="0" ${(not empty roleState and roleState eq "0") ?"selected":"" }>禁  用</option>
 	<option value="" >全  部</option>
 </select>
<button type="button" class="btn btn-warning" id="findRole"> 搜 索 </button>
 </div>
  <div class="space-div"></div>
 <!-- 角色信息 -->
            <table class="table table-hover table-bordered role-list">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>角色ID</td>
                    <td>名  称</td>
                    <td>描  述</td>
                    <td>代  码</td>
                    <td>状  态</td>
                    <td>创  建  人</td>
                    <td>操&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作</td>
                </tr>
                <c:forEach items="${page.resultList }" var="role">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value="${role.roleId }"/></td>
	                    <td class="roleId">${role.roleId }</td>
	                    <td class="roleName">${role.roleName }</td>
	                    <td class="roleDesc">${role.roleDesc }</td>
	                    <td class="roleCode">${role.roleCode }</td>
	                    <td class="roleState">${role.roleState==1?"<font color='green'>启  用</font>":"<font color='red'>禁  用</font>" }</td>
	                    <td class="createBy">${role.userInfo.userCode }</td>
	                    <td class="caozuo"><a class="glyphicon glyphicon-pencil show-roleinfo-form" aria-hidden="true" title="修改角色" href="javascript:void(0);" data-toggle="modal" data-target="#role-update-form"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-role" aria-hidden="true" title="删除角色" href="javascript:void(0);"></a>
	                    	<button type="button" class="btn btn-warning asAble" >${role.roleState==0 ? "启 用" : "禁 用" }</button>
				          	<c:if test="${role.roleState==1 }">
					           	<button type="button" class="btn btn-primary update-role-auth">更改权限</button>
	                    	</c:if>
	                    	</td>
	                </tr>
                </c:forEach>
            </table>
            <jsp:include page="standard.jsp"/>
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
<!--修改角色-->
<div class="modal fade " id="role-update-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改角色</h4>
      </div>
      <div class="modal-body">
   	<form class="role-form" action="${pageContext.request.contextPath}/role/updateRole.action?pageNum=${page.pageNum}&pageSize=${page.pageSize}" method="post">
         <div class="form-group">
           <input type="text" name="roleId" class="form-control" id="updateRoleId" placeholder="角色名" readonly style="display:none;">
           <label for="roleNameInput">名称<font color="red">(不可修改)</font></label>
           <input type="text" name="roleName" class="form-control" style="color:red;text-align:center;font-size:20px;" id="updateRoleName"  readonly>
         	<label id="roleNameError"></label><br/>
         </div>
         <div class="form-group">
           <label for="descInput">描述</label>
           <input type="text" name="roleDesc" class="form-control" id="updateRoleDesc" placeholder="角色描述">
         	<label id="roleDescError"></label><br/>
         </div>
         <div class="form-group">
           <label for="codeInput">代码</label>
           <input type="text" name="roleCode" class="form-control" id="updateRoleCode" placeholder="角色代码">
         	<label id="roleCodeError"></label><br/>
         </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="cancel" data-dismiss="modal">取消</button>
          <input type="submit" class="btn btn-primary role-submit" id="update-role-submit" value="提交"/>
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
$(".role-list").on("click",".update-role-auth",function(){
	var roleTr=$(this).parents("tr");
	var roleId=roleTr.find(".roleId").html();
	location.href="${pageContext.request.contextPath}/role/findRoleAuth.action?pageNum="
		+${page.pageNum}+"&pageSize="+${page.pageSize}+"&roleId="+roleId;
});
//删除角色
$(".role-list").on("click",".delete-this-role",function(){
	var roleTr=$(this).parents("tr");
	var roleId=roleTr.find(".roleId").html();
	var roleName=roleTr.find(".roleName").html();
	if(confirm('确认删除角色---'+roleName+'---吗？')){
		location.href="${pageContext.request.contextPath}/role/deleteRole.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&roleId="+roleId;
	}
});
//禁用/启用
$(".role-list").on("click",".asAble",function(){
	var roleTr=$(this).parents("tr");
	var roleId=roleTr.find(".roleId").html();
	var roleName=roleTr.find(".roleName").html();
	var roleState=$(this).html()=="启 用"?1:0;
	if(confirm('确 认   '+$(this).html()+'   角  色 ---'+roleName+'--- 吗？')){
		location.href="${pageContext.request.contextPath}/role/updateRole.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&roleId="+roleId+"&roleState="
			+roleState;
	}
});
//查询用户
$("#findRole").click(function(){
	var roleName=$("#roleName").val();
	var roleState=$("#roleState").val();
	location.href="${pageContext.request.contextPath}/role/list.action?roleName0=" + 
		roleName + "&roleState0=" + roleState ;
})
//提示
$(function(){
	if(${num}>0){
		showTips("操作成功！");
	}
});
function showTips(contents){
	$("#op-tips-content").html(contents);
	$("#op-tips-dialog").modal("show");
}    
//按键
$(function(){
	// jQuery
	$("#role-form-div").keydown(function(ev){
		console.log("按键" + ev.keyCode );
		if(ev.keyCode!=13){
			$("#roleNameError").removeClass("red").html("");
			$("#roleDescError").removeClass("red").html("");
			$("#roleCodeError").removeClass("red").html("");
		}
	});
});
//添加角色
$("#cancel").click(function(){
	console.log("**************555*************");
	location.href="../pages/role-list.jsp?pageNum="
		+${page.pageNum}+"&pageSize="+${page.pageSize}
});
$("#roleNameInput").blur(function(){
	console.log("blur&&&&&&&&&&&&");
	var roleName=$("#roleNameInput").val();
	if(null==roleName || roleName==""){
		$("#roleNameError").addClass("red").text("角色名不能为空");
		return false;
	}else{
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/role/ableRole.action",
			data:{
				roleName:roleName,
			},
			dataType:"json",
			success:function(data){
				console.log("%%%%%"+data.msg);
				if(data.flag=='0'){
					$("#roleNameError").addClass("red").text("角色名不可用");
				}else{
					$("#roleNameError").addClass("green").text("角色名可用");
				}
			}
		});
	}
});
$("#add-role-submit").click(function(){
	var roleName=$("#roleNameInput").val();
	var roleDesc=$("#descInput").val();
	var roleCode=$("#codeInput").val();
	
	if(null==roleName || roleName==""){
		$("#roleNameError").addClass("red").text("角色名不能为空");
		return false;
	}else if(null==roleDesc || roleDesc==""){
		$("#roleDescError").addClass("red").text("描述不能为空");
		return false;
	}else if(null==roleCode || roleCode==""){
		$("#roleCodeError").addClass("red").text("代码不能为空");
		return false;
	}else{
		 $.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/role/addRole.action",
			data:{
				roleName:roleName,
				roleDesc:roleDesc,
				roleCode:roleCode
			},
			dataType:"json",
			success:function(data){
				console.log("%%%%%"+data.msg);
				if(data.msg=='n'){
					$("#roleNameError").addClass("red").text("角色名不可用");
				}else if(null!=data.msg && data.msg!='' && data.msg!='0'){
					alert("添加成功！");
					location.href="${pageContext.request.contextPath}/role/list.action?pageNum="+${page.pageNum}+"&pageSize="+${page.pageSize};
				}
			}
		}); 
	}
});    
//修改角色
$(".role-list").on("click",".show-roleinfo-form",function(){
	var roleTr=$(this).parents("tr");
	var roleId=roleTr.find(".roleId").html();
	$("#updateRoleId").val(roleId);
	var roleName=roleTr.find(".roleName").html();
	$("#updateRoleName").val(roleName);
	var roleDesc=roleTr.find(".roleDesc").html();
	$("#updateRoleDesc").val(roleDesc);
	var roleCode=roleTr.find(".roleCode").html();
	$("#updateRoleCode").val(roleCode);
	console.log(roleId+"***"+roleName+"***"+roleDesc+"&&&"+roleCode);
});   

    </script>
  </body>
</html>
