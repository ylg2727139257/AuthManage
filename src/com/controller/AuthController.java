package com.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service_interface.AuthService;
import com.service_interface.UserService;
import com.vo.AuthInfo;
import com.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private AuthService authService;
	@Autowired
	private UserService userService;
	//权限树
	@RequestMapping("/list.action")
	@ResponseBody
	public void findAuth(Integer num,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		HttpSession session = request.getSession();
		JSONArray jsonArray=new JSONArray();
		List<AuthInfo> authInfos0=userService.findAuth(new AuthInfo());
		//id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中
		for(AuthInfo auth0:authInfos0){
			JSONObject json=new JSONObject();
			json.put("id", auth0.getAuthId());
			json.put("pId", auth0.getParentId());
			json.put("name", auth0.getAuthName());
			json.put("state", auth0.getAuthState());
			json.put("desc", auth0.getAuthDesc());
			json.put("grade", auth0.getAuthGrade());
			
			jsonArray.add(json);
		}
		num=null==num?0:num;
		session.setAttribute("AUTHS", jsonArray);
		request.setAttribute("num", num);
		request.getRequestDispatcher("../pages/authTree.jsp").forward(request, response);
	}
	//修改权限--权限名可用
	@RequestMapping("/ableAuth.action")
	@ResponseBody
	public JSONObject ableAuth(Integer authId,String authName,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		JSONObject json=new JSONObject();
		AuthInfo authInfo0=new AuthInfo();
		authInfo0.setAuthName(authName);
		List<AuthInfo> authInfos0=userService.findAuth(authInfo0);
		if(null==authInfos0||authInfos0.size()==0||authInfos0.get(0).getAuthId()==authId){
			json.put("flag",1);
		}else {
			json.put("flag",0);
		}
		return json;
	}
	//修改权限
	@RequestMapping("/updateAuth.action")
	@ResponseBody
	public JSONObject updateAuth(AuthInfo authInfo0,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println(authInfo0+"****"+"^^^^^");
		HttpSession session = request.getSession();
		JSONObject json=new JSONObject();
		/*AuthInfo authInfo=new AuthInfo();
		authInfo.setAuthName(authInfo0.getAuthName());
		List<AuthInfo> authInfos0=userService.findAuth(authInfo);*/
		Integer createBy=((UserInfo)session.getAttribute("USER")).getUserId();
		authInfo0.setUpdateBy(createBy);
		authInfo0.setUpdateTime(new Date());
		json.put("msg", authService.updateAuth(authInfo0));
		return json;
	}
	//添加权限
	@RequestMapping("/addAuth.action")
	@ResponseBody
	public void addAuth(AuthInfo authInfo0,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("****"+authInfo0+"^^^^^");
		HttpSession session = request.getSession();
//		PrintWriter out=response.getWriter();

//		authInfo0.setAuthType(authInfo0.getAuthGrade().toString());
		Integer createBy=((UserInfo)session.getAttribute("USER")).getUserId();
		authInfo0.setCreateBy(createBy);
		authInfo0.setCreateTime(new Date());
		authInfo0.setUpdateBy(createBy);
		authInfo0.setUpdateTime(new Date());
		
/*		AuthInfo authInfo1=new AuthInfo();
		authInfo1.setAuthName(authInfo0.getAuthName());
		List<AuthInfo> authInfos1=userService.findAuth(authInfo1);
		
		AuthInfo authInfo2=new AuthInfo();
		authInfo2.setAuthUrl(authInfo0.getAuthUrl());
		List<AuthInfo> authInfos2=userService.findAuth(authInfo2);
		
		AuthInfo authInfo3=new AuthInfo();
		authInfo3.setAuthCode(authInfo0.getAuthCode());
		List<AuthInfo> authInfos3=userService.findAuth(authInfo3);*/
		
		Integer num=0;
		/*if((null==authInfos1 || authInfos1.size()==0)
				&&(null==authInfos2 || authInfos2.size()==0)
				&&(null==authInfos3 || authInfos3.size()==0)){		
		}*/
		num=authService.addAuth(authInfo0);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//添加权限--权限名，code，url可用
	@RequestMapping("/ableNewAuth.action")
	@ResponseBody
	public JSONObject ableNewAuth(String authName,String authCode,String authUrl,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
//		System.err.println(authName+"?????????????"+authUrl+"|||||||"+authCode);
		JSONObject json=new JSONObject();
		AuthInfo authInfo1=new AuthInfo();
		List<AuthInfo> authInfos1=null;
		if(null!=authName&&authName!="") {
			authInfo1.setAuthName(authName);
			authInfos1=userService.findAuth(authInfo1);
		}
		AuthInfo authInfo2=new AuthInfo();
		List<AuthInfo> authInfos2=null;
		if(null!=authUrl&&authUrl!="") {
			authInfo2.setAuthUrl(authUrl);
			authInfos2=userService.findAuth(authInfo2);
		}
		AuthInfo authInfo3=new AuthInfo();
		List<AuthInfo> authInfos3=null;
		if(null!=authCode&&authCode!="") {
			authInfo3.setAuthCode(authCode);
			authInfos3=userService.findAuth(authInfo3);
		}
		if(null!=authInfos1&&authInfos1.size()>0){
			json.put("able",1);
		}else if(null!=authInfos2&&authInfos2.size()>0){
			json.put("able",2);
		}else if(null!=authInfos3&&authInfos3.size()>0){
			json.put("able",3);
		}else{
			json.put("able","n");
		}
		return json;
	}
	//删除权限
	@RequestMapping("/deleteAuth.action")
	@ResponseBody
	public void deleteAuth(Integer authId,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		AuthInfo authInfo0=new AuthInfo();
		authInfo0.setAuthId(authId);
		Integer num=authService.deleteAuth(authInfo0);
		System.out.println(authId+"&&&&&&&&&&&&&&&&&&&&&&&"+num+"$$$"+"***");
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	
	
}
