<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="/WEB-INF/views/header.jsp" %>
<script src="/js/calendarJS.js" defer></script>

<div class="sectionContainer">
	<!------------- LEFT --------------->
	<div class="leftSection">
		<div class="calendarHeaderContainer">
			<h1 class="currentCalendarHeader"> </h1>
			<div id="prev"  class="calendarHeaderBtn" > < </div>
			<div id="todayBtn"  class="calendarHeaderBtn" > today </div>
			<div id="next" class="calendarHeaderBtn"> > </div>
		</div>
		<div class="contentContainer">
			<h2>카테고리 선택</h2> 
			<form class="contentForm">
				<select name="checkedMain" id="checkedMain" class="checkedContentSelect">
					<option value="none">= 매인 카테고리 =&nbsp&nbsp</option>
					<c:forEach var="i" begin="0" end="${fn:length(mainContentList)-1}">
						<option value="${mainContentList[i]}">${mainContentList[i]}</option>
					</c:forEach>
				</select> 
				<select name="checkedSub" id="checkedSub" class="checkedContentSelect">
					<option value="none">= 매인을 먼저 선택해주세요 =&nbsp&nbsp</option>
				</select>
			</form>
			<input type="button" value="선택 카테고리 보기" id="contentBtn" class="contentBtn" />
			<input type="button" value="모든 카테고리 보기" id="allContentBtn" class="contentBtn" />
		</div>
		<div class="btnContainer">
			<input type="button" value="weekly" id="weeklyBtn" class="contentBtn" />
			<input type="button" value="My Reservation" id="rsvBtn" class="contentBtn" />
		</div>
		<div class="testArea">
		
		</div>
	</div>
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

<%@include file="/WEB-INF/views/footer.jsp"%>