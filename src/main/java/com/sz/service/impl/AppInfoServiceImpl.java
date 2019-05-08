package com.sz.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sz.constant.CommonCodeCostant;
import com.sz.dto.AppInfoDTO;
import com.sz.mapper.AppInfoMapper;
import com.sz.mapper.DataDictionaryMapper;
import com.sz.pojo.AppInfo;
import com.sz.pojo.DataDictionary;
import com.sz.pojo.DevUser;
import com.sz.service.AppInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("appInfoService")
public class AppInfoServiceImpl implements AppInfoService {

    @Autowired
    private AppInfoMapper appInfoMapper;

    @Autowired
    private DataDictionaryMapper dataDictionaryMapper;

    @Override
    public PageInfo<AppInfo> queryByDevUserId(Long id,PageInfo pageInfo) {
        /**
         * startPage
         * 开始分页
         *
         * @param pageNum  页码
         * @param pageSize 每页显示数量
         */
        PageHelper.startPage(pageInfo.getPageNum(),pageInfo.getPageSize());
        AppInfoDTO a = new AppInfoDTO();
        a.setDevUserId(id);
        List<AppInfo> l = appInfoMapper.query(a);
        PageInfo<AppInfo> page = new PageInfo<AppInfo>(l);
        return page;
    }

    @Override
    public List<DataDictionary> queryAllAppStatus() {
        return dataDictionaryMapper.queryAllAppStatus();
    }

    @Override
    public List<DataDictionary> queryAllFlatForms() {
        return dataDictionaryMapper.queryAllFlatForms();
    }

    @Override
    public PageInfo<AppInfo> query(AppInfoDTO appInfoDTO) {
        // 分页

        if(appInfoDTO.getPageNum() == null){
            appInfoDTO.setPageNum(1);
        }

        PageHelper.startPage(appInfoDTO.getPageNum(), CommonCodeCostant.PAGE_SIZE);
        List<AppInfo> l = appInfoMapper.query(appInfoDTO);
        PageInfo<AppInfo> pageInfo = new PageInfo<AppInfo>(l);
        return pageInfo;
    }

    @Override
    public boolean add(AppInfo appInfo, Long userId) {
        // 第一个我们要先处理这些信息
        appInfo.setCreationDate(new Date());
        DevUser devUser = new DevUser();
        devUser.setId(userId);
        appInfo.setDevUser(devUser);
        appInfo.setCreatedBy(userId);

        DataDictionary dataDictionary = new DataDictionary();
        dataDictionary.setValueId(CommonCodeCostant.APP_STATUS_AUDITED);
        appInfo.setAppStatus(dataDictionary);

        // 新增
        int row = appInfoMapper.add(appInfo);
        return false;
    }

    @Override
    public boolean delete(Long id) {
        if(id != null){
            int row = appInfoMapper.deleteById(id);
            return row == 1 ? true:false;
        }
        return false;

    }

    @Override
    public AppInfo queryById(Long id) {
        return appInfoMapper.queryById(id);
    }

    @Override
    public void update(AppInfo appInfo) {
        appInfo.setModifyDate(new Date());
        appInfo.setUpdateDate(new Date());
        appInfoMapper.update(appInfo);
    }
}
