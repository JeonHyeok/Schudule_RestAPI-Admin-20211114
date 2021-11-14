package com.web.smp.controller;

import java.util.List;

import com.web.smp.di.entity.AllViewEntity;
import com.web.smp.di.entity.Content;
import com.web.smp.di.entity.Schedule;
import com.web.smp.di.entity.User;

public interface SmpService {
	/* User Dao */
	boolean loginAvailability(String id,String pwd);

	User getUser(String id);

	String getUserName(String id);

	List<User> getUserList(String query);

	/* Content Dao */
	Content getContent(int content_seq);

	List<Content> getContentList(String query);

	List<String> getMainCategory(int category);

	List<String> getSubCategory(String query);

	/* Schdule Dao */
	Schedule getSchedule(int schedule_seq);

	List<AllViewEntity> getScheduleList(String query,String category);
	
	int deleteSchedule(int schedule_seq);
}
