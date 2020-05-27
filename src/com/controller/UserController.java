package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service_interface.UserService;
import com.vo.AuthInfo;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.UserAuth;
import com.vo.UserGroup;
import com.vo.UserInfo;
import com.vo.UserRole;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	//验证码判断
	@RequestMapping("/validCode.action")
	@ResponseBody
	public JSONObject validCode(String vCode,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		JSONObject json=new JSONObject();
		HttpSession session=request.getSession();
		String vCode0=(String)session.getAttribute("rand01");
		if(vCode.equals(vCode0)) {
			json.put("msg",1);
		}else {
			json.put("msg",0);
		}
		return json;
	}
	//登录
	@RequestMapping("/login.action")
	@ResponseBody
	public JSONObject longin(String vCode,String userPwd,String userCode,String rememberMe,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		System.err.println(vCode+"*********"+userPwd+"&&&&&&&&&&&"+userCode+"&&"+rememberMe);
		JSONObject json=new JSONObject();
		HttpSession session=request.getSession();
		UserInfo userInfo0=new UserInfo();
		userInfo0.setUserCode(userCode);
		userInfo0.setUserPwd(userPwd);
		userInfo0.setIsDelete("0");
		String vCode0=(String)session.getAttribute("rand01");
		if(!vCode.equals(vCode0)) {
			json.put("res",0);
		}else{
			List<UserInfo> userInfos=userService.findUserInfo(userInfo0);
//			System.out.println("&&&&&&&&&&&&&&&&&&&&&"+userInfos);
			if(null==userInfos || userInfos.size()==0) {
				json.put("res",2);
			}else if(userInfos.size()==1) {
				UserInfo userInfo=userInfos.get(0);
				if(userInfo.getUserState().equals("0")){
					json.put("res",3);
				}else{
					session.setAttribute("USER",userInfos.get(0));
					json.put("res",1);
				}
			}
		}
		return json;
	}
	//首页
	@RequestMapping("/index.action")
	@ResponseBody
	public void index(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		HttpSession session=request.getSession();
		HashMap<String,Object> hashMap=new HashMap<String,Object>();
		UserInfo userInfo=(UserInfo)session.getAttribute("USER");
		hashMap.put("userId",userInfo.getUserId());
		hashMap.put("groupId",userInfo.getGroupId());
		hashMap.put("authId",0);
		List<AuthInfo> firstAuths=userService.findAuthToIndex(hashMap);
		for(AuthInfo auth:firstAuths) {
			hashMap.put("authId",auth.getAuthId());
			List<AuthInfo> secondAuths=userService.findAuthToIndex(hashMap);
			auth.setChildList(secondAuths);
		}
		session.setAttribute("firstList",firstAuths);
		request.getRequestDispatcher("../pages/index.jsp").forward(request, response);
	}
	//退出登录
	@RequestMapping("/logout.action")
	@ResponseBody
	public void logout(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		HttpSession session=request.getSession();
		session.removeAttribute("USER");
		//request.getContextPath()
		response.sendRedirect("../pages/login.jsp");
	}
	//用户列表
	@RequestMapping("/list.action")
	@ResponseBody
	public void list(Integer num,Integer pageSize,Integer pageNum,String userCode0,String userType0,
			String userState0,HttpServletRequest request,HttpServletResponse response)
					throws IOException, ServletException{
		HttpSession session=request.getSession();
		System.err.println(userCode0+"&&&&&&&&&&&&&"+userType0+"***********"+userState0+"&&&"+num);
//		TODO    How do you set 'pageSize'?	
		num=null==num?0:num;
		pageNum=null==pageNum ? 1 : pageNum;
		pageSize=null==pageSize ? 5 : pageSize;
		userCode0=null==userCode0?"":userCode0.trim();
		userType0=null==userType0?"":userType0.trim();
		userState0=null==userState0?"":userState0.trim();
		String isDelete0="0";
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		UserInfo userInfo=new UserInfo(userCode0,userType0,userState0,isDelete0);
		map.put("user", userInfo);
		List<UserInfo> userInfos0=userService.findUserList(map);
		session.setAttribute("USERLIST", userInfos0);
		
		PageUtil pageUtil0=new PageUtil(pageSize,pageNum);
		map.put("page", pageUtil0);
		List<UserInfo> userInfos=userService.findUserList(map);
		
		StringBuffer params=new StringBuffer();
		params.append("userCode0="+userCode0);
		params.append("&userType0="+userType0);
		params.append("&userState0="+userState0);
		
		PageUtil pageUtil = new PageUtil(pageSize,userInfos0.size(),pageNum,userInfos,
				"user/list.action",params);
		session.setAttribute("page", pageUtil);
		
		request.setAttribute("USERCODE", userCode0);
		request.setAttribute("USERTYPE", userType0);
		request.setAttribute("USERSTATE", userState0);
		request.setAttribute("num", num);
		
		Role role0=new Role();
		role0.setRoleState("1");
		List<Role> roles=userService.findRole(role0);
		session.setAttribute("ROLES", roles);
		
		HashMap<String,Object> groupMap=new HashMap<String,Object>();
		UserGroup group=new UserGroup();
		group.setGroupState("1");
		groupMap.put("group", group);
		List<UserGroup> userGroups=userService.findGroup(groupMap);
		session.setAttribute("USERGROUPS", userGroups);
		
		request.getRequestDispatcher("../pages/user-list.jsp").forward(request, response);  
	}
	//添加用户--用户名可用
	@RequestMapping("/ableUser.action")
	@ResponseBody
	public JSONObject ableUser(String userCode,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		JSONObject json=new JSONObject();
		UserInfo userInfo0=new UserInfo();
		userInfo0.setUserCode(userCode);
		List<UserInfo> userInfos0=userService.findUserInfo(userInfo0);
		json.put("flag", userInfos0.size()==0?1:0);
		return json;
	}
	//添加用户
	@RequestMapping("/addUser.action")
	@ResponseBody
	public JSONObject addUser(UserInfo userInfo0,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		System.out.println(userInfo0+"&&&&&&&&&&&&&&&&&&&&&&&"+new Date()+"$$$");
		HttpSession session=request.getSession();
		JSONObject json=new JSONObject();
		Integer createBy=((UserInfo)session.getAttribute("USER")).getUserId();
		userInfo0.setCreateBy(createBy);
		userInfo0.setUpdateBy(createBy);
		userInfo0.setUpdateTime(new Date());
		userInfo0.setUserType("3");
		UserInfo userInfo=new UserInfo();
		userInfo.setUserCode(userInfo0.getUserCode());
		List<UserInfo> userInfos0=userService.findUserInfo(userInfo);
		if(null==userInfos0 || userInfos0.size()==0) {
			Integer num=userService.insertUserInfo(userInfo0);
			System.err.println("@@@@@@@@@"+num);
			json.put("msg",num);
		}else {
			json.put("msg",999);
		}
		return json;	
	}
	//修改用户
	@RequestMapping("/updateUser.action")
	@ResponseBody
	public void updateUser(Integer userId1,UserInfo userInfo0,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.out.println(userInfo0+"&&&&&&&&&&&"+userId1+"&&&&&&&&&&&&"+new Date()+"$$$"+pageNum+"***"+pageSize);
		HttpSession session=request.getSession();
		/*PrintWriter out= response.getWriter();
		UserInfo userInfo=new UserInfo();
		userInfo.setUserCode(userInfo0.getUserCode());
		UserInfo userInfos0=userService.findUserInfo(userInfo).get(0);
		session.setAttribute("UPDATEUSER", userInfos0);*/
		Integer updateBy=((UserInfo)session.getAttribute("USER")).getCreateBy();
		if(null!=userId1) {
			userInfo0.setUserId(userId1);
		}
		userInfo0.setUpdateBy(updateBy);
		userInfo0.setUpdateTime(new Date());
		Integer num=userService.updateUserInfo(userInfo0);
		System.err.println("@@@@@@@@@"+num);
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("pageSize",pageSize);
		//request.setAttribute("num",num);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//查询角色
	@RequestMapping("/findRole.action")
	@ResponseBody
	public void findRole(Integer userId,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("&&&&&&&&&&&"+userId+"&&&&&&&&&&&&"+new Date()+"$$$"+"***");
		PrintWriter out = response.getWriter();
		UserRole userRole0=new UserRole();
		userRole0.setUserId(userId);
		List<UserRole> userRoles=userService.findUserRole(userRole0);
		System.out.println(userRoles);
		for(UserRole ur:userRoles) {
			System.err.println("&&&&"+ur.getRoleId());
		}
		JSONArray jsonArry=JSONArray.fromObject(userRoles);
		out.print(jsonArry);
	}
	//修改用户角色
	@RequestMapping("/updateUserRole.action")
	@ResponseBody
	@Transactional
	public void updateUserRole(Integer userId,Integer[] roleIds,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("&&&&&&&&&&&"+userId+"&&&&&&&&&&&&");
		int num=0;
		UserRole userRole0=new UserRole();
		userRole0.setUserId(userId);
		userService.deleteUserRole(userRole0);
		if(roleIds!=null && roleIds.length!=0) {
			for(int i=0;i<roleIds.length;i++) {
				System.err.println("%%%%%%%"+roleIds[i]);
				userRole0.setRoleId(roleIds[i]);
				num+=userService.insertUserRole(userRole0);
			}
		}
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//查询用户权限
	@RequestMapping("/findUserAuth.action")
	@ResponseBody
	public void findUserAuth(Integer userId,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("****"+userId+"^^^^^");
		UserInfo user0=new UserInfo();
		user0.setUserId(userId);
		UserInfo user=userService.findUserInfo(user0).get(0);
		
		HttpSession session = request.getSession();
		JSONArray jsonArray=new JSONArray();
		AuthInfo authInfo0=new AuthInfo();
		authInfo0.setAuthState("1");
		List<AuthInfo> authInfos0=userService.findAuth(authInfo0);
		
		UserAuth userAuth0=new UserAuth();
		userAuth0.setUserId(userId);
		List<UserAuth> userAuths0=userService.findUserAuth(userAuth0);
		//id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中
		for(AuthInfo auth0:authInfos0){
			JSONObject json=new JSONObject();
			json.put("id", auth0.getAuthId());
			json.put("pId", auth0.getParentId());
			json.put("name", auth0.getAuthName());
			for(UserAuth auth:userAuths0) {
				if(auth.getAuthId()==auth0.getAuthId()){
					json.put("open", true);
					json.put("checked", true);
				}
			}
			jsonArray.add(json);
		}
		request.setAttribute("userId1", userId);
		request.setAttribute("userCode1", user.getUserCode());
		session.setAttribute("USERAUTH", jsonArray);
		request.getRequestDispatcher("../pages/userAuth.jsp").forward(request, response);
	}
	//修改用户权限
	@RequestMapping("/updateUserAuth.action")
	@ResponseBody
	@Transactional
	public void updateUserAuth(Integer userId,String authIdStr,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("****"+userId+"^^^^^"+authIdStr);
		int num=0;
		String [] authIds=null;
		UserAuth userAuth0=new UserAuth();
		userAuth0.setUserId(userId);
		userService.deleteUserAuth(userAuth0);
		if(null != authIdStr && authIdStr !="") {
			authIds=authIdStr.split(",");
			for(int i=0;i<authIds.length;i++) {
				System.err.println("%%%%%%%"+authIds[i]);
				userAuth0.setAuthId(Integer.parseInt(authIds[i]));
				num+=userService.insertUserAuth(userAuth0);
			}
		}
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//导出数据
	@RequestMapping("/asData.action")
	@ResponseBody
	public void asData(Integer dataNo,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		HttpSession session = request.getSession();
		List<?> data=null;
		if(dataNo==0) {
			data=(List<UserInfo>)session.getAttribute("USERLIST");
		}else if(dataNo==1) {
			data=((PageUtil)session.getAttribute("page")).getResultList();
		}
		request.setAttribute("data", data);
		request.getRequestDispatcher("../pages/user-list-download.jsp").forward(request, response);
	}
}
