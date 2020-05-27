package com.service_interface;

import com.vo.AuthInfo;

public interface AuthService {
	//修改
	public Integer updateAuth(AuthInfo authInfo);
	//添加
	public Integer addAuth(AuthInfo authInfo);
	//删除
	public Integer deleteAuth(AuthInfo authInfo);
	
	
}
