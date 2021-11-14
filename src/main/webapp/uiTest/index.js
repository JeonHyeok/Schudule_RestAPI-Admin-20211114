const toggleBtn=document.querySelector('.navbar_toogleBtn');
const menu=document.querySelector('.navbar_menu');
const icons=document.querySelector('.navbar_icons');

toggleBtn.addEventListener('click',()=>{
    menu.classList.toggle('active');
    icons.classList.toggle('active');
});
$(window).load(function() {//모든 페이지 구성요소 페인팅 완료 후 호출 ONLY ONE
	$(".weekContainer").hide();
	$(".userScheduleContainer").hide();
	
	
	let today = new Date(); // 현재 오늘 날짜

	let currentDate=today;//페이지에서의 날짜 - CD (2021-11-6)
	let firstDate_CD;//CD 달의 첫 날 (2021-11-1)
	let lastDate_CD;//CD 달의 마지막 날 (2021-11-30)
	let prev_lastDate_CD;//CD 달의 지난 달의 마지막 날 (2021-10-31)
	
	
	buildMonth();

	function buildMonth() {
		//firstDate_CD = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1, currentDate.getDay());
        firstDate_CD =new Date(currentDate);
        firstDate_CD.setDate(1);

		lastDate_CD =new Date(currentDate);
        lastDate_CD.setMonth(lastDate_CD.getMonth()+1);
        lastDate_CD.setDate(0);
        
		prev_lastDate_CD =new Date(firstDate_CD);
		prev_lastDate_CD.setDate(0);
        
        $("#imgContatiner2").html(
            `
            
            <br><br><br>
            today 11/6 : ${today}<br>
            currentDate 11/6: ${currentDate}<br><br>
            firstDate_CD 11/1:${firstDate_CD}<br><br>
            <br>
            lastDate_CD 11/30  >>>> ${lastDate_CD}<br><br>
            <br>
            prev_lastDate_CD 10/31 >>>>> ${prev_lastDate_CD}<br><br><br>
            &nbsp;${firstDate_CD.getFullYear()}년&nbsp;&nbsp;&nbsp;&nbsp;${firstDate_CD.getMonth() + 1}월&nbsp;(월)
            `
        )
		
	}




});