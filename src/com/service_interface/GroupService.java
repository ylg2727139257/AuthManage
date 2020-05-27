package com.service_interface;

import java.util.HashMap;
import java.util.List;

import com.vo.GroupRole;
import com.vo.UserGroup;

public interface GroupService {
	//查询用户组
	public List<UserGroup> findGroup(HashMap<String,Object> hashmap);
	//添加
	public Integer insertGroup(UserGroup userGroup);
	//修改	
	public Integer updateGroup(UserGroup userGroup);
	//删除
	public Integer deleteGroup(Integer groupId);
	
	//查询用户组角色
	public List<GroupRole> findGroupRole(GroupRole groupRole);
	//添加
	public Integer insertGroupRole(GroupRole groupRole);
	//删除
	public Integer deleteGroupRole(GroupRole groupRole);
}
