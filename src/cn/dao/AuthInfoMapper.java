package cn.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import cn.vo.AuthInfo;
import cn.vo.AuthInfoExample;

public interface AuthInfoMapper {
    int countByExample(AuthInfoExample example);

    int deleteByExample(AuthInfoExample example);

    int deleteByPrimaryKey(Integer authId);

    int insert(AuthInfo record);

    int insertSelective(AuthInfo record);

    List<AuthInfo> selectByExample(AuthInfoExample example);

    AuthInfo selectByPrimaryKey(Integer authId);

    int updateByExampleSelective(@Param("record") AuthInfo record, @Param("example") AuthInfoExample example);

    int updateByExample(@Param("record") AuthInfo record, @Param("example") AuthInfoExample example);

    int updateByPrimaryKeySelective(AuthInfo record);

    int updateByPrimaryKey(AuthInfo record);
}