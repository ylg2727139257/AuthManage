<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>权限管理 - 权限列表</title>
<style>
	.red{color:red;}
   	.green{color:green;}
   	.hidd{display:none;}
</style>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree/css/demo.css" type="text/css">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript">
var setting = {    
 	   check:{
        enable:true,
        chkStyle: "radio",  //单选框
        radioType: "all"   //对所有节点设置单选,level
     }, /* check:{//使用复选框 enable:true },   */
     data: {
         simpleData:{//是否使用简单数据模式
             enable:true
         }
     },
     callback:{
         onCheck:onCheck
     },
     view:{
 		fontCss: setFontCss
 	}
 };
  //id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中        
 var zNodes = ${AUTHS};
 $(document).ready(function(){
     $.fn.zTree.init($("#treeDemo"), setting, zNodes);
 });
function setFontCss(treeId, treeNode) {
	return treeNode.state == 0 ? {color:"gray"} : {};
}
//选中复选框后触发事件
function onCheck(e,treeId,treeNode){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	v="";
	if(nodes[0] == null) {
		window.location.reload();
	}
	//获取选中的复选框的值
	/* for(var i=0;i<nodes.length;i++){
		v+=nodes[i].id;
		//alert(nodes[i].id); //获取选中节点的值 $("#authIdInput").val(v);
	} */
	//console.log(v);
}         
</script>
</head>
<body>
${USER==null?"<script>alert('亲 ， 还 未 登 录 哦 !');location.href='../pages/login.jsp';</script>":"" }
<!-- 头部 -->
<jsp:include page="header.jsp" />
<div class="container-fluid" style="margin-top: 30px;">
<div class="row">
	<div class="col-sm-3 col-md-2 sidebar">
		<jsp:include page="navibar.jsp" />
</div>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h1 class="page-header">权限列表</h1>
	<div>
<button type="button" class="btn btn-default update-auth" style="width:100px;" data-toggle="modal" data-target="#update-auth-form-div">修改权限</button>
<!-- 恢复权限 -->
<button type="button" style="width:130px;" class="btn btn-primary" data-toggle="modal" data-target="#rein-auth-form-div" id="recover-auth">恢复/禁用权限</button>
<!--修改权限-->
<div class="modal fade " id="update-auth-form-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
<div class="modal-dialog modal-md" role="document">
<div class="modal-content">
<div class="modal-header"><h4 class="modal-title">修改权限</h4></div>
<div class="modal-body">
<form class="role-form">
<div class="form-group">
<label for="authNameInput">名称</label>
<input type="text" name="authId" class="form-control" id="updateAuthId" readonly style="display:none;">
<input type="text" name="authName" class="form-control" id="updateAuthName" placeholder="要修改的权限名称">
<label id="updateANErr"></label>
</div>
<div class="form-group"><label for="descInput">权限描述</label> 
<input type="text" name="authDesc" class="form-control" id="updateAuthDesc" placeholder="要修改的权限描述">
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
<button type="button" class="btn btn-primary role-submit" id="update-auth-submit">提交</button>
</div>
</form>
</div></div></div></div></div>
<!-- 添加权限 -->
<div class="modal fade " id="role-form-div" tabindex="-1"
	role="dialog" aria-labelledby="mySmallModalLabel">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">添加权限</h4>
			</div>
<div class="modal-body">
<form class="role-form" >
	<div class="form-group hidd">
		<label for="authNameInput1">父Id</label> 
		<input type="text" name="parentId" class="form-control" id="addParentId"/>
	</div>
	<div class="form-group">
		<label for="authNameInput1">名称</label> 
		<input type="text" name="authName" class="form-control" id="addAuthName" placeholder="权限名称" />
		<label id="authNameErr" class="red"></label> 
	</div>
	<div class="form-group">
		<label for="descInput1">权限描述</label> 
		<input type="text" name="authDesc" class="form-control" id="addAuthDesc" placeholder="权限描述" />
		<label id="authDescErr" class="red"></label>
	</div>
	 
	<div class="form-group hidd" id="add-auth-url">
		<label for="descInput1">权限url</label> 
		<input type="text" name="authUrl" class="form-control" id="addAuthUrl" placeholder="权限url" />
		<label id="authUrlErr" class="red"></label>
	</div>
	<div class="form-group hidd" id="add-auth-code">
		<label for="codeInput1">权限code</label> 
		<input type="text" name="authCode" class="form-control" id="addAuthCode" placeholder="权限代码" />
		<label id="authCodeErr" class="red"></label>
	</div>
	<div class="form-group">
		<label for="descInput1">分类</label> 
		<select name="authGrade" id="addAuthGrade" >
			<option value="1" >模块</option>
			<option value="2" disabled="disabled">列表</option>
			<option value="3" disabled="disabled">按钮</option>
		</select>
