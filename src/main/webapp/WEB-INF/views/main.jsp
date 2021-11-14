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
<title>Main Page</title>
<!--font-family 사용 URL -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,700;1,700;1,900&display=swap" rel="stylesheet">
<!-- Icon사용 URL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" integrity="sha384-v8BU367qNbs/aIZIxuivaU55N5GPF89WBerHoGA4QTcbUjYiLQtKdrfXnqAcXyTv" crossorigin="anonymous">

<link href="/css/common.css" rel="stylesheet" type="text/css">
<!-- <link href="/css/main.css" rel="stylesheet" type="text/css"> -->
<link href="/css/mainStyle.css" rel="stylesheet" type="text/css">
<link href="/css/dialog.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- <script src="/js/main.js"></script> -->
<script src="/js/mainJS.js" defer></script>
</head>
<body>
    <nav class="navbar">
    
        <div class="navbar_logo">
            <i class="fas fa-robot"></i>
            <span>CTR System</span><!-- //Campus Total Reservation System -->
        </div>
        
        <ul class="navbar_menu">
            <li id="category1" class="menuBtn">Studio</li>
            <li id="category2" class="menuBtn">Rental</li>
            <li id="category3" class="menuBtn">Consulting</li>
            <li id="faqTest">FAQ</li>
        </ul>
        
        <div class="navbar_icons">
        	<div class="loginBtn">
            	<i class="fas fa-user-circle"></i>
            	<!-- <span>Login</span> -->
             	<c:if test="${userName eq NULL }"><span>Login</span></c:if>
    	       	<c:if test="${userName ne NULL }">
            		<span>${userName}</span><br>
            		<span id="logoutBtn" class="loginBtn_content">logout</span>
            		<span id="mypageBtn" class="loginBtn_content">mypage</span>
            	</c:if>            	
            </div>
        </div>
        
        <div class="navbar_toogleBtn"><!-- 메뉴버튼 -->
            <i class="fas fa-bars"></i>
        </div>
    </nav>
    
    
    <div class="custom-shape-divider-top-1635871786">
        <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
        </svg>
    </div>
    <p id="checkedCategory"></p><!-- category1값이 text로 저장 - hidden  -->

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

	<div id="mainContatiner">
    	<div class="home_form">
	        <div id="imgContatiner">
	             <img id ="img" src="/img/image.png">
	        </div>
	        <div id="imgContatiner2">
	            <!--  <a href="#"><img id ="img" src="img.jpg"></a> -->
	         </div>
         </div>
         <div class="studio_form">
         
		</div>
         <div class="rental_form">
         
         </div>
         <div class="consulting_form">
         
         </div>
         <div class="fnq_form">
         
         </div>
    </div>
    
    <div class="custom-shape-divider-bottom-1635871467">
        <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
            <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
            <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
            <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
        </svg>
    </div>	
	
	
	
	

<!-- 	<div class="iconContainer">
		<div id="icon">
			<i class="fas fa-user-cog fa-3x" id="admin-icon"></i>admin페이지로 이동
		</div>
	</div>
	
	<div class="titleContainer">
		<h1 id="title">Schedule Management Platform</h1>
		<p id="checkedCategory"></p>category1값이 text로 저장 - hidden 
	</div>

	<div class="btnContainer">
		<input type="button" name="category" value="studio" class="menuBtn" id="category1"/>
		<input type="button" name="category" value="rental" class="menuBtn" id="category2"/>
		<input type="button" name="category" value="aaa" class="menuBtn" id="category3"/>
		<input type="button" name="category" value="bbb" class="menuBtn" id="category4"/>
		<input type="button" name="category" value="ccc" class="menuBtn" id="category5"/>
		<input type="button" name="category" value="ddd" class="menuBtn" id="category6"/>
		<input type="button" name="category" value="eee" class="menuBtn" id="category7"/>
	</div>	 -->
	
 	<!------------------------- category button - login dialog ------------------------->
	<div id="user-login-dialog-form" class="dialog" title="로그인">
		<div class="login_property">
			<div id="loginPropertyLeft" style="display: inline-block">
				<div class="inputText">
					<label for="userId" class="idLabel">&nbsp아이디 :&nbsp </label> 
					<input type="text" name="userId" id="userId"
						placeholder="ID를 입력하세요."
						class="text ui-widget-content ui-corner-all id" required />
				</div>

				<div class="inputText">
					<label for="userPwd" class="passwordLabel">비밀번호 : &nbsp</label> 
					<input type="password" name="userPwd" id="userPwd"
						placeholder="비밀번호를 입력하세요."
						class="text ui-widget-content ui-corner-all password" required />
				</div>
			</div>
		</div>
	</div>

</body>
</html>