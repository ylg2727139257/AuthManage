<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Word只需要把contentType="application/msexcel"改为contentType="application/msword" 
--%>
<%   
  //独立打开excel软件   
 response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//嵌套在ie里打开excel   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.doc"); 
%>  
<html>  
<head>  
	<title>测试导出Excel和Word</title>
</head>  
<body>
  <table width="500" border="1" align="center">
  <tr>  
    <td colspan="7" align="center">用户信息</td>  
  </tr>  
 	<tr>
         <td>编号</td>
         <td>用  户  名</td>
         <td>部  门</td>
         <td>用 户 类 型</td>
         <td>用户状态</td>
         <td>创  建  时  间</td>
         <td>备  注</td>
     </tr>
     <c:forEach items="${data }" var="user">
     	<tr>
     		<td class="userId">${user.userId }</td>
     		<td class="userCode">${user.userCode }</td>
     		<td class="groupId">${user.userGroup.groupName }</td>
     		<td class="userType">${user.role.roleName }</td>
     		<td class="userState">${user.userState==1?"<font color='green'>启  用</font>":"<font color='red'>禁  用</font>" }</td>
     		<td><fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
          <td class="caozuo"></td>
     	</tr>
     </c:forEach>
 </table>
 <script>
 	
 
 
 </script>
</body>  
</html>  
