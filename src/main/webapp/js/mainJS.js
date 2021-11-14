const toggleBtn=document.querySelector('.navbar_toogleBtn');
const menu=document.querySelector('.navbar_menu');
const menuChild=menu.childNodes;
const icons=document.querySelector('.navbar_icons');
const faqTest=document.querySelector('#faqTest');
const mainContatiner=document.querySelector('#mainContatiner');

toggleBtn.addEventListener('click',()=>{
    menu.classList.toggle('active');
    icons.classList.toggle('active');
});

$(function() {
	var userLoginDialog;
	var userLoginField = $([]).add("#userId").add("#userPwd");
	
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
	
	function userLoginCheckLength() {//로그인 요청시 들어오는 함수
		userLoginField.removeClass("ui-state-error"); //에러 없애기
		if (userLoginField.val().length > 15 || userLoginField.val().length < 5) {
			//false - ID,PWD 재요청
			userLoginField.addClass("ui-state-error");
			alert("아이디와 비밀번호를 다시 확인해 주세요.");
		} else {
			//true - 로그인 유효성 검사
			const userId = btoa($("#userId").val());//base64 인코딩
			const userPwd = btoa($("#userPwd").val());
			var url = `/api/users/login?id=${userId}&pwd=${userPwd}`;// 로그인 요청보내기
			loginFetch(url, userId, userPwd);
		}
	}
	
	function loginFetch(url, id, pwd) {//GET메소드
		console.log("loginFetch함수 URL : " + url);

		fetch(url)
			.then(res => res.text())
			.then(res => {
				if (res == 'true') {
					console.log("로그인 성공");
					console.log(getCookie("userName"));
					
					var login_type = `/api/users/type?id=${id}`;
					loginTypeFetch(login_type, id);
					
					$(".loginSection").children(":eq(1)").text(getCookie("userName"));
					$(".logoutSection").show();
					
					userLoginDialog.dialog("close");
					
					//var index = $("#checkedCategory").text().substr(8);
					//window.location.assign("/main?category=" + index+"&id="+$("#userId").val());
				} else alert("아이디와 비밀번호를 다시 확인해 주세요."); 
			});
	}
	
	function loginTypeFetch(url, id) {
		console.log("loginTypeFetch함수 URL : " + url);
		
		fetch(url)
			.then(res => res.text())
			.then(res => {
				if (res == 'true') {
					console.log("type 가져오기 성공");
					console.log(getCookie("loginType"));
					
					if (getCookie("loginType") == 'M') {
						console.log("해당 계정의 type은 관리자");
						alert("관리자 모드 실행!!!");
						document.location.href="/managerMain";
					}
				}
			})
	}
	function getCookie(cookie_name) {
		//document.cookie => userId=600548; userName=홍길동; login=true
		var x, y; 
		var val = document.cookie.split(';');
		for (var i = 0; i < val.length; i++) {
			x = val[i].substr(0, val[i].indexOf('='));
			y = val[i].substr(val[i].indexOf('=') + 1);
			x = x.replace(/^\s+|\s+$/g, '');// 앞과 뒤의 공백 제거하기 
			if (x == cookie_name) {return unescape(y); }// unescape로 디코딩 후 값 리턴 
		}
	} 
	$("#login").children().on("click", function() {
		userLoginDialog.dialog("open");
	});
	$("#adminLogin").children().on("click", function() {
		userAdminLoginDialog.dialog("open");
	});
	
});