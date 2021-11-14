$(document).ready(function() {//DOM Tree 생성 완료 후 호출 (즉, 먼저 실행, 순차적실행)
});

$(window).load(function() {//모든 페이지 구성요소 페인팅 완료 후 호출 ONLY ONE
	$(".weeklyCalendar").hide();
	$(".userScheduleContainer").hide();
	
	var path = window.location.href;
	var path_ = path.split('/').reverse()[0];
	var categoryName=['studio','rental','consulting'];
	var categoryNo=categoryName.indexOf(path_)+1;
	let today = new Date(); // 현재 오늘 날짜 (변함 x , 고정값)
	
	let currentDate=today;//페이지에서의 날짜 - CD (2021-11-6)
	
	let firstDate_CD;//CD 달의 첫 날 (2021-11-1)
	let lastDate_CD;//CD 달의 마지막 날 (2021-11-30)
	let prev_lastDate_CD;//CD 달의 지난 달의 마지막 날 (2021-10-31)
	/* 알아보는 날짜 : 2021년 11월 1일 월요일
	
				Mon Nov 01 2021 01:24:19 GMT+0900 (한국 표준시)
				getFullYear : 2021
	(0~11)		getMonth : 10
				getDate : 1
	(0일~6토)		getDay : 1
	
	*/

	buildMonth();
	function buildMonth() {
		firstDate_CD =new Date(currentDate);
        firstDate_CD.setDate(1);
		
		$(".currentCalendarHeader").html(`${currentDate.getFullYear()}년&nbsp;&nbsp;&nbsp;&nbsp;${currentDate.getMonth() + 1}월&nbsp;(월)`);
		
		var daySet = makeElementMonth(firstDate_CD);
		monthlySetting(daySet);

		fetchData(`/api/schedules/${categoryNo}?year=${currentDate.getFullYear()}&month=${String(currentDate.getMonth()+1).padStart(2,'0')}&week=0`,'monthly');
	}
	
	function makeElementMonth(firstDate_CD) { // 11/6
		//getMonth() :: 1월 0 ~ 12월 11
		//getDay() :: 월1 ~토 6 일0
		let startDayCount = 1;
		let lastDayCount = 1;

		let firstDayName = null;//첫주 시작 월요일로 잡음
		if (firstDate_CD.getDay() == 0) firstDayName = 6; //첫날이 일요일이면 firstDayName = 6
		else firstDayName = firstDate_CD.getDay() - 1; //첫날이 월요일이면 0 ~ 토요일이면 5
		
		lastDate_CD =new Date(currentDate);
        lastDate_CD.setMonth(lastDate_CD.getMonth()+1);
        lastDate_CD.setDate(0); // 11/30
        
		prev_lastDate_CD =new Date(firstDate_CD);
		prev_lastDate_CD.setDate(0); // 10/31

		var daySet = [];
		var cnt = 0;
		for (let i = 0; i < 6; i++) {//1~6주차를 위해 6번 반복        
			for (let j = 0; j < 7; j++) {//일요일~토요일을 위해 7번 반복
				// <<1주차>> j < firstDayName: 이번 달 시작 요일 이전 일 때
				if (i == 0 && j < firstDayName) {
					daySet[cnt++] = `${(prev_lastDate_CD - (firstDayName - 1) + j)}`;
				}
				// <<1주차>> j == firstDayName: 이번 달 시작 요일일 때
				else if (i == 0 && j == firstDayName) {
					daySet[cnt++] = `${startDayCount++}`;
				}
				//<<1주차>> j > firstDayName: 이번 달 시작 요일 이후 일 때
				else if (i == 0 && j > firstDayName) {
					daySet[cnt++] = `${startDayCount++}`;
				}
				// startDayCount <= lastDay: 이번 달의 마지막 날이거나 이전일 때
				else if (i > 0 && startDayCount <= lastDate_CD.getDate()) {
					daySet[cnt++] = `${startDayCount++}`;
				}
				// startDayCount > lastDay: 이번 달의 마지막 날 이후일 때
				else if (startDayCount > lastDate_CD.getDate()) {
					daySet[cnt++] = `${lastDayCount++}`;
				}
			}
		}
		return daySet;
	}
	function monthlySetting(daySet) {
		var cnt = 0;
		for (let i = 1; i < 7; i++) {//1~6주차를 위해 6번 반복     
			for (let j = 0; j < 7; j++) {//일요일~토요일을 위해 7번 반복
				$(".week" + i).children(":eq(" + j + ")").children().first().text(daySet[cnt++]);
				$(".week" + i).children(":eq(" + j + ")").children().last().html('<ul class="dayRsvList"></ul>');
			}
		}
	}
	function weeklySetting(daySet) {
		var cnt = 0;
		for (let i = 7; i < 14; i++) {//0~6
			$(".dayHeaderContainer").children(":eq(" + i + ")").children().last().html(`&nbsp&nbsp${daySet[cnt++]}`);
		}
	}
	
	function getWeekOfMonth(date) {//date가 한달중 몇째주인지 (월요일~일요일 이 1주임을 기준으로 계산) //20210805를 구하기위해 20210705데이터 IN
		var selectedDay = date.getDate();//05
		var first = new Date(date.getFullYear() + '/' + (date.getMonth() + 1) + '/01');//20210805데이터를 집어넣고 내부는 20210705
		var monthFirstDateDay = (first.getDay() == 0) ? 6 : first.getDay() - 1; // 월요일이면 0 일요일이면 6이 반환됨

		return Math.ceil((selectedDay + monthFirstDateDay) / 7);
	}
	
	async function fetchData(url, pageVal){
		const response = await fetch(url);
		const json = await response.json();
		if (json != null) {
			if (pageVal === 'monthly') {
				for (var value of json) {
					var day = value.rsv_date.substr(8, 2);
					var oneday = new Date(currentDate);
					oneday.setDate(day);
					$(".testArea").text(value.schedule_seq);
					if (oneday.getDay() == 0) {//일요일
						$(".week" + getWeekOfMonth(oneday)).children(":eq(6)").
						children().last().children().append(`<li>&nbsp&nbsp[ ${value.main_content} - ${value.sub_content} ] ${value.start_time}~${value.end_time}</li>`);
					} else {//1~6 월~토

						$(".week" + getWeekOfMonth(oneday)).children(":eq(" + (oneday.getDay() - 1) + ")").
						children().last().children().append(`<li>&nbsp&nbsp[ ${value.main_content} - ${value.sub_content} ] ${value.start_time}~${value.end_time}</li>`);
					}
							
		
					
				}
			} else if (pageVal === 'weekly'){
				$(".testArea").text("week");
			}
		}
	}




});