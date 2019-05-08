package com.sz.service;

import com.github.pagehelper.PageInfo;
import com.sz.dto.AppInfoDTO;
import com.sz.pojo.AppInfo;
import com.sz.pojo.DataDictionary;

import java.util.List;

public interface AppInfoService {
    PageInfo<AppInfo> queryByDevUserId(Long id,PageInfo pageInfo);

    List<DataDictionary> queryAllAppStatus();

    List<DataDictionary> queryAllFlatForms();

    PageInfo<AppInfo> query(AppInfoDTO appInfoDTO);

    boolean add(AppInfo appInfo, Long userId);

    boolean delete(Long id);

    AppInfo queryById(Long id);

    void update(AppInfo appInfo);
}
