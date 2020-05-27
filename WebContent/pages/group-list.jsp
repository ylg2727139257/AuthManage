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
    <title>用户管理 - 用户组列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
 	<style>
    	table{text-align:center;vertical-align:text-bottom;font-size:18px;font-weight: bold;font-family: "黑体"}
    	#tit{font-size:18px;}
    	.caozuo{text-align:left;}
    	#groupName{display: inline-block;margin-left:58%;width:10%;height:1%;}
    	button{font-size:20px;font-weight:bold;font-family: "黑体";}
    	.red{color:red;}
    	.green{color:green;}
    	#add-group{margin-left:3%;}
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
          <h1 class="page-header">用户组列表</h1>
          <div class="row placeholders">
          	<div id="tit">                
<!--添加用户组-->
<button type="button" id="add-group" class="btn btn-warning show-add-form" data-toggle="modal" data-target="#group-form-div">添加用户组</button>
<div class="modal fade " id="group-form-div" tabindex="-1" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加用户组</h4>
      </div>
      <div class="modal-body">
   	<form class="group-form">
         <div class="form-group">
           <label for="groupNameInput">名称</label>
           <input type="text" name="groupName" class="form-control" id="groupNameInput" placeholder="用户组名">
         	<label id="groupNameError"></label><br/>
         </div>
         <div class="form-group">
           <label for="descInput">描述</label>
           <input type="text" name="groupDesc" class="form-control" id="descInput" placeholder="用户组描述">
         	<label id="groupDescError"></label><br/>
         </div>
         <div class="form-group">
           <label for="codeInput">代码</label>
           <input type="text" name="groupCode" class="form-control" id="codeInput" placeholder="用户组代码">
         	<label id="groupCodeError"></label><br/>
         </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="cancel" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary group-submit" id="add-group-submit">提交</button>
       	</div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 搜索 -->     
 <input type="text"  id="groupName" name="groupName0"  placeholder="用户组名" value="${groupName }">
 <select name="groupState" id="groupState">
 	<option value="" ${empty groupState?"selected":"" } style="display:none;">用户组状态</option>
 	<option value="1" ${groupState eq "1" ? "selected":"" }>启  用</option>
 	<option value="0" ${(not empty groupState and groupState eq "0") ?"selected":"" }>禁  用</option>
 	<option value="" >全  部</option>
 </select>
