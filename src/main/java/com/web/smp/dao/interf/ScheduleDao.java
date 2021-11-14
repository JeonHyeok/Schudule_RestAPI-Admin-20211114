package com.web.smp.dao.interf;

import java.util.List;

import com.web.smp.di.entity.AllViewEntity;
import com.web.smp.di.entity.Schedule;

public interface ScheduleDao {
	Schedule getSchedule(int schedule_seq);
	
	List<AllViewEntity> getScheduleList(String query,String categoryNo);
	
	int deleteSchedule(int schedule_seq);
}
