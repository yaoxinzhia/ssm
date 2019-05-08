package com.sz.service.impl;

import com.sz.mapper.DevUserMapper;
import com.sz.pojo.DevUser;
import com.sz.service.DevUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("devUserService")
public class DevUserServiceImpl implements DevUserService {

    @Autowired
    private DevUserMapper devUserMapper;

    @Override
    public DevUser login(DevUser devUser) {
        List<DevUser> users = devUserMapper.queryByNamePwd(devUser);
        if(users != null && users.size() == 1){
            return users.get(0);
        }
        return null;
    }
}
