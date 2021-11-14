package com.web.smp.controller.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.smp.controller.SmpService;
import com.web.smp.di.entity.AllViewEntity;

public class ApiScheduleController implements ControllerInterface {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response, SmpService smpService) {
		String returnMassage = null;
		ObjectMapper mapper = new ObjectMapper();

		String method = request.getMethod().toUpperCase();// 요청메소드를 모두 대문자로반환 post -> POST
		String path = request.getRequestURI();
		String[] temp = path.split("/");
		String query = request.getQueryString();
		System.out.println("ApiScheduleController path >>" + path + "?" + query);

		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String week = request.getParameter("week");
		String id = request.getParameter("id");
		String searchSelect = request.getParameter("searchSelect");
		String textValue = request.getParameter("textValue");
		if (textValue != null) {
			try {// 카테고리이름 한글 디코딩처리 - URLDecoder.decode(NAME, "UTF-8")
				textValue = URLDecoder.decode(textValue, "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
		String categoryNo = temp[3];
		String seq = request.getParameter("seq");
		/*
		 * System.out.println(temp[3]); //btn1
		 */

		// GET
		// /api/schedules - schedules 전체목록반환
		// /api/schedules/[카테고리번호] - 특정 category 에서만 사용되는 schedules 정보가져오기
		// /api/schedules/[카테고리번호] ? id=2018 & year=x & month=x
		// /api/schedules/[카테고리번호] ? year=x & month=x & week=0
		// /api/schedules/[카테고리번호] ? searchSelect=user_name & textValue=홍길동
		//String[] temp = path.split("/");
		//String query = request.getQueryString();
		//System.out.println("ApiScheduleController path >>"+path+"?"+query);
		
		//String year = request.getParameter("year");
		//String month = request.getParameter("month");
		//String week = request.getParameter("week");
		//String id = request.getParameter("id");
		
		//String categoryNo = temp[3];
		
		// week 처리용 해당 주차 처음 날과 마지막 날
		String firstweekday = request.getParameter("fwd");
		String lastweekday = request.getParameter("lwd");

		// month, firstweekday, lastweekday가 한자리라면 앞에 0을 추가함
		if (month != null && firstweekday != null && lastweekday != null) {
			if (month.length() == 1) {
				month = "0" + month;
			}
			if (firstweekday.length() == 1) {
				firstweekday = "0" + firstweekday;
			}
			if (lastweekday.length() == 1) {
				lastweekday = "0" + lastweekday;
			}
		}
		
		// firstweekday, lastweekday를 정수로 변환후 서로 비교하여 lastweekday보다 firstweekday가 더 크면
		// db검색할 때 마지막 월을 1증가시켜 검색!
		int temp_fwd, temp_lwd, t_month;
		String lastmonth = month;
		if (firstweekday != null && lastweekday != null) {
			temp_fwd = Integer.parseInt(firstweekday);
			temp_lwd = Integer.parseInt(lastweekday);

			if (temp_lwd < temp_fwd) {
				t_month = Integer.parseInt(month) + 1;
				lastmonth = Integer.toString(t_month);
			}
		}
		
		// GET
		// /api/schedules - schedules 전체목록반환
		// /api/schedules/[카테고리번호] - 특정 category 에서만 사용되는 schedules 정보가져오기
		// /api/schedules/[카테고리번호] ? id=2018  &  year=x & month=x
		// /api/schedules/[카테고리번호] ? year=x & month=x & week=0  
		// /api/schedules/[카테고리번호] ? serchSelect = user_name & textValue=홍길동
		
		// POST
		// /api/schedules - 새로운 schedules 정보 생성하기

		// UPDATE
		// /api/schedules/[카테고리번호] ? - 특정 schedules 정보 수정하기

		// DELETE
		// /api/schedules/[카테고리번호] ? - 특정 schedules 정보 삭제하기

		if (temp.length == 3) {// /api/schedules
			if (method.equals("GET")) {// schedules 전체목록 가져오기
				// 필요하지 않음
				System.out.println("모든 schedules정보 조회 - ApiScheduleController - GET");
			} else if (method.equals("POST")) {// 새로운 schedules 정보 생성하기
				// POST : /api/schedules
				// OR
				// POST : /api/schedules/[카테고리번호]

				System.out.println("새로운 schedules정보 생성 - ApiScheduleController - POST");

			} else if (method.equals("DELETE")) {

				/*
				 * System.out.println("DELETE METHOD 실행");
				 * 
				 * int result = smpService.deleteSchedule(Integer.parseInt(seq)); if(result ==
				 * 1) { System.out.println("DELETE 성공"); } else if (result == 0) {
				 * System.out.println("DELETE 실패"); }
				 */

				System.out.println("DELETE method");

			}
		} else if (temp.length > 3) {// /api/schedules/temp[4] ? query
			if (query == null) {// /api/schedules/[카테고리번호]
				if (method.equals("GET")) {// schedules 카테고리번호것만 가져오기
					System.out.println("카테고리 번호 : " + categoryNo);
					List<AllViewEntity> ScheduleList = smpService.getScheduleList("schedule_seq > 0", categoryNo);
					try {
						returnMassage = mapper.writeValueAsString(ScheduleList);
					} catch (JsonProcessingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				} else if (method.equals("POST")) {// 카테고리번호의 새로운 schedules정보 생성하기
					System.out.println("새로운 schedules정보 생성 - ApiScheduleController - POST");
				}
			} else if (query != null) {// /api/schedules?year=2021&month=10&week=0
				// 해당가져오기
				if (id != null) { // id정보로 해당 schedules 내용 조회
					if (method.equals("GET")) {// 특정 id의 schedules 정보가져오기

					} else if (method.equals("UPDATE")) {// 특정 id의 schedule 정보 수정하기

					} else if (method.equals("DELETE")) {// 특정 id의 schedule 정보 삭제하기

					}
				} else if (searchSelect != null) {
					System.out.println(searchSelect);
					System.out.println(textValue);
					textValue = "'" + textValue + "'";
					String sql = searchSelect + "=" + textValue;
					System.out.println(sql);
					List<AllViewEntity> scheduleList = smpService.getScheduleList(sql, categoryNo);// 해당카테고리중 특정 id만
					try {
						returnMassage = mapper.writeValueAsString(scheduleList);
					} catch (JsonProcessingException e) {
						e.printStackTrace();
					}
				} else if (seq != null) {
					System.out.println("DELETE METHOD 실행");

					int result = smpService.deleteSchedule(Integer.parseInt(seq));
					if (result == 1) {
						System.out.println("DELETE 성공");
						returnMassage = "DELETE Success";
						return returnMassage;
					} else if (result == 0) {
						System.out.println("DELETE 실패");
					}
				} else { // 날짜 정보로 해당 schedules 내용 조회
					if (method.equals("GET")) {
						if (week.equals("0")) { // monthly DATA 구하기
							String sql = "year(rsv_date) = " + year + " AND month(rsv_date) = " + month;
							List<AllViewEntity> scheduleList = smpService.getScheduleList(sql, categoryNo);// 해당카테고리에 전체
							try {
								returnMassage = mapper.writeValueAsString(scheduleList);
							} catch (JsonProcessingException e) {
								e.printStackTrace();
							}
						} else {// weekly DATA 구하기
							System.out.println("Weekly Data 실행!");
							String sql = "rsv_date BETWEEN date('" + year + month + firstweekday + "')" + 
									" AND date('" + year + lastmonth + lastweekday + "')";
							System.out.println("sql문출력 >>"+sql);
							List<AllViewEntity> rsvAllList = smpService.getScheduleList(sql, categoryNo);
							try {
								returnMassage = mapper.writeValueAsString(rsvAllList);
							} catch (JsonProcessingException e) {
								e.printStackTrace();
							}
						}
					}
				}
			}

		}
		System.out.println("returnMassage >>" + returnMassage);
		return returnMassage;
	}

}
