package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AuthInfoMapper;
import com.service_interface.AuthService;
import com.vo.AuthInfo;

@Service
public class AuthServiceImpl implements AuthService{

	@Autowired
	private AuthInfoMapper authInfoMapper;
	//修改
	@Override
	public Integer updateAuth(AuthInfo authInfo) {
		return authInfoMapper.updateAuth(authInfo);
	}
	//添加
	@Override
	public Integer addAuth(AuthInfo authInfo) {
		return authInfoMapper.addAuth(authInfo);
	}
	//删除
	@Override
	public Integer deleteAuth(AuthInfo authInfo) {
		return authInfoMapper.deleteAuth(authInfo);
	}
	
}
