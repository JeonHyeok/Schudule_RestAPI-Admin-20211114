package com.web.smp.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.conf.BooleanPropertyDefinition.AllowableValues;
import com.web.smp.dao.interf.ScheduleDao;
import com.web.smp.di.entity.AllViewEntity;
import com.web.smp.di.entity.Schedule;

public class ScheduleJdbcDao implements ScheduleDao {
	private String driver;
	private String url;
	private String userName;
	private String password;

	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	public ScheduleJdbcDao(String driver, String url, String userName, String password) {
		this.driver = driver;
		this.url = url;
		this.userName = userName;
		this.password = password;
	}

	private void connect() throws ClassNotFoundException, SQLException {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, userName, password);
		
		//System.out.println("ScheduleJdbcDao  DB연결성공");
	}

	private void disconnect() throws SQLException {
		//System.out.println("ScheduleJdbcDao");
		
		if (rs != null && !rs.isClosed()) {
			rs.close();
			rs = null;
		}
		if (stmt != null && !stmt.isClosed()) {
			stmt.close();
			stmt = null;
		}
		if (conn != null && !conn.isClosed()) {
			conn.close();
			conn = null;
		}
	}

	@Override
	public Schedule getSchedule(int schedule_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AllViewEntity> getScheduleList(String query,String categoryNo) {
		//view에 따라서 출력 - v_schedule_for1
		List<AllViewEntity> scheduleList = null;
		String sql = "select * from v_schedule_all";
		sql = sql + (query != null && !query.equals("") ? " WHERE category = "+categoryNo +" AND "+ query : " ORDER BY rsv_date");
		
		System.out.println("getScheduleList함수 sql>>" + sql);
		try {
			connect();

			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.isBeforeFirst()) {
				scheduleList = new ArrayList<AllViewEntity>();

				while (rs.next()) {
					AllViewEntity schedule = new AllViewEntity();
					schedule.setSchedule_seq(rs.getInt("schedule_seq"));
					schedule.setCategory(rs.getInt("category"));
					schedule.setMain_content(rs.getString("main_content"));
					schedule.setSub_content(rs.getString("sub_content"));
					schedule.setUser_type(rs.getString("user_type"));
					schedule.setUser_id(rs.getString("user_id"));
					schedule.setUser_name(rs.getString("user_name"));
					schedule.setRsv_date(rs.getString("rsv_date"));//2021-10-24
					schedule.setStart_time(rs.getString("start_time").substring(0, 5));//09:00:00 -> 09:00 
					schedule.setEnd_time(rs.getString("end_time").substring(0, 5));
					scheduleList.add(schedule);
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				disconnect();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return scheduleList;
	}

	@Override
	public int deleteSchedule(int schedule_seq) {
		String sql = "delete FROM schedule WHERE schedule_seq = ?";
		System.out.println("deleteSchedule 함수 실행 준비");
		int result = 0;
		try {
			connect();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, schedule_seq);
			
			result = stmt.executeUpdate();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				disconnect();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
}
