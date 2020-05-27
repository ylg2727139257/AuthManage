package com.service_interface;

import java.util.HashMap;
import java.util.List;

import com.vo.Role;
import com.vo.RoleAuth;

public interface RoleService {
	//查询
	public List<Role> findRoleList(HashMap<String,Object> hashmap);
	//添加
	public Integer insertRole(Role role);
	//修改
	public Integer updateRole(Role role);
	//删除
	public Integer deleteRole(Integer roleId);
	
	//查询角色权限
	public List<RoleAuth> findRoleAuth(RoleAuth roleAuth);
	//添加
	public Integer insertRoleAuth(RoleAuth roleAuth);
	//删除
	public Integer deleteRoleAuth(RoleAuth roleAuth);
}
