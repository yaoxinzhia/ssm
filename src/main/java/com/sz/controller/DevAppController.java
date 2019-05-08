package com.sz.controller;

import com.github.pagehelper.PageInfo;
import com.sz.dto.AppInfoDTO;
import com.sz.pojo.AppCategory;
import com.sz.pojo.AppInfo;
import com.sz.pojo.DataDictionary;
import com.sz.pojo.DevUser;
import com.sz.service.AppCategoryService;
import com.sz.service.AppInfoService;
import com.sz.service.DataDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/app")
public class DevAppController {

    @Autowired
    private AppInfoService appInfoService;

    @Autowired
    private DataDictionaryService dataDictionaryService;

    @Autowired
    private AppCategoryService appCategoryService;

    // 分页显示主题区域
    @RequestMapping("/index/devId/{id}")
    public String index(@PathVariable("id") Long id, Model model, HttpSession session){
        session.setAttribute("USER_ID",id);

        // PageHelper中PageInfo成员属性
        PageInfo<AppInfo> pageInfo = new PageInfo<>();
        // PageSize: 每一页的数量
        pageInfo.setPageSize(5);
        // PageNum: 当前页
        pageInfo.setPageNum(1);
        pageInfo = appInfoService.queryByDevUserId(id,pageInfo);

        // 查询所有的平台
        List<DataDictionary> appFlatform = appInfoService.queryAllFlatForms();
        // 查询所有的APP状态
        List<DataDictionary> appStatus = appInfoService.queryAllAppStatus();
        // 查询所有的一级分类
        List<AppCategory> levelOne = appCategoryService.queryAllLevelOne();


        model.addAttribute("page",pageInfo);
        model.addAttribute("appFlatForms",appFlatform);
        model.addAttribute("appStatus",appStatus);
        model.addAttribute("levelOne",levelOne);

        return "app/index";
    }


    // 立即提交功能块
    @RequestMapping("/query")
    public String query(AppInfoDTO appInfoDTO, Model model,HttpSession session){
        Object obj = session.getAttribute("USER_ID");
        if(obj != null){
            long userId = (long) obj;

            /*if(appInfoDTO == null){
                appInfoDTO = new AppInfoDTO();
                appInfoDTO.setPageNum(1);
            }*/

            appInfoDTO.setDevUserId(userId);

            PageInfo<AppInfo> pageInfo = appInfoService.query(appInfoDTO);

            // 查询所有的平台
            List<DataDictionary> appFlatform = appInfoService.queryAllFlatForms();
            // 查询所有的APP状态
            List<DataDictionary> appStatus = appInfoService.queryAllAppStatus();
            // 查询所有的一级分类
            List<AppCategory> levelOne = appCategoryService.queryAllLevelOne();

            model.addAttribute("appFlatForms",appFlatform);
            model.addAttribute("appStatus",appStatus);
            model.addAttribute("levelOne",levelOne);
            model.addAttribute("page",pageInfo);
            model.addAttribute("appInfoDTO",appInfoDTO);
            return "app/index";
        } else {
            return "redirect:/";
        }
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model){

        // 查询所有的一级分类
        List<AppCategory> levelOne = appCategoryService.queryAllLevelOne();
        // 查询所有的APP状态
        List<DataDictionary> appStatus = appInfoService.queryAllAppStatus();
        // 查询所有的平台
        List<DataDictionary> appFlatform = appInfoService.queryAllFlatForms();
        model.addAttribute("appStatus",appStatus);
        model.addAttribute("levelOne",levelOne);
        model.addAttribute("appFlatForms",appFlatform);
        return "app/add";
    }

    @RequestMapping("/add")
    public String add(AppInfo appInfo, HttpSession session){
        // 要知道开发这是谁
        Object obj = session.getAttribute("USER_ID");
        long userId = (long) obj;


        boolean flag = appInfoService.add(appInfo,userId);

        // 转发到action
        return "redirect:/app/index/devId/" + userId;
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, HttpSession session){
        Object uid = session.getAttribute("USER_ID");
        long userId = (long) uid;

        boolean flag = appInfoService.delete(id);

        return "redirect:/app/index/devId/" + userId;
    }

    @RequestMapping("/toEdit/{id}")
    public String toEdit(@PathVariable("id") Long id, HttpSession session,Model model){
        AppInfo appInfo = appInfoService.queryById(id);

        // 查询所有的一级分类
        List<AppCategory> levelOne = appCategoryService.queryAllLevelOne();
        // 查询所有的APP状态
        List<DataDictionary> appStatus = appInfoService.queryAllAppStatus();
        // 查询所有的平台
        List<DataDictionary> appFlatform = appInfoService.queryAllFlatForms();
        model.addAttribute("appStatus",appStatus);
        model.addAttribute("levelOne",levelOne);
        model.addAttribute("appFlatForms",appFlatform);

        model.addAttribute("app",appInfo);
        return "app/edit";
    }

    @RequestMapping("/edit")
    public String edit(AppInfo appInfo, Model model, HttpSession session){
        Object uid = session.getAttribute("USER_ID");
        Long userId = Long.parseLong(uid.toString());
        DevUser devUser = new DevUser();
        devUser.setId(userId);
        appInfo.setCreateUser(devUser);
        appInfo.setModifyUser(devUser);
        appInfo.setDevUser(devUser);

        appInfoService.update(appInfo);
        return "redirect:/app/query";
    }


}
