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
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>修改用户权限</title>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/demo.css"
	type="text/css">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript">
       var setting = {    
        	/*    check:{
               enable:true,
               chkStyle: "radio",  //单选框
               radioType: "all"   //对所有节点设置单选
            },   */
               check:{//使用复选框
                enable:true
            },  
            data: {
                simpleData:{//是否使用简单数据模式
                    enable:true
                }
            },
            callback:{onCheck:onCheck}           
        };
         //id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中        
        var zNodes=${ROLEAUTH};
        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
           //选中复选框后触发事件
            function onCheck(e,treeId,treeNode){
            	var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true),
            	v="";
            	//获取选中的复选框的值
            	for(var i=0;i<nodes.length;i++){
            		v+=nodes[i].id+"//";
            		//alert(nodes[i].id); //获取选中节点的值
            		// $("#authIdInput").val(v);
            	} 
            	//alert(v);
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
				<h1 class="page-header">修改角色<font color="red">${roleName1 }</font>权限</h1>
				<div class="row placeholders">
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree" style="width:1024px;"></ul>
					</div>
					<div>
						<button type="button" style="width:100px;" class="btn btn-primary" id="update-auth">修改权限</button>
						<button type="button" style="width:100px;" class="btn btn-default" id="cancel">取消</button>		
					</div>											
				</div>
			</div>
			
			
			
			
		</div>
	</div>
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
	 $("#cancel").click(function(){
		 location.href="${pageContext.request.contextPath}/role/list.action?pageNum="
				+${page.pageNum}+"&pageSize="+${page.pageSize}; 
	 }); 
	$("#update-auth").click(function(){
		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
    	nodes=treeObj.getCheckedNodes(true),
    	v="";
    	//获取选中的复选框的值
    	for(var i=0;i<nodes.length;i++){
    		v+=nodes[i].id+",";
    	} 
    	location.href="${pageContext.request.contextPath}/role/updateRoleAuth.action?pageNum="
			+ ${page.pageNum}+"&pageSize=" + ${page.pageSize} + "&authIdStr=" + v + "&roleId="
			+ ${roleId1}; 
	});
	</script>
</body>
</html>
