package com.sz.controller;

import com.sz.pojo.AppCategory;
import com.sz.service.AppCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/category")
public class AppCategoryController {

    @Autowired
    private AppCategoryService appCategoryService;

    /**
     * @responseBody
     *
     * 注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，
     * 写入到response对象的body区，通常用来返回JSON数据或者是XML
     */
    @RequestMapping("/queryLevelTwoByLevelOne/{levelOneId}")
    @ResponseBody
    public List<AppCategory> queryLevelTwoByLevelOne(@PathVariable("levelOneId") Long id){
        List<AppCategory> levelTwo = appCategoryService.queryLevelTwoByLevelOne(id);
        return levelTwo;
    }

    @RequestMapping("/queryLevelThreeByLevelTwo/{levelTwoId}")
    @ResponseBody
    public List<AppCategory> queryLevelThreeByLevelTwo(@PathVariable("levelTwoId") Long id){
        List<AppCategory> levelThree = appCategoryService.queryLevelThreeByLevelTwo(id);
        return levelThree;
    }
}
