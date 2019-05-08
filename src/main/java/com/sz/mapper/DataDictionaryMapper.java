package com.sz.mapper;

import com.sz.pojo.DataDictionary;

import java.util.List;

public interface DataDictionaryMapper {
    List<DataDictionary> queryAllAppStatus();

    List<DataDictionary> queryAllFlatForms();
}
