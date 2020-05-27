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

import com.service_interface.GroupService;
import com.service_interface.UserService;
import com.vo.GroupRole;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.UserGroup;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/group")
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	@Autowired
	private UserService userService;
	//用户组列表
	@RequestMapping("/list.action")
	@ResponseBody
	public void list(Integer num,Integer pageSize,Integer pageNum,String groupName0,
			String groupState0,HttpServletRequest request,HttpServletResponse response)
					throws IOException, ServletException{
		HttpSession session=request.getSession();
		System.err.println(groupName0+"&&&&&&&&&&&&&"+"***********"+groupState0+"&&&"+num);
//		TODO    How do you set 'pageSize'?	
		num=null==num?0:num;
		pageNum=null==pageNum ? 1 : pageNum;
		pageSize=null==pageSize ? 5 : pageSize;
		groupName0=null==groupName0?"":groupName0.trim();
		groupState0=null==groupState0?"":groupState0.trim();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		UserGroup group=new UserGroup(groupName0,groupState0);
		map.put("group",group);
		List<UserGroup> groups0=userService.findGroup(map);
		//session.setAttribute("USERLIST", groups0);
		
		PageUtil pageUtil0=new PageUtil(pageSize,pageNum);
		map.put("page", pageUtil0);
		List<UserGroup> groups=userService.findGroup(map);
		
		StringBuffer params=new StringBuffer();
		params.append("groupName0="+groupName0);
		params.append("&groupState0="+groupState0);
		
		PageUtil pageUtil = new PageUtil(pageSize,groups0.size(),pageNum,groups,
				"group/list.action",params);
		session.setAttribute("page", pageUtil);
		
		request.setAttribute("groupName", groupName0);
		request.setAttribute("groupState", groupState0);
		request.setAttribute("num", num);
		
		Role role0=new Role();
		role0.setRoleState("1");
		List<Role> roles=userService.findRole(role0);
		session.setAttribute("GROUPROLES", roles);
		
		request.getRequestDispatcher("../pages/group-list.jsp").forward(request, response);  
	}
	//添加用户组--用户组名可用
	@RequestMapping("/ableGroup.action")
	@ResponseBody
	public JSONObject ableGroup(String groupName,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		JSONObject json=new JSONObject();
		UserGroup group0=new UserGroup();
		group0.setGroupName(groupName);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("group", group0);
		List<UserGroup> groups0=userService.findGroup(map);
		json.put("flag", groups0.size()==0?1:0);
		return json;
	}
	//添加用户组
	@RequestMapping("/addGroup.action")
	@ResponseBody
	public JSONObject addGroup(UserGroup group0,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		System.err.println(group0+"&&&&&&&&&&&&&&&&&&&&&&&"+new Date()+"$$$");
//		HttpSession session=request.getSession();
		JSONObject json=new JSONObject();
		HashMap<String,Object> map = new HashMap<String,Object>();
		UserGroup group=new UserGroup();
		group.setGroupName(group0.getGroupName());
		map.put("group", group);
		List<UserGroup> groups0=userService.findGroup(map);
		if(null==groups0 || groups0.size()==0) {
			Integer num=groupService.insertGroup(group0);
			System.err.println("@@@@@@@@@"+num);
			json.put("msg",num);
		}else {
			json.put("msg",'n');
		}
		return json;	
	}
	//修改用户组
	@RequestMapping("/updateGroup.action")
	@ResponseBody
	public void updateGroup(UserGroup group0,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.out.println(group0+"&&&&&&&&&&&&&&&&&&&&&&&"+new Date()+"$$$"+pageNum+"***"+pageSize);
//		HttpSession session=request.getSession();
		
		Integer num=groupService.updateGroup(group0);
		System.err.println("@@@@@@@@@"+num);
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("pageSize",pageSize);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//删除用户组
	@RequestMapping("/deleteGroup.action")
	@ResponseBody
	public void deleteGroup(Integer groupId,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		Integer num=groupService.deleteGroup(groupId);
		System.out.println(groupId+"&&&&&&&&&&&&&&&&&&&&&&&"+num+"$$$"+pageNum+"***"+pageSize);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("pageSize",pageSize);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//查询角色
	@RequestMapping("/findRole.action")
	@ResponseBody
	public void findRole(Integer groupId,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("&&&&&&&&&&&"+groupId+"&&&&&&&&&&&&"+new Date()+"$$$"+"***");
		PrintWriter out = response.getWriter();
		GroupRole groupRole0=new GroupRole();
		groupRole0.setGroupId(groupId);
		List<GroupRole> groupRoles=groupService.findGroupRole(groupRole0);
		System.out.println(groupRoles);
		for(GroupRole gr:groupRoles) {
			System.err.println("&&&&"+gr.getRoleId());
		}
		JSONArray jsonArry=JSONArray.fromObject(groupRoles);
		out.print(jsonArry);
	}
	//修改用户组角色
	@RequestMapping("/updateGroupRole.action")
	@ResponseBody
	@Transactional
	public void updateGroupRole(Integer groupId,Integer[] roleIds,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("&&&&&&&&&&&"+groupId+"&&&&&&&&&&&&");
		int num=0;
		GroupRole groupRole0=new GroupRole();
		groupRole0.setGroupId(groupId);
		groupService.deleteGroupRole(groupRole0);
		if(roleIds!=null && roleIds.length!=0) {
			for(int i=0;i<roleIds.length;i++) {
				System.err.println("%%%%%%%"+roleIds[i]);
				groupRole0.setRoleId(roleIds[i]);
				num+=groupService.insertGroupRole(groupRole0);
			}
		}
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	
	
	
}
