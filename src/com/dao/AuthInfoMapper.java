package com.dao;

import java.util.HashMap;
import java.util.List;

import com.vo.AuthInfo;

public interface AuthInfoMapper {
	//查询用户所有权限
    public List<AuthInfo> findAuthToIndex(HashMap<String,Object> hashMap);
    //查询权限
    public List<AuthInfo> findAuth(AuthInfo authInfo);
    //添加
    public Integer addAuth(AuthInfo authInfo);
    //修改
    public Integer updateAuth(AuthInfo authInfo);
    //删除
    public Integer deleteAuth(AuthInfo authInfo);
    
    
    
}