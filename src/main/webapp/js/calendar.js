//padStart함수 : 글자수 지정후 비어있는 앞자리에 특정문구로 채우는 함수(String에만 적용)
//padEnd함수 : 글자수 지정후 비어있는 뒤자리에 특정문구로 채우는 함수(String에만 적용)

$(document).ready(function() {//DOM Tree 생성 완료 후 호출 (즉, 먼저 실행, 순차적실행)
	//alert("2)document.ready");
});

$(window).load(function() {//모든 페이지 구성요소 페인팅 완료 후 호출 ONLY ONE
	let today = new Date();
	let firstDate;//이번 달의 첫 날
	let lastDay;//이번 달의 마지막 날
	let prevLastDay;//지난 달의 마지막 날
	var rsvDialog, rsvForm;
	var rsvField= $([]).add("#userId").add("#userPwd");
	
	// Week 처리를 위한 변수
	let month;
	let firstWeekDay;
	let lastWeekDay
	let temp_month = month;
	
	// json 데이터 처리를 위한 변수
	let temp_loc;
	let temp_locno;
	
	rsvDialog = $("#rsv-dialog-form").dialog({
		autoOpen : false,
		height : 800,
		width : 800,
		modal : true,
		buttons : {
			"확인" : function() {
				//rsvForm.trigger("submit");
			},
			"취소" : function() {
				//rsvForm.dialog("close");
			}
		},
		close : function() {
			//rsvField.removeClass("ui-state-error");
		}
	});
	
	rsvForm = rsvDialog.find("form").on("submit", function(event) {
		var valid = true;
		userLoginField.removeClass("ui-state-error");
		
		//valid = valid && checkLength( $("#userId"), 5, 15);
		//valid = valid && checkLength( $("#userPwd"), 4, 20);
		if (valid) {
			userLoginDialog.dialog("close");
		}
		return valid;
	});
	
	$("#prev").click(function() {
		if ($(".mwBtn").val() == 'weekly') {
			clickMonth(-1);
		} else if ($(".mwBtn").val() == 'monthly') {
			clickWeek(-1);
		} else if ($(".mwBtn").val() == '예약수정') {
			clickRsv(-1);
		}
	});

	$("#next").click(function() {
		if ($(".mwBtn").val() == 'weekly') {
			clickMonth(1);
		} else if ($(".mwBtn").val() == 'monthly') {
			clickWeek(1);
		} else if ($(".mwBtn").val() == '예약수정') {
			clickRsv(1);
		}
	});

	$(".mwBtn").click(function() {
		if ($(".mwBtn").val() == 'weekly') {
			$(".mwBtn").val('monthly');// 버튼 라벨 바꾸고
			showWeek();
			buildWeek(0);//화면에 weekly띄우기
		} else {
			$(".mwBtn").val('weekly');// 버튼 라벨 바꾸고
			showMonth();
			buildMonth();//화면에 monthly띄우기
		}
	});

	$(".scheduleBtn").click(function(event) {
		if ($(".scheduleBtn").val() == '스케쥴 현황') {
			$(".scheduleBtn").val("돌아가기");
			$(".mwBtn").val("예약수정");
			$(".todayBtn").val("예약취소");
			$(".contentContainer").hide();
			showSchedule();
			buildRsvHeader();
			console.log(`/api/schedules/${$("#categoryNo").text()}?year=${firstDate.getFullYear()}&month=${String(firstDate.getMonth()+1).padStart(2,'0')}&id=${$("#id").text()}`);
			
			fetchData(`/api/schedules/${$("#categoryNo").text()}?year=${firstDate.getFullYear()}&month=${String(firstDate.getMonth()+1).padStart(2,'0')}&id=${$("#id").text()}`,'scheduleList');

		} else if ($(".scheduleBtn").val() == "돌아가기") {
			$(".scheduleBtn").val('스케쥴 현황');
			$(".mwBtn").val("weekly");
			$(".todayBtn").val("today");
			$(".contentContainer").show();
			showMonth();
			buildMonth();
		}
	});
	$("#checkedMain").change(function() {
		//alert("Dialog");
		var v = $("#checkedMain").val();
		//한글깨짐 인코딩처리 - encodeURI(encodeURIComponent(v))
		fetchData(`/api/contents/${$("#categoryNo").text()}?mainCategory=${encodeURI(encodeURIComponent(v))}`, 'category');
	});
	$("#checkedMainDialog").change(function() {
		//alert("Dialog");
		var v = $("#checkedMainDialog").val();
		//한글깨짐 인코딩처리 - encodeURI(encodeURIComponent(v))
		fetchData(`/api/contents/${$("#categoryNo").text()}?mainCategory=${encodeURI(encodeURIComponent(v))}`, 'categoryDialog');
	});	
	$("#todayBtn").change(function() {
		
	});
	$(".calendar_day").on("click",function(){
		rsvDialog.dialog("open");
		$("#rsv-dialog-date").text(`${today.getFullYear()}년 ${String(today.getMonth()+1).padStart(2,'0')}월 ${$(this).children().first().text()}일`);
		$("#dialog-rsvList").html($(this).children().last().html());
		
		//today.getFullYear()+(String(today.getMonth()+1).padStart(2,'0'))+$(this).children().first().text()
	});

	//////////ajax		
	function monthlySetting(daySet) {
		var cnt = 0;
		for (let i = 1; i < 7; i++) {//1~6주차를 위해 6번 반복     
			for (let j = 0; j < 7; j++) {//일요일~토요일을 위해 7번 반복
				$(".week" + i).children(":eq(" + j + ")").children().first().text(daySet[cnt++]);
				$(".week" + i).children(":eq(" + j + ")").children().last().html('<ul id="dayRscList"></ul>');
			}
		}
	}
	function weeklySetting(daySet) {
		var cnt = 0;
		for (let i = 7; i < 14; i++) {//0~6
			$(".dayHeaderContainer").children(":eq(" + i + ")").children().last().html(`&nbsp&nbsp${daySet[cnt++]}`);
		}
	}

	async function fetchData(url, pageVal) {
		const response = await fetch(url);
		const json = await response.json();
		if (json != null) {
			if (pageVal === 'monthly') {
				for (var value of json) {
					var day = value.rsv_date.substr(8, 2);
					var oneday = new Date(today.getFullYear(), today.getMonth(), day);

					if (oneday.getDay() == 0) {//일요일
						$(".week" + getWeekOfMonth(oneday)).children(":eq(6)").
						children().last().children().append(`<li>&nbsp&nbsp[ ${value.main_content} - ${value.sub_content} ] ${value.start_time}~${value.end_time}</li>`);
					} else {//1~6 월~토

						$(".week" + getWeekOfMonth(oneday)).children(":eq(" + (oneday.getDay() - 1) + ")").
						children().last().children().append(`<li>&nbsp&nbsp[ ${value.main_content} - ${value.sub_content} ] ${value.start_time}~${value.end_time}</li>`);
					}
				}
			} else if (pageVal === 'weekly') {
				// 전혁 - 주간 데이터 끌고올것
				console.log("weekly 실행");
				var temp = "";

				$(".timeLineItemValue").css("background-color", "white"); // select 값이나 주가 변경되면 타임테이블 배경색을 흰색으로 초기화
				$(".timeLineItemValueFirst").css("background-color", "white"); // select 값이나 주가 변경되면 타임테이블 배경색을 흰색으로 초기화

				for (var value of json) {
					if (`${value.main_content}` == temp_loc && `${value.sub_content}` == temp_locno) {
						console.log("weekly json 처리 실행");
						let day = value.rsv_date.substr(8, 2);

						for (let cnt = 0; cnt < 7; cnt++) {
							let test = $('.dayoftheweek' + cnt).text();
							test = test.trim();

							if (test.length == 1) { // 만약 가지고 온 일 데이터가 한자리면 앞에 0을 붙여 2자리로 만들어줌
								test = "0" + test;
							}

							if (day == test) {
								// start time 추출
								let s_hour = `${value.start_time}`;
								s_hour = s_hour.substr(0, 2);
								let s_minute = `${value.start_time}`;
								s_minute = s_minute.substr(3, 2);
								console.log("s_hour : " + s_hour + " s_minute : " + s_minute);

								// end time 추출
								let e_hour = `${value.end_time}`;
								e_hour = e_hour.substr(0, 2);
								let e_minute = `${value.end_time}`;
								e_minute = e_minute.substr(3, 2);
								console.log("e_hour : " + e_hour + " e_minute : " + e_minute);

								// 색깔 칠하기
								let colorCode = "#" + Math.round(Math.random() * 0xffffff).toString(16); // 랜덤 색상 생성

								for (let i = parseInt(s_hour); i <= parseInt(e_hour); i++) {
									let temp_i = String(i); // i 값을 문자로 변환
									if (temp_i.length == 1) temp_i = "0" + temp_i; // i가 한자리면 앞에 0추가

									if (i == parseInt(s_hour) && s_minute == "30") { // i가 시작시간의 시간과 같으면서 시작시간의 분이 30이면,
										$('#' + cnt + temp_i + '30').css("background-color", colorCode);
									} else {
										if (i == parseInt(e_hour) && e_minute == "30") { // i가 종료시간의 시간과 같으면서 종료시간의 분이 30이면,
											$('#' + cnt + temp_i + '00').css("background-color", colorCode);
										} else if (i == parseInt(e_hour) && e_minute == "00") { // i가 종료시간의 시간과 같으면서 종료시간의 분이 00이면,
											let temp_ehour = parseInt(e_hour);
											temp_ehour--;
											e_hour = String(temp_ehour);
											if (e_hour.length == 1) {
												e_hour = "0" + e_hour;
											}

											$('#' + cnt + temp_ehour + '30').css("background-color", colorCode);
										} else {
											$('#' + cnt + temp_i + '00').css("background-color", colorCode);
											$('#' + cnt + temp_i + '30').css("background-color", colorCode);
										}

									}
								}
							}
						}
					}



				}
			} else if (pageVal === 'category') {
				$("#checkedSub").find("option").remove();//기존 옵션 제거하고 선택된 메인카테고리에 따른 서브카테고리불러올 것
				for (var value of json) {
					$('#checkedSub').append($("<option></option>").attr("value", 2).text(`${value}`));
				}
			}  else if (pageVal === 'categoryDialog') {
				$("#checkedSubDialog").find("option").remove();//기존 옵션 제거하고 선택된 메인카테고리에 따른 서브카테고리불러올 것
				for (var value of json) {
					$('#checkedSubDialog').append($("<option></option>").attr("value", 2).text(`${value}`));
				}
			} else if (pageVal === 'scheduleList') {
				$("#scheduleTableBody").empty();//테이블 내용 비우기
				console.log(json);
				for (var value of json) {
					var add_data = '';
					add_data += '<tr>';

					add_data += '<td>';
					add_data += `${value.main_content} - ${value.sub_content}`;
					add_data += '</td>';

					add_data += '<td>';
					add_data += `${value.rsv_date}`;
					add_data += '</td>';

					add_data += '<td>';
					add_data += `${value.start_time} ~ ${value.end_time}`;
					add_data += '</td>';

					add_data += '</tr>';
					$("#scheduleTableBody").append(add_data);
				}
			}
		}
	}
	function showMonth() {
		$(".monthlyCalendar").show();
		$(".weeklyCalendar").hide();
		$(".userScheduleContainer").hide();
	}
	function showWeek() {
		$(".monthlyCalendar").hide();
		$(".weeklyCalendar").show();
		$(".userScheduleContainer").hide();
	}
	function showSchedule() {
		$(".monthlyCalendar").hide();
		$(".weeklyCalendar").hide();
		$(".userScheduleContainer").show();
	}
	//////////달력 - monthly	
	showMonth();
	buildMonth();
	function buildMonth() {
		firstDate = new Date(today.getFullYear(), today.getMonth(), 1, today.getDay());//2021.9.1.2(수)
		lastDay = new Date(firstDate.getFullYear(), firstDate.getMonth() + 1, 0).getDate();//9/30 3(목)
		prevLastDay = new Date(firstDate.getFullYear(), firstDate.getMonth(), 0).getDate();//8/31 1(화)
		$(".current-year-month").html(`&nbsp;${firstDate.getFullYear()}년&nbsp;&nbsp;&nbsp;&nbsp;${firstDate.getMonth() + 1}월&nbsp;(월)`);

		//rightSection칸에 month소스 채우기
		var daySet = makeElementMonth(firstDate);
		monthlySetting(daySet);
		fetchData(`/api/schedules/${$("#categoryNo").text()}?year=${firstDate.getFullYear()}&month=${String(firstDate.getMonth()+1).padStart(2,'0')}&week=0`,'monthly');
	}

	function makeElementMonth(firstDate) {
		//getMonth() :: 1월 0 ~ 12월 11
		//getDay() :: 월1 ~토 6 일0
		let startDayCount = 1;
		let lastDayCount = 1;

		let firstDayName = null;//첫주 시작 월요일로 잡음

		if (firstDate.getDay() == 0) firstDayName = 6;
		else firstDayName = firstDate.getDay() - 1;

		lastDay = new Date(firstDate.getFullYear(), firstDate.getMonth() + 1, 0).getDate();//9/30 3(목)
		prevLastDay = new Date(firstDate.getFullYear(), firstDate.getMonth(), 0).getDate();//8/31 1(화)
		
		var daySet = [];
		var cnt = 0;
		for (let i = 0; i < 6; i++) {//1~6주차를 위해 6번 반복        
			for (let j = 0; j < 7; j++) {//일요일~토요일을 위해 7번 반복
				// <<1주차>> j < firstDayName: 이번 달 시작 요일 이전 일 때

				if (i == 0 && j < firstDayName) {
					daySet[cnt++] = `${(prevLastDay - (firstDayName - 1) + j)}`;
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
				else if (i > 0 && startDayCount <= lastDay) {
					daySet[cnt++] = `${startDayCount++}`;
				}
				// startDayCount > lastDay: 이번 달의 마지막 날 이후일 때
				else if (startDayCount > lastDay) {
					daySet[cnt++] = `${lastDayCount++}`;
				}
			}
		}
		return daySet;
	}
	//////////달력 - weekly	
	function buildWeek(week) {
		today.setDate(today.getDate() + week * 7);
		
		//rightSection칸에 week소스 채우기
		var daySet = makeElementWeek(0);
		alert(daySet);
		weeklySetting(daySet);
		alert(`/api/schedules/${$("#categoryNo").text()}?year=${firstDate.getFullYear()}&month=${month}&week=1&fwd=${firstWeekDay}&lwd=${lastWeekDay}&t_month=${temp_month}`);
		fetchData(`/api/schedules/${$("#categoryNo").text()}?year=${firstDate.getFullYear()}&month=${month}&week=1&fwd=${firstWeekDay}&lwd=${lastWeekDay}&t_month=${temp_month}`,'weekly');
		/*기존 WEEK
		today.setDate(today.getDate() + week * 7);
		let title = "&nbsp;" + today.getFullYear() + "년&nbsp;&nbsp;&nbsp;&nbsp;" + (today.getMonth() + 1) + "월&nbsp;(주)";

		for (let i = 0; i < 7; i++) {
			if (today.getDate() == 1)
				title += " ~&nbsp;&nbsp;&nbsp;&nbsp; " + today.getFullYear() + "년&nbsp;&nbsp;&nbsp;&nbsp;"
					+ (today.getMonth() + 1) + "월";
			today.setDate(today.getDate() + 1);
		}
		today.setDate(today.getDate() - 7);
		$(".current-year-month").html(title);

		//rightSection칸에 week소스 채우기
		var daySet = makeElementWeek(0);
		weeklySetting(daySet);
		*/
	}

	function makeElementWeek(week) {
		var daySet = [];
		var weekDate = new Date(today);
		weekDate.setDate(weekDate.getDate() + week * 7); //나타낼 주 날짜 읽어와서 저장하기 0, -1, +1
		if (weekDate.getDay() == 0) {
			weekDate.setDate(weekDate.getDate() - 6);
		} else {
			weekDate.setDate(weekDate.getDate() - (weekDate.getDay() - 1));
		} //첫주 시작 월요일로 잡기
		
		let title = "&nbsp;" + weekDate.getFullYear() + "년&nbsp;&nbsp;&nbsp;&nbsp;" + (weekDate.getMonth() + 1) + "월&nbsp;";
		month = weekDate.getMonth() + 1;
		
		for (let cnt = 0; cnt < 7; cnt++) {//0~6
			daySet[cnt] = `${weekDate.getDate()}`;
			
			if (weekDate.getDate() == 1 && daySet[0] != 1) {
				title += " ~&nbsp;&nbsp;&nbsp;&nbsp; " + weekDate.getFullYear() + "년&nbsp;&nbsp;&nbsp;&nbsp;"
						+ (weekDate.getMonth() + 1) + "월";
				temp_year = weekDate.getFullYear();
				temp_month = weekDate.getMonth() + 1;
			}
			
			weekDate.setDate(weekDate.getDate() + 1);//날짜 증가시키기
		}
		$(".current-year-month").html(title);
		
		// 해당 주 첫번째 날, 마지막 날 저장
		firstWeekDay = daySet[0];
		lastWeekDay = daySet[6];
		
		return daySet;
		
		/*기존 WEEK
		var daySet = [];
		var weekDate = new Date(today);
		weekDate.setDate(weekDate.getDate() + week * 7);//나타낼 주 날짜 읽어와서 저장하기 0,-1,+1
		if (weekDate.getDay() == 0) {
			weekDate.setDate(weekDate.getDate() - 6);
		} else {
			weekDate.setDate(weekDate.getDate() - (weekDate.getDay() - 1));
		}//첫주 시작 월요일로 잡기

		for (let cnt = 0; cnt < 7; cnt++) {//0~6
			daySet[cnt] = `${weekDate.getDate()}`;
			weekDate.setDate(weekDate.getDate() + 1);//날짜 증가시키기
		}
		return daySet;*/
	}

	//////////달력 - 공통함수
	function getWeekOfMonth(date) {//date가 한달중 몇째주인지 (월요일~일요일 이 1주임을 기준으로 계산) //20210805를 구하기위해 20210705데이터 IN
		var selectedDay = date.getDate();//05
		var first = new Date(date.getFullYear() + '/' + (date.getMonth() + 1) + '/01');//20210805데이터를 집어넣고 내부는 20210705
		var monthFirstDateDay = (first.getDay() == 0) ? 6 : first.getDay() - 1; // 월요일이면 0 일요일이면 6이 반환됨

		return Math.ceil((selectedDay + monthFirstDateDay) / 7);
	}

	function removeCalendarMonth() {//Monthly내부에 달력내용만 지우기
		let divEls1 = document.querySelectorAll('.calendar_day');
		let divEls2 = document.querySelectorAll('.calendarWeekContainer');
		for (var value of divEls1) {
			value.remove();
		}
		for (var value of divEls2) {
			value.remove();
		}
	}

	//////////예약현황
	function buildRsvHeader() {
		firstDate = new Date(today.getFullYear(), today.getMonth(), 1, today.getDay());//2021.9.1.2(수)
		lastDay = new Date(firstDate.getFullYear(), firstDate.getMonth() + 1, 0).getDate();//9/30 3(목)
		prevLastDay = new Date(firstDate.getFullYear(), firstDate.getMonth(), 0).getDate();//8/31 1(화)
		$(".current-year-month").html(`&nbsp;${today.getFullYear()}년&nbsp;&nbsp;&nbsp;&nbsp;${firstDate.getMonth() + 1}월&nbsp;(예약)`);
	}
	//////////HEADER부분 날짜 변경 버튼 함수
	function clickMonth(cnt) {//////
		today = new Date(today.getFullYear(), today.getMonth() + cnt, today.getDate());
		console.log("변경된 today데이터 : " + today);
		console.log("변경된 today데이터 달: " + today.getMonth());
		buildMonth();
	}

	function clickWeek(cnt) {
		buildWeek(cnt);
	}

	function clickRsv(cnt) {
		today = new Date(today.getFullYear(), today.getMonth() + cnt, today.getDate());
		//removeCalendarMonth();
	}
});