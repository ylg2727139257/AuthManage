package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoleMapper;
import com.service_interface.RoleService;
import com.vo.Role;
import com.vo.RoleAuth;

@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleMapper roleMapper;
	//查询
	@Override
	public List<Role> findRoleList(HashMap<String,Object> hashmap) {
		return roleMapper.findRoleList(hashmap);
	}
	//添加
	@Override
	public Integer insertRole(Role role) {
		return roleMapper.insertRole(role);
	}
	//修改
	@Override
	public Integer updateRole(Role role) {
		return roleMapper.updateRole(role);
	}
	//删除
	@Override
	public Integer deleteRole(Integer roleId) {
		return roleMapper.deleteRole(roleId);
	}
	//查询角色权限
	@Override
	public List<RoleAuth> findRoleAuth(RoleAuth roleAuth) {
		return roleMapper.findRoleAuth(roleAuth);
	}
	//添加
	@Override
	public Integer insertRoleAuth(RoleAuth roleAuth) {
		return roleMapper.insertRoleAuth(roleAuth);
	}
	//删除
	@Override
	public Integer deleteRoleAuth(RoleAuth roleAuth) {
		return roleMapper.deleteRoleAuth(roleAuth);
	}
	
	
}
