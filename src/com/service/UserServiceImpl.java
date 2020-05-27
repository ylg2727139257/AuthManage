package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AuthInfoMapper;
import com.dao.RoleMapper;
import com.dao.UserGroupMapper;
import com.dao.UserInfoMapper;
import com.service_interface.UserService;
import com.vo.AuthInfo;
import com.vo.Role;
import com.vo.UserAuth;
import com.vo.UserGroup;
import com.vo.UserInfo;
import com.vo.UserRole;


@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private AuthInfoMapper authInfoMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserGroupMapper userGroupMapper;
	//查询
	@Override
	public List<UserInfo> findUserInfo(UserInfo userInfo) {
		return userInfoMapper.findUserInfo(userInfo);
	}
	//查询所有权限
	@Override
	public List<AuthInfo> findAuthToIndex(HashMap<String, Object> hashMap) {
		return authInfoMapper.findAuthToIndex(hashMap);
	}
	//查询用户，用户组，角色
	@Override
	public List<UserInfo> findUserList(HashMap<String,Object> hashMap){
		return userInfoMapper.findUserList(hashMap);
	}
	//查询角色
	@Override
	public List<Role> findRole(Role role) {
		return roleMapper.findRole(role);
	}
	//查询用户组
	@Override
	public List<UserGroup> findGroup(HashMap<String,Object> hashmap) {
		return userGroupMapper.findGroup(hashmap);
	}
	//添加
	@Override
	public Integer insertUserInfo(UserInfo userInfo) {
		return userInfoMapper.insertUserInfo(userInfo);
	}
	//修改
	@Override
	public Integer updateUserInfo(UserInfo userInfo) {
		return userInfoMapper.updateUserInfo(userInfo);
	}
	//查询用户角色
	@Override
	public List<UserRole> findUserRole(UserRole userRole) {
		return userInfoMapper.findUserRole(userRole);
	}
	//删除
	@Override
	public Integer deleteUserRole(UserRole userRole) {
		return userInfoMapper.deleteUserRole(userRole);
	}
	//添加
	@Override
	public Integer insertUserRole(UserRole userRole) {
		return userInfoMapper.insertUserRole(userRole);
	}
	//查询权限
	@Override
	public List<AuthInfo> findAuth(AuthInfo authInfo) {
		return authInfoMapper.findAuth(authInfo);
	}
	//查询用户权限
	@Override
	public List<UserAuth> findUserAuth(UserAuth userAuth) {
		return userInfoMapper.findUserAuth(userAuth);
	}
	//删除
	@Override
	public Integer deleteUserAuth(UserAuth userAuth) {
		return userInfoMapper.deleteUserAuth(userAuth);
	}
	//添加
	@Override
	public Integer insertUserAuth(UserAuth userAuth) {
		return userInfoMapper.insertUserAuth(userAuth);
	}
	
	
}
