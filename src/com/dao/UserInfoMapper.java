package com.dao;

import com.vo.UserAuth;
import com.vo.UserInfo;
import com.vo.UserRole;

import java.util.HashMap;
import java.util.List;

public interface UserInfoMapper {
	//查询用户，用户组，角色
	public List<UserInfo> findUserList(HashMap<String,Object> hashMap);
	
	//查询用户
	public List<UserInfo> findUserInfo(UserInfo userInfo);
	//添加
	public Integer insertUserInfo(UserInfo userInfo);
	//修改
	public Integer updateUserInfo(UserInfo userInfo);
	
	//查询用户角色
	public List<UserRole> findUserRole(UserRole userRole);
	//删除
	public Integer deleteUserRole(UserRole userRole);
	//添加
	public Integer insertUserRole(UserRole userRole);
	
	//查询用户权限
	public List<UserAuth> findUserAuth(UserAuth userAuth);
	//删除
	public Integer deleteUserAuth(UserAuth userAuth);
	//添加
	public Integer insertUserAuth(UserAuth userAuth);
	
	
}