package com.sz.pojo;

import java.util.Date;
import java.util.List;

public class AppCategory {
	private Long id;//主键id
	private String categoryCode;//分类编码
	private String categoryName;//分类名称
	private Long parentId;//父级节点id
	private Long createdBy;//创建者
	private Date creationTime;//创建时间
	private Long modifyBy;//更新者
	private Date modifyDate;//更新时间

	private List<AppInfo> appInfos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public Long getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(Long modifyBy) {
		this.modifyBy = modifyBy;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public List<AppInfo> getAppInfos() {
		return appInfos;
	}

	public void setAppInfos(List<AppInfo> appInfos) {
		this.appInfos = appInfos;
	}
}
