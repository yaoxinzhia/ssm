package com.sz.service;

import com.sz.pojo.AppCategory;

import java.util.List;

public interface AppCategoryService {
    List<AppCategory> queryAllLevelOne();

    List<AppCategory> queryLevelTwoByLevelOne(Long id);

    List<AppCategory> queryLevelThreeByLevelTwo(Long id);
}