</div></form></div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">取消</button>
<button type="submit" class="btn btn-primary" id="add-auth-submit">提交</button>
</div></div></div></div>
<!--权限信息-->
<div class="zTreeDemoBackground left">
	<ul id="treeDemo" class="ztree" style="width:1024px;"></ul>
</div>
<div>
<button type="button" class="btn btn-default" id="add-auth" data-toggle="modal" data-target="#role-form-div" style="width: 100px;">添加权限</button>
<!-- 删除权限 -->
<button type="button" style="width:100px;" class="btn btn-primary" id="delete-auth">删除权限</button>		
</div></div></div></div>
<!-- 提示框 -->
<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">提示信息</h4>
			</div>
			<div class="modal-body" id="op-tips-content"></div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script>
//按键
$("#cancel").click(function(){
	location.href="${pageContext.request.contextPath}/auth/list.action";
});
$(function(){
	// jQuery
	$(".role-form").keydown(function(ev){
		console.log("按键" + ev.keyCode );
		if(ev.keyCode!=13){
			$("#updateANErr").html("");
			$("#authNameErr").html("");
			$("#authDescErr").html("");
			$("#authUrlErr").html("");
			$("#authCodeErr").html("");
		}
	});
});
/* 添加权限 */
$("#add-auth-submit").click(function(){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	var authName=$("#addAuthName").val();
	var authDesc=$("#addAuthDesc").val();
	var authUrl=$("#addAuthUrl").val();
	var authCode=$("#addAuthCode").val();
	var authDesc=$("#addAuthDesc").val();
	var authGrade=$("#addAuthGrade").val();
	var parentId=$("#addParentId").val();
	if(null ==authName || authName==""){
		$("#authNameErr").text("权限名称不能为空");
		//return false;
	}else if(null ==authDesc || authDesc==""){
		$("#authDescErr").text("权限描述不能为空");
	}else if(null!=nodes && nodes!="" && nodes[0].grade>=1 && (null ==authUrl || authUrl=="")){
		$("#authUrlErr").text("权限url不能为空");
		//return false;
	}else if(null!=nodes && nodes!="" && nodes[0].grade>1 && (null ==authCode || authCode=="")){
		$("#authCodeErr").text("权限code不能为空");
		//return false;
	}else{
		$.ajax({
			url:"${pageContext.request.contextPath}/auth/ableNewAuth.action",
			dataType:"json",
			type:"POST",
			data:{
				authName:authName,
				authCode:authCode,
				authUrl:authUrl
			},
			success:function(data){
				console.log("@@@@@@@@@@@@@@@"+data.able);
				if(data.able=='1'){
					$("#authNameErr").text("权限名称不可用");
					//return false;
				}else if(data.able=='2'){
					$("#authUrlErr").text("权限url不可用");
					//return false;
				}else if(data.able=='3'){
					$("#authCodeErr").text("权限code不可用");
					//return false;
				}else if(data.able=='n'){
					location.href="${pageContext.request.contextPath}/auth/addAuth.action?authName="
						+authName+"&authCode="+authCode+"&authUrl="+authUrl+"&authDesc="+authDesc+
						"&authGrade="+authGrade+"&parentId="+parentId +"&authType="+authGrade;
				}
			},
			error:function(){ 
				showTips("执行异常");
            },
		});
	}
});
$("#add-auth").click(function(){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	console.log("*********"+nodes[0].id);
	if(null==nodes || nodes=="" || nodes.length==0 || nodes[0]==null){
		$("#addAuthGrade option:gt(0)").attr("disabled","disabled");
		$("#addAuthGrade option:eq(0)").removeAttr("disabled");
		$("#addAuthGrade option:eq(0)").attr("selected",true);
		$("#addParentId").val("0");
	}else{
		if(nodes[0].grade == 1){
			$("#add-auth-url").removeClass("hidd");
			$("#addAuthGrade option:eq(1)").removeAttr("disabled");
			$("#addAuthGrade option:gt(1)").attr("disabled","disabled");
			$("#addAuthGrade option:lt(1)").attr("disabled","disabled");
			$("#addAuthGrade option:eq(1)").attr("selected",true);
			$("#addParentId").val(nodes[0].id);
		}else if(nodes[0].grade==2){
			$("#add-auth-url").removeClass("hidd");
			$("#add-auth-code").removeClass("hidd");
			$("#addAuthGrade option:eq(2)").removeAttr("disabled");
			$("#addAuthGrade option:gt(2)").attr("disabled","disabled");
			$("#addAuthGrade option:lt(2)").attr("disabled","disabled");
			$("#addAuthGrade option:eq(2)").attr("selected",true);
			$("#addParentId").val(nodes[0].id);
		}else if(nodes[0].grade==3){
			showTips("不能添加下一级权限!");
			return false;
		}
	} 
});
/* 删除权限 */
$("#delete-auth").click(function(){
	console.log("$$$$$");
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	if(null!=nodes && nodes!=""){
		if(confirm('确 认 删 除 权 限--- '+nodes[0].name+'--- 吗？')){
			location.href="${pageContext.request.contextPath}/auth/deleteAuth.action?authId="+nodes[0].id;
		}
	}else{
		showTips("请选择要删除的权限!");
		return false;
	}
});
/* 恢复权限 */
$("#recover-auth").click(function(){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	if(null!=nodes && nodes!=""){
		if(nodes[0].state==1){
			if(confirm('确 认 禁 用 权 限--- '+nodes[0].name+'--- 吗？')){
				$.ajax({
					url:"${pageContext.request.contextPath}/auth/updateAuth.action",
					type:"POST",
					data:{
					authId:nodes[0].id,
					authState:0
					},					
					success:function(data){
						if(null==data.msg||data.msg==""||data.msg=="0"){
							showTips("禁用权限失败");
						}else if(data.msg>0 && data.msg!="999"){
							//showTips("删除权限成功");
							location.href="${pageContext.request.contextPath}/auth/list.action?num="+data.msg;
						}
					},
				});
			}
		}else if(nodes[0].state==0){
			if(confirm('确 认 恢 复 权 限--- '+nodes[0].name+'--- 吗？')){
				$.ajax({
					url:"${pageContext.request.contextPath}/auth/updateAuth.action",
					type:"POST",
					data:{
					authId:nodes[0].id,
					authState:1
					},					
					success:function(data){
						if(null==data.msg||data.msg==""||data.msg=="0"){
							showTips("恢复权限失败");
						}else if(data.msg>0 && data.msg!="999"){
							//showTips("恢复权限成功");
							location.href="${pageContext.request.contextPath}/auth/list.action?num="+data.msg;
						}
					}
				});
			}
		}
	}else{
		showTips("请选择要恢复或禁用的权限!");
		return false;
	}
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
/* 修改权限 */
$(".update-auth").click(function(){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	if(null!=nodes && nodes!=""){
		$("#updateAuthId").val(nodes[0].id);
		$("#updateAuthName").val(nodes[0].name);
		$("#updateAuthDesc").val(nodes[0].desc);
	}else{
		showTips("请选择要修改的权限!");
		return false;
	}
});
$("#updateAuthName").blur(function(){
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	var authName=$("#updateAuthName").val();
	if(null!=nodes && nodes!="" && nodes[0].name!=authName){
		$.ajax({
			url:"${pageContext.request.contextPath}/auth/ableAuth.action",
			type:"POST",
			data:{
			authName:authName,
			authId:nodes[0].id,
			},					
			success:function(data){
				if(data.flag=='0'){
					$("#updateANErr").text("权限名不可用");
				}else{
					$("#updateANErr").removeClass("red").addClass("green").text("权限名可用");
				}
			},
		});
	}
});
$("#update-auth-submit").click(function(){
	console.log("&&&&&&&&&&&&&");
	var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
	nodes=treeObj.getCheckedNodes(true);
	var authName=$("#updateAuthName").val();
	var authDesc=$("#updateAuthDesc").val();
	if(null!=nodes && nodes!="" ){
		$.ajax({
			url:"${pageContext.request.contextPath}/auth/updateAuth.action",
			type:"POST",
			data:{
			authName:authName,
			authDesc:authDesc,
			authId:nodes[0].id,
			},					
			success:function(data){
				if(null==data.msg||data.msg==""||data.msg=="0"){
					showTips("权限修改失败");
				}else if(data.msg=="n"){
					$("#updateANErr").addClass("red").text("权限名不可用");
				}else{
					alert("权限修改成功");
					location.href="${pageContext.request.contextPath}/auth/list.action?num="+data.msg;
				}
			},
		});
	}
});
</script>
</body>
</html>