<button type="button" class="btn btn-warning" id="findGroup"> 搜 索 </button>
 </div>
  <div class="space-div"></div>
 <!-- 用户组信息 -->
            <table class="table table-hover table-bordered group-list">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>ID</td>
                    <td>名  称</td>
                    <td>代  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  码</td>
                    <td>描  述</td>
                    <td>状  态</td>
                    <td>操  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <c:forEach items="${page.resultList }" var="group">
	                <tr>
	                	<td><input type="checkbox" name="groupIds" value="${group.groupId }"/></td>
	                    <td class="groupId">${group.groupId }</td>
	                    <td class="groupName">${group.groupName }</td>
	                    <td class="groupCode">${group.groupCode }</td>
	                    <td class="groupDesc">${group.groupDesc }</td>
	                    <td class="groupState">${group.groupState==1?"<font color='green'>启  用</font>":"<font color='red'>禁  用</font>" }</td>
	                    <td class="caozuo"><a class="glyphicon glyphicon-pencil show-groupinfo-form" aria-hidden="true" title="修改用户组" href="javascript:void(0);" data-toggle="modal" data-target="#group-update-form"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-group" aria-hidden="true" title="删除用户组" href="javascript:void(0);"></a>
	                    	<button type="button" class="btn btn-warning asAble" >${group.groupState==0 ? "启 用" : "禁 用" }</button>
				          	<c:if test="${group.groupState==1 }">
					           	<button type="button" class="btn btn-primary assign-roles" data-toggle="modal" data-target="#assign-roles">分配角色</button>
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
<div class="modal fade" id="op-tips-dialog" tabindex="-1" aria-labelledby="mySmallModalLabel">
     <div class="modal-dialog modal-sm" >
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
<!--修改用户组-->
<div class="modal fade " id="group-update-form" tabindex="-1" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改用户组</h4>
      </div>
      <div class="modal-body">
   	<form class="group-form" action="${pageContext.request.contextPath}/group/updateGroup.action?pageNum=${page.pageNum}&pageSize=${page.pageSize}" method="post">
         <div class="form-group">
           <input type="text" name="groupId" class="form-control" id="updateGroupId" readonly style="display:none;">
           <label for="groupNameInput">名称<font color="red">(不可修改)</font></label>
           <input type="text" name="groupName" class="form-control" style="color:red;text-align:center;font-size:20px;" id="updateGroupName" placeholder="用户组名" readonly>
         	<label id="groupNameError"></label><br/>
         </div>
         <div class="form-group">
           <label for="descInput">描述</label>
           <input type="text" name="groupDesc" class="form-control" id="updateGroupDesc" placeholder="用户组描述">
         	<label id="groupDescError"></label><br/>
         </div>
         <div class="form-group">
           <label for="codeInput">代码</label>
           <input type="text" name="groupCode" class="form-control" id="updateGroupCode" placeholder="用户组代码">
         	<label id="groupCodeError"></label><br/>
         </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="cancel" data-dismiss="modal">取消</button>
          <input type="submit" class="btn btn-primary group-submit" id="update-group-submit" value="提交"/>
       	</div>
        </form>
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
    	<form class="update-userrole-form" action="${pageContext.request.contextPath}/group/updateGroupRole.action?pageNum=${page.pageNum}&pageSize=${page.pageSize}" method="post">
          <div class="form-group" style="display:none;">
            <label for="userIdInput">编号</label>
            <input type="text" name="groupId" style="color:red;text-align:center;font-size:20px;" class="form-control" id="assignRolesGroupId" readonly/>
          </div>
          <div class="form-group">
            <label for="groupNameInput">用户名<font color="red">(不可修改)</font></label>
            <input type="text" style="color:red;text-align:center;font-size:20px;" class="form-control" id="assignRolesGroupName" readonly/>
          </div>
          <div class="form-group">
            <label for="passwordInput">角色</label><br/>
            <c:forEach items="${GROUPROLES }" var="type">
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
//删除用户组
$(".group-list").on("click",".delete-this-group",function(){
	var groupTr=$(this).parents("tr");
	var groupId=groupTr.find(".groupId").html();
	var groupName=groupTr.find(".groupName").html();
	if(confirm('确认删除用户组---'+groupName+'---吗？')){
		location.href="${pageContext.request.contextPath}/group/deleteGroup.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&groupId="+groupId;
	}
});
//分配角色
$(".group-list").on("click",".assign-roles",function(){
	var groupTr=$(this).parents("tr");
	var groupId=groupTr.find(".groupId").html();
	$("#assignRolesGroupId").val(groupId);
	var groupCode=groupTr.find(".groupCode").html();
	$("#assignRolesGroupName").val(groupCode);
	var roles=$(".choose-roles");
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/group/findRole.action",
		data:{
			groupId:groupId,
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
//禁用/启用
$(".group-list").on("click",".asAble",function(){
	var groupTr=$(this).parents("tr");
	var groupId=groupTr.find(".groupId").html();
	var groupName=groupTr.find(".groupName").html();
	var groupState=$(this).html()=="启 用"?1:0;
	if(confirm('确 认  '+$(this).html()+'  用户组 ---'+groupName+'--- 吗？')){
		location.href="${pageContext.request.contextPath}/group/updateGroup.action?pageNum="
			+${page.pageNum}+"&pageSize="+${page.pageSize}+"&groupId="+groupId+"&groupState="
			+groupState;
	}
});
//查询用户
$("#findGroup").click(function(){
	var groupName=$("#groupName").val();
	var groupState=$("#groupState").val();
	location.href="${pageContext.request.contextPath}/group/list.action?groupName0=" + 
		groupName + "&groupState0=" + groupState ;
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
	$("#group-form-div").keydown(function(ev){
		console.log("按键" + ev.keyCode );
		if(ev.keyCode!=13){
			$("#groupNameError").removeClass("red").html("");
			$("#groupDescError").removeClass("red").html("");
			$("#groupCodeError").removeClass("red").html("");
		}
	});
});
//添加用户组
$("#cancel").click(function(){
	console.log("**************555*************");
	location.href="../pages/group-list.jsp?pageNum="
		+${page.pageNum}+"&pageSize="+${page.pageSize}
});
$("#groupNameInput").blur(function(){
	console.log("blur&&&&&&&&&&&&");
	var groupName=$("#groupNameInput").val();
	if(null==groupName || groupName==""){
		$("#groupNameError").addClass("red").text("用户组名不能为空");
		return false;
	}else{
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/group/ableGroup.action",
			data:{
				groupName:groupName,
			},
			dataType:"json",
			success:function(data){
				console.log("%%%%%"+data.msg);
				if(data.flag=='0'){
					$("#groupNameError").addClass("red").text("用户组名不可用");
				}else{
					$("#groupNameError").addClass("green").text("用户组名可用");
				}
			}
		});
	}
});
$("#add-group-submit").click(function(){
	var groupName=$("#groupNameInput").val();
	var groupDesc=$("#descInput").val();
	var groupCode=$("#codeInput").val();
	
	if(null==groupName || groupName==""){
		$("#groupNameError").addClass("red").text("用户组名不能为空");
		return false;
	}else if(null==groupDesc || groupDesc==""){
		$("#groupDescError").addClass("red").text("描述不能为空");
		return false;
	}else if(null==groupCode || groupCode==""){
		$("#groupCodeError").addClass("red").text("代码不能为空");
		return false;
	}else{
		 $.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/group/addGroup.action",
			data:{
				groupName:groupName,
				groupDesc:groupDesc,
				groupCode:groupCode
			},
			dataType:"json",
			success:function(data){
				console.log("%%%%%"+data.msg);
				if(data.msg=='n'){
					$("#groupNameError").addClass("red").text("用户组名不可用");
				}else if(null!=data.msg && data.msg!='' && data.msg!='0'){
					alert("添加成功！");
					location.href="${pageContext.request.contextPath}/group/list.action?pageNum="+${page.pageNum}+"&pageSize="+${page.pageSize};
				}
			}
		}); 
	}
});    
//修改用户组
$(".group-list").on("click",".show-groupinfo-form",function(){
	var groupTr=$(this).parents("tr");
	var groupId=groupTr.find(".groupId").html();
	$("#updateGroupId").val(groupId);
	var groupName=groupTr.find(".groupName").html();
	$("#updateGroupName").val(groupName);
	var groupDesc=groupTr.find(".groupDesc").html();
	$("#updateGroupDesc").val(groupDesc);
	var groupCode=groupTr.find(".groupCode").html();
	$("#updateGroupCode").val(groupCode);
	console.log(groupId+"***"+groupName+"***"+groupDesc+"&&&"+groupCode);
});   

    </script>
  </body>
</html>
