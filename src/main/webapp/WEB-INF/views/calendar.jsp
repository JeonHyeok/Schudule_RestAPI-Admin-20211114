<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.12.1/css/all.css"
	integrity="sha384-v8BU367qNbs/aIZIxuivaU55N5GPF89WBerHoGA4QTcbUjYiLQtKdrfXnqAcXyTv"
	crossorigin="anonymous">

<link
	href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700'
	rel='stylesheet' type='text/css'>
<!--font-family: 'Roboto' 기본Font사용 URL -->

<link href="/css/calendarForm.css" rel="stylesheet" type="text/css">
<link href="/css/calendarMonth.css?ul" rel="stylesheet" type="text/css">
<link href="/css/calendarWeek.css?ddS" rel="stylesheet" type="text/css">
<link href="/css/calendarDialog.css" rel="stylesheet" type="text/css">
<link href="/css/common.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="/js/calendar.js?e"></script>
<body>
	<!--------------- HEADER ⊃  calendar_title,calendar_main-------------->
	<div class="headerContainer">
		<div class="calendar_title">
			<i class="far fa-calendar-check" id="icon_calendar"></i> <span
				class="calendar_title_logo">캘린더</span>
		</div>

		<div class="calendar_main">
			<div class="calendar_main_left">
				<button id="prev">&#60;</button>
				<span class="current-year-month"> </span>
				<button id="next">&#62;</button>
			</div>

			<div class="calendar_main_right">
				<input type="button" value="weekly" class="mwBtn headerBtn" />
				<!-- toggle -->
				<input type="button" value="today" class="todayBtn headerBtn" />
			</div>

		</div>
	</div>


	<!--------------- SECTION  ⊃  leftSection.studioContainer --------------->
	<div class="sectionContainer">
		<!------------- LEFT --------------->
		<div class="leftSection">
			<div class="userProfile">
				<div class="prifileTitle">
					<i class="far fa-user-circle fa-3x" id="icon_user"></i>
					<h2 class="profileName">${name}님</h2>
					<div>
						<span id="id">${id}</span>
					</div>
						<span id="categoryNo">${categorySession}</span>
				</div>
				<input type="button" value="스케쥴 현황" class="scheduleBtn" />
			</div>
			<div class="contentContainer">
				<form>
					<select name="checkedMain" id="checkedMain" class="checkedContent">
						<option value="none">== 매인 카테고리 선택 ==</option>
						<c:forEach var="i" begin="0" end="${fn:length(mainContentList)-1}">
							<option value="${mainContentList[i]}">${mainContentList[i]}</option>
						</c:forEach>
					</select> <select name="checkedSub" id="checkedSub" class="checkedContent">
						<option value="none">== 매인 카테고리를 먼저 선택해주세요 ==</option>
					</select>
				</form>
			</div>
		</div>
		<%
		List list = new ArrayList();
		list.add("월");
		list.add("화");
		list.add("수");
		list.add("목");
		list.add("금");
		list.add("토");
		list.add("일");
		pageContext.setAttribute("daySet", list);

		String[] days = { "월", "화", "수", "목", "금", "토", "일" };
		pageContext.setAttribute("days", days);
		%>
		<!--------------- RIGHT  --------------->
		<div class="rightSection">
			<!-- month form -->
			<div class="monthlyCalendar">
				<div class="dayHeaderContainer">
					<c:forEach var="item" items="${days}" varStatus="idx">
						<div class="dayHeader">${item}</div>
					</c:forEach>
				</div>
				<c:forEach var="i" begin="0" end="5">
					<div class='calendarWeekContainer week${i+1}'><!-- week 1 ~ 6 -->
						<c:forEach var="j" begin="0" end="6">
							<div class='calendar_day'>
								<span></span><span></span>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>

			<!-- week form -->
			<div class="weeklyCalendar">
				<div class="timeLineContainer">
					<div class="timeLineTitle">TIME</div>
					<!-- 9시~18시 -->
					<c:forEach var="i" begin="9" end="18">
						<div class="timeLineItem">${i} : 00 ~ ${i} : 30</div>
						<div class="timeLineItem">${i} : 30 ~ ${i+1} : 00</div>
					</c:forEach>
				</div>
				<div class="weekContainer">
					<div id="calendar">
						<div class="dayHeaderContainer">
							<c:forEach var="item" items="${days}" varStatus="idx">
								<div class="dayHeader">
									<span>${item}</span><span class="dayoftheweek">NoneData</span>
								</div>
							</c:forEach>
						</div>

						<div id="calendar_value">
							<div>
								<div id="00900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="00930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="01000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="01030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="01100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="01130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="01200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="01230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="01300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="01330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="01400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="01430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="01500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="01530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="01600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="01630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="01700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="01730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="10900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="10930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="11000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="11030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="11100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="11130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="11200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="11230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="11300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="11330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="11400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="11430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="11500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="11530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="11600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="11630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="11700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="11730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="20900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="20930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="21000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="21030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="21100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="21130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="21200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="21230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="21300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="21330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="21400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="21430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="21500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="21530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="21600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="21630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="21700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="21730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="30900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="30930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="31000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="31030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="31100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="31130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="31200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="31230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="31300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="31330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="31400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="31430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="31500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="31530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="31600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="31630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="31700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="31730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="40900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="40930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="41000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="41030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="41100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="41130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="41200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="41230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="41300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="41330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="41400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="41430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="41500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="41530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="41600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="41630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="41700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="41730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="50900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="50930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="51000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="51030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="51100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="51130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="51200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="51230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="51300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="51330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="51400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="51430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="51500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="51530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="51600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="51630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="51700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="51730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
							<div>
								<div id="60900" class="timeLineItemValueFirst">9시 ~ 9시 30분</div>
								<div id="60930" class="timeLineItemValue">9시 30분 ~ 10시</div>
								<div id="61000" class="timeLineItemValue">10시 ~ 10시 30분</div>
								<div id="61030" class="timeLineItemValue">10시 30분 ~ 11시</div>
								<div id="61100" class="timeLineItemValue">11시 ~ 11시 30분</div>
								<div id="61130" class="timeLineItemValue">11시 30분 ~ 12시</div>
								<div id="61200" class="timeLineItemValue">12시 ~ 12시 30분</div>
								<div id="61230" class="timeLineItemValue">12시 30분 ~ 13시</div>
								<div id="61300" class="timeLineItemValue">13시 ~ 13시 30분</div>
								<div id="61330" class="timeLineItemValue">13시 30분 ~ 14시</div>
								<div id="61400" class="timeLineItemValue">14시 ~ 14시 30분</div>
								<div id="61430" class="timeLineItemValue">14시 30분 ~ 15시</div>
								<div id="61500" class="timeLineItemValue">15시 ~ 15시 30분</div>
								<div id="61530" class="timeLineItemValue">15시 30분 ~ 16시</div>
								<div id="61600" class="timeLineItemValue">16시 ~ 16시 30분</div>
								<div id="61630" class="timeLineItemValue">16시 30분 ~ 17시</div>
								<div id="61700" class="timeLineItemValue">17시 ~ 17시 30분</div>
								<div id="61730" class="timeLineItemValue">17시 30분 ~ 18시</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- schedule form -->
			<div class="userScheduleContainer">
				<h1>내 스케쥴 현황</h1>
				<div id="scheduleList">
					<table border="1">
						<thead>
							<tr>
								<th>스튜디오</th>
								<th>예약 날짜</th>
								<th>시간</th>
							</tr>
						</thead>
						<tbody id="scheduleTableBody">

						</tbody>
					</table>
				</div>
			</div>
			
		</div><!-- rightSection END -->
	</div><!-- sectionContainer END -->
	
	<!-------------------------- RSV dialog ------------------------->
	<div id="rsv-dialog-form" class="dialog" title="예약현황">
		<div id="dialogHeader">
			<h1 id ="rsv-dialog-date"></h1>
			<h2>스케쥴 현황</h2>
		</div>
		<hr>
		<h2>❤❤예약중</h2>
		<h4 id="dialog-rsvList">list</h4><br>
		
		<h2>❤❤예약하기</h2>
		<h4 id="dialog-rsv">list</h4>
		<form>
			<select name="checkedMainDialog" id="checkedMainDialog" class="checkedContent">
				<option value="none">== 매인 카테고리 선택 ==</option>
				<c:forEach var="i" begin="0" end="${fn:length(mainContentList)-1}">
					<option value="${mainContentList[i]}">${mainContentList[i]}</option>
				</c:forEach>
			</select> 
			<select name="checkedSubDialog" id="checkedSubDialog" class="checkedContent">
				<option value="none">== 매인 카테고리를 먼저 선택해주세요 ==</option>
			</select>
			<p><input type="time" value="09:00" min="09:00:00" max="19:00:00"></p>
		</form>


	</div><!-- rsv-dialog-form END-->
</body>
</html>
