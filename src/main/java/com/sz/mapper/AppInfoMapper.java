package com.sz.mapper;

import com.sz.dto.AppInfoDTO;
import com.sz.pojo.AppInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AppInfoMapper {
//    List<AppInfo> queryByDevUserId(@Param("devUserId") Long id);

    List<AppInfo> query(AppInfoDTO appInfoDTO);

    int add(AppInfo appInfo);

    int deleteById(@Param("id") Long id);

    AppInfo queryById(@Param("id") Long id);

    void update(AppInfo appInfo);
}
