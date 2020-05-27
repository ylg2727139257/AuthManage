package com.controller;

import java.io.IOException;
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

import com.service_interface.RoleService;
import com.service_interface.UserService;
import com.vo.AuthInfo;
import com.vo.PageUtil;
import com.vo.Role;
import com.vo.RoleAuth;
import com.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	//角色列表
	@RequestMapping("/list.action")
	@ResponseBody
	public void list(Integer num,Integer pageSize,Integer pageNum,String roleName0,
			String roleState0,HttpServletRequest request,HttpServletResponse response)
					throws IOException, ServletException{
		HttpSession session=request.getSession();
		System.err.println(roleName0+"&&&&&&&&&&&&&"+"***********"+roleState0+"&&&"+num);
//		TODO    How do you set 'pageSize'?	
		num=null==num?0:num;
		pageNum=null==pageNum ? 1 : pageNum;
		pageSize=null==pageSize ? 5 : pageSize;
		roleName0=null==roleName0?"":roleName0.trim();
		roleState0=null==roleState0?"":roleState0.trim();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		Role role=new Role(roleName0,roleState0);
		map.put("role",role);
		List<Role> roles0=roleService.findRoleList(map);
		//session.setAttribute("USERLIST", roles0);
		
		PageUtil pageUtil0=new PageUtil(pageSize,pageNum);
		map.put("page", pageUtil0);
		List<Role> roles=roleService.findRoleList(map);
		
		StringBuffer params=new StringBuffer();
		params.append("roleName0="+roleName0);
		params.append("&roleState0="+roleState0);
		
		PageUtil pageUtil = new PageUtil(pageSize,roles0.size(),pageNum,roles,
				"role/list.action",params);
		session.setAttribute("page", pageUtil);
		
		request.setAttribute("roleName", roleName0);
		request.setAttribute("roleState", roleState0);
		request.setAttribute("num", num);
		
		request.getRequestDispatcher("../pages/role-list.jsp").forward(request, response);  
	}
	//添加角色--可用的角色名
	@RequestMapping("/ableRole.action")
	@ResponseBody
	public JSONObject ableRole(String roleName,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		JSONObject json=new JSONObject();
		Role role0=new Role();
		role0.setRoleName(roleName);
		List<Role> roles0=userService.findRole(role0);
		json.put("flag", roles0.size()==0?1:0);
		return json;
	}
	//添加角色
	@RequestMapping("/addRole.action")
	@ResponseBody
	public JSONObject addRole(Role role0,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		System.err.println(role0+"&&&&&&&&&&&&&&&&&&&&&&&"+new Date()+"$$$");
		HttpSession session=request.getSession();
		JSONObject json=new JSONObject();
		Integer createBy=((UserInfo)session.getAttribute("USER")).getUserId();
		role0.setCreateBy(createBy);
		role0.setUpdateBy(createBy);
		role0.setCreateTime(new Date());
		role0.setUpdateTime(new Date());
		Role role=new Role();
		role.setRoleName(role0.getRoleName());
		List<Role> roles0=userService.findRole(role);
		if(null==roles0 || roles0.size()==0) {
			Integer num=roleService.insertRole(role0);
			System.err.println("@@@@@@@@@"+num);
			json.put("msg",num);
		}else {
			json.put("msg",'n');
		}
		return json;	
	}
	//修改角色
	@RequestMapping("/updateRole.action")
	@ResponseBody
	public void updateRole(Role role0,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.out.println(role0+"&&&&&&&&&&&&&&&&&&&&&&&"+new Date()+"$$$"+pageNum+"***"+pageSize);
		HttpSession session=request.getSession();
		
		Integer updateBy=((UserInfo)session.getAttribute("USER")).getCreateBy();
		role0.setUpdateBy(updateBy);
		role0.setUpdateTime(new Date());
		Integer num=roleService.updateRole(role0);
		System.err.println("@@@@@@@@@"+num);
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("pageSize",pageSize);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//删除角色
	@RequestMapping("/deleteRole.action")
	@ResponseBody
	public void deleteRole(Integer roleId,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		Integer num=roleService.deleteRole(roleId);
		System.out.println(roleId+"&&&&&&&&&&&&&&&&&&&&&&&"+num+"$$$"+pageNum+"***"+pageSize);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("pageSize",pageSize);
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
	//查询角色权限
	@RequestMapping("/findRoleAuth.action")
	@ResponseBody
	public void findRoleAuth(Integer roleId,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("****"+roleId+"^^^^^");
		HttpSession session = request.getSession();
		JSONArray jsonArray=new JSONArray();
		Role role0=new Role();
		role0.setRoleId(roleId);
		Role role=userService.findRole(role0).get(0);
		
		AuthInfo authInfo0=new AuthInfo();
		authInfo0.setAuthState("1");
		List<AuthInfo> authInfos0=userService.findAuth(authInfo0);
		
		RoleAuth roleAuth0=new RoleAuth();
		roleAuth0.setRoleId(roleId);
		List<RoleAuth> roleAuths0=roleService.findRoleAuth(roleAuth0);
		//id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中
		for(AuthInfo auth0:authInfos0){
			JSONObject json=new JSONObject();
			json.put("id", auth0.getAuthId());
			json.put("pId", auth0.getParentId());
			json.put("name", auth0.getAuthName());
			for(RoleAuth auth:roleAuths0) {
				if(auth.getAuthId()==auth0.getAuthId()){
					json.put("open", true);
					json.put("checked", true);
				}
			}
			jsonArray.add(json);
		}
		request.setAttribute("roleId1", roleId);
		request.setAttribute("roleName1", role.getRoleName());
		session.setAttribute("ROLEAUTH", jsonArray);
		request.getRequestDispatcher("../pages/roleAuth.jsp").forward(request, response);
	}
	//修改角色权限
	@RequestMapping("/updateRoleAuth.action")
	@ResponseBody
	@Transactional
	public void updateRoleAuth(Integer roleId,String authIdStr,HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException{
		System.err.println("****"+roleId+"^^^^^"+authIdStr);
		int num=0;
		String [] authIds=null;
		RoleAuth roleAuth0=new RoleAuth();
		roleAuth0.setRoleId(roleId);
		roleService.deleteRoleAuth(roleAuth0);
		if(null != authIdStr && authIdStr !="") {
			authIds=authIdStr.split(",");
			for(int i=0;i<authIds.length;i++) {
				System.err.println("%%%%%%%"+authIds[i]);
				roleAuth0.setAuthId(Integer.parseInt(authIds[i]));
				num+=roleService.insertRoleAuth(roleAuth0);
			}
		}
		request.getRequestDispatcher("list.action?num="+num).forward(request, response);
	}
}
