package com.dao;

import java.util.HashMap;
import java.util.List;

import com.vo.GroupRole;
import com.vo.UserGroup;

public interface UserGroupMapper {
	//查询用户组
	public List<UserGroup> findGroup(HashMap<String,Object> hashmap);
	//添加
	public Integer insertGroup(UserGroup group);
	//修改
	public Integer updateGroup(UserGroup group);
	//删除
	public Integer deleteGroup(Integer groupId);
	
	//查询用户角色
	public List<GroupRole> findGroupRole(GroupRole groupRole);
	//添加
	public Integer insertGroupRole(GroupRole groupRole);
	//删除
	public Integer deleteGroupRole(GroupRole groupRole);


}