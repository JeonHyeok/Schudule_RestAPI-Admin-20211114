/**
 * 
 */
$(function() {
	var script = document.createElement('script');
	script.src = 'https://code.jquery.com/jquery-3.4.1.min.js';
	script.type = 'text/javascript';
	
	$(".menuBtn").on("click", function() {
		$("#checkedCategory").text($(this).attr("id"));
		//로그인 여부 확인
	});
	
	$(".navbar_toogleBtn").on("click", function() {
		alert("navbar_toogleBtn!!");
	});

<<<<<<< HEAD
	$("#icon").on("click", function() {
=======
	$(".navbar_icons").children().on("click", function() {
		//alert("navbar_icons클릭 >> LOGIN");
>>>>>>> c1b37b87bf11d53df9a6d7caeebdbf6090ee13ff
		userLoginDialog.dialog("open");
	});
	
	var userLoginDialog, userLoginForm;
	var adminLoginDialog, adminLoginForm;

	var userLoginField = $([]).add("#userId").add("#userPwd");
	var adminLoginField = $([]).add("#adminId").add("#adminPwd");

	function checkLength(o, min, max) {
		if (o.val().length > max || o.val().length < min) {
			return false;
		} else {
			o.removeClass("ui-state-error"); //에러 없애기
			return true;
		}
	}
	userLoginDialog = $("#user-login-dialog-form").dialog({
		autoOpen: false,//페이지 로드시 다이얼로그가 자동으로 열리는 것 방지
		height: 250,
		width: 450,
		modal: true,//최상위에 다이알로그 표시
		resizable: false,//창크기 조절할 수 없도록 설정
		buttons: {
			"확인": function() {
				userLoginCheckLength();
			},
			"취소": function() {
				userLoginDialog.dialog("close");
			}
		},
		close: function() {
			userLoginField.removeClass("ui-state-error");//에러 없애기
		}
	});
	function userLoginCheckLength() {
		var valid = true;
		userLoginField.removeClass("ui-state-error");

		valid = checkLength(userLoginField, 5, 15);
		if (valid) {//true - 로그인 요청
			userLoginFun();
		} else {//false
			userLoginField.addClass("ui-state-error");
			alert("아이디와 비밀번호를 다시 확인해 주세요.");
		}
	}

	function userLoginFun() {
		const userId = btoa($("#userId").val());//base64 인코딩
		const userPwd = btoa($("#userPwd").val());
		var url = `/api/users/login?id=${userId}&pwd=${userPwd}`
		loginFetch(url, userId, userPwd);
	}
	
	function loginFetch(url, id, pwd) {//GET메소드
		console.log("loginFetch함수 URL : " + url);

		fetch(url)
			.then(res => res.text())
			.then(res => {
				if (res == 'true') {
					console.log("로그인 성공");
					var index = $("#checkedCategory").text().substr(8);
					if(index == "") {
						window.location.assign("/managerMain?id="+$("#userId").val());
					} else {
						window.location.assign("/main?category=" + index+"&id="+$("#userId").val());
					}
			
				} else alert("아이디와 비밀번호를 다시 확인해 주세요."); 
			});
	}

	
});