<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/WEB-INF/views/managerMain.jsp"%>
<script src="/js/adminSetting.js"></script>
<script src="/js/adminLogout.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css"/>

<script>
$(function() {
	$("#mainContatiner").hide();
	
	$('#rsvList').DataTable({
		lengthChange : false,
		searching: false,
		ordering: false,
		info: false,
		paging: false
	});
	
	$('.button').click(function(){
		fetchData('/api/schedules/'+$(this).attr('id').substr(8));
		$('#CheckedButton').text($(this).attr('id').substr(8));
		$("#rsvList > tbody:last").empty();
	})
	
	async function fetchData(url) {
		const response = await fetch(url);
		const data = await response.json();
		console.log(data);
		if(data !=null){
			columns : await test(data)	 
		}
		$('.cancle').click(function(){
			console.log('취소');
			console.log($(this).parent().parent().attr('id')); //seq1
			console.log($(this).parent().parent().attr('id').substr(3)); //1
			console.log('/api/schedules?seq='+$(this).parent().parent().attr('id').substr(3));
			
			fetch('/api/schedules/delete?seq='+$(this).parent().parent().attr('id').substr(3))
				.then(response=>response.json())
				.then(data=>console.log(data))
				.then($(this).parent().parent().remove())
				.catch(error=>console.log(error))
	
			
			//fetchData('/api/schedules/'+$('#CheckedButton').text());
					
		})
	}
	
	function test(data) {
		for (var value of data) {
			var str = 
				"<tr id='seq"+value.schedule_seq+"'><td>"+value.schedule_seq+"</td><td>"+value.category+"</td><td>"+value.main_content+"</td><td>"+value.sub_content+"</td><td>"
				+value.user_type+"</td><td>"+value.user_id+"</td><td>"+value.user_name+"</td><td>"+value.rsv_date+"</td><td>"
				+value.start_time+"</td><td>"+value.end_time+"</td>"
				+"<td><input type='button' class='change' value='변경' style='margin: 1px;'/><input type='button' class='cancle' value='취소'/></td></tr>";
				
			$("#rsvList > tbody:last").append(str);
			
		}
		
	}
	
	$('#search').click(function(){
		var searchSelect = $('#searchSelect').val();
		var textValue = $('#searchBox').val();
		var CheckedButton = $('#CheckedButton').text();
		$("#rsvList > tbody:last").empty();
		console.log('/api/schedules/'+CheckedButton+'?searchSelect='+searchSelect+'&textValue='+encodeURI(encodeURIComponent(textValue)));
		getSearchData('/api/schedules/'+CheckedButton+'?searchSelect='+searchSelect+'&textValue='+encodeURI(encodeURIComponent(textValue)));
		//url = /api/schdules/btn1
	})
	
	async function getSearchData(url){
		const response = await fetch(url);
		const json = await response.json();
		console.log(json);
		if(json !=null){
			for (var value of json) {
				var str = 
					"<tr><td>"+value.schedule_seq+"</td><td>"+value.category+"</td><td>"+value.main_content+"</td><td>"+value.sub_content+"</td><td>"
					+value.user_type+"</td><td>"+value.user_id+"</td><td>"+value.user_name+"</td><td>"+value.rsv_date+"</td><td>"
					+value.start_time+"</td><td>"+value.end_time+"</td>"
					+"<td><input type='button' class='cancle' value='취소'/></td></tr>";
					
				/* var str2 = `<tr><td>${value.rsvno}</td></tr>`; */
				$("#rsvList > tbody:last").append(str);
			}
		}
	}
});
</script>
<style>
.selectview{
	display : table-cell;
	vertical-align : middle;
	width : 480px;
	height : 70px;
	padding-left : 600px;
}
</style>
</head>
<body>
	<div style="text-align : center;">
		<div class="selectview">
		<input type="button" class="button" id="category1" value="studio" name="btn1" /> 
		<input type="button" class="button" id="category2" value="rental" name="btn2" /> 
		<input type="button" class="button" id="category3" value="consulting" name="btn3" /><br>
		<select name="searchSelect" id="searchSelect" class="searchSelect">
			<option value="none">== 검색조건을 선택해주세요 ==</option>
			<option value="user_name">이름</option>
			<option value="user_id">유저아이디</option>
			<option value="main_content">메인카테고리</option>
			<option value="rsv_date">예약날짜</option>
		</select>
		<input type="text" id="searchBox" />
		<input type="button" id="search" name="search" value="검색"/>
		</div>
	</div>
	<p id="CheckedButton" style="display:none;"></p><br>
	<div style="width: 85%; margin: 0 auto;">
	 	<table border=1 id="rsvList">
	 		<thead>
		 		<tr><td align=center>예약번호</td>
		 		    <td align=center>카테고리</td>
		 		    <td align=center>대분류</td>
		 		    <td align=center>소분류</td>
		 		    <td align=center>유저타입</td>
		 		    <td align=center>아이디</td>
		 		    <td align=center>이름</td>
		 		    <td align=center>예약날짜</td>
		 		    <td align=center>시작시간</td>
		 		    <td align=center>종료시간</td>
		 		    <td align=center>버튼</td>
		 		</tr>
	 		</thead>
	 		<tbody>
	 		</tbody>
	 	</table>
	 </div>
</body>
</html>