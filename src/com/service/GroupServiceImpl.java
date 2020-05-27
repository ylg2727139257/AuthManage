package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.UserGroupMapper;
import com.service_interface.GroupService;
import com.vo.GroupRole;
import com.vo.UserGroup;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private UserGroupMapper userGroupMapper;
	//查询
	@Override
	public List<UserGroup> findGroup(HashMap<String,Object> hashmap) {
		return userGroupMapper.findGroup(hashmap);
	}
	//添加
	@Override
	public Integer insertGroup(UserGroup group) {
		return userGroupMapper.insertGroup(group);
	}
	//修改
	@Override
	public Integer updateGroup(UserGroup group) {
		return userGroupMapper.updateGroup(group);
	}
	//删除
	@Override
	public Integer deleteGroup(Integer groupId) {
		return userGroupMapper.deleteGroup(groupId);
	}
	//查询用户组角色
	@Override
	public List<GroupRole> findGroupRole(GroupRole groupRole) {
		return userGroupMapper.findGroupRole(groupRole);
	}
	//添加
	@Override
	public Integer insertGroupRole(GroupRole groupRole) {
		return userGroupMapper.insertGroupRole(groupRole);
	}
	//删除
	@Override
	public Integer deleteGroupRole(GroupRole groupRole) {
		return userGroupMapper.deleteGroupRole(groupRole);
	}
	
	
}
