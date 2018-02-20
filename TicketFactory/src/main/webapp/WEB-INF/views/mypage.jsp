<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${userPwd}</title>
<!-- css파일 -->
<link rel="stylesheet" href="/ticketfactory/resources/css/mypage.css" type="text/css"/>

<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- 내가 정의한 js파일 -->
<script type="text/javascript" src="/ticketfactory/resources/js/util.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>


<script type="text/javascript">

//화면이 시작되면 데이터를 불러와서 출력
$(function () {
	var mypageNum = ${mypageNum};
	$("#mypage_01").attr("src","/ticketfactory/resources/image/btn_mypage_01_off.png");
	$("#mypage_02").attr("src","/ticketfactory/resources/image/btn_mypage_02_off.png");
	$("#mypage_03").attr("src","/ticketfactory/resources/image/btn_mypage_03_off.png");
	$("#mypage_04").attr("src","/ticketfactory/resources/image/btn_mypage_04_off.png");
	startPage(mypageNum);
});

function startPage(mypageNum) {

	var params = "mypageNum=" + mypageNum
	+"&pageNum=" + ${pageNum};
	
	$.ajax({
		
		type:"POST",
		url:"<%=cp%>/mypage_"+"0"+mypageNum+".action",
		data:params,
		success:function(args){
			
			
			$("#main_show").html(args);
			$("#mypage_"+"0" +mypageNum).attr("src","/ticketfactory/resources/image/btn_mypage_"+"0" +mypageNum+"_on.png");
			
			
		},
		
		error:function(e){
			alert("로그인이 필요합니다.\n로그인 후 이용해주세요.^^");
		}
		
		
	});
	
	
}

//등록하기 버튼을 클릭하면 실행
//이미지변경 및 내용변경 일어남
$(document).ready(function mypage() {
	
	$("#mypage_01").click(function () {
		
		var params = "dhdh";
		
		$.ajax({
			
			type:"POST",
			url:"<%=cp%>/mypage_01.action",
			data:params,
			success:function(args){
				
				$("#main_show").html(args);
				$("#mypage_01").attr("src","/ticketfactory/resources/image/btn_mypage_01_on.png");
				$("#mypage_02").attr("src","/ticketfactory/resources/image/btn_mypage_02_off.png");
				$("#mypage_03").attr("src","/ticketfactory/resources/image/btn_mypage_03_off.png");
				$("#mypage_04").attr("src","/ticketfactory/resources/image/btn_mypage_04_off.png");
				
			},
			
			error:function(e){
				alert("로그인이 필요합니다.\n로그인 후 이용해주세요.^^");
			}
			
			
		});
		
	});
	
	$("#mypage_02").click(function () {
			
			var params = "dhdh";
			
			$.ajax({
				
				type:"POST",
				url:"<%=cp%>/mypage_02.action",
				data:params,
				success:function(args){
					
					$("#main_show").html(args);
					$("#mypage_01").attr("src","/ticketfactory/resources/image/btn_mypage_01_off.png");
					$("#mypage_02").attr("src","/ticketfactory/resources/image/btn_mypage_02_on.png");
					$("#mypage_03").attr("src","/ticketfactory/resources/image/btn_mypage_03_off.png");
					$("#mypage_04").attr("src","/ticketfactory/resources/image/btn_mypage_04_off.png");
				},
				
				error:function(e){
					alert("로그인이 필요합니다.\n로그인 후 이용해주세요.^^");
				}
				
				
			});
			
		});
	
	$("#mypage_03").click(function () {
		
		var params = "dhdh";
		
		$.ajax({
			
			type:"POST",
			url:"<%=cp%>/mypage_03.action",
			data:params,
			success:function(args){
				
				$("#main_show").html(args);
				$("#mypage_01").attr("src","/ticketfactory/resources/image/btn_mypage_01_off.png");
				$("#mypage_02").attr("src","/ticketfactory/resources/image/btn_mypage_02_off.png");
				$("#mypage_03").attr("src","/ticketfactory/resources/image/btn_mypage_03_on.png");
				$("#mypage_04").attr("src","/ticketfactory/resources/image/btn_mypage_04_off.png");
				
			},
			
			error:function(e){
				alert("로그인이 필요합니다.\n로그인 후 이용해주세요.^^");
			}
			
			
		});
		
	});
	
	$("#mypage_04").click(function () {
		
		var params = "dhdh";
		
		$.ajax({
			
			type:"POST",
			url:"<%=cp%>/mypage_04.action",
			data:params,
			success:function(args){
				
				$("#main_show").html(args);
				$("#mypage_01").attr("src","/ticketfactory/resources/image/btn_mypage_01_off.png");
				$("#mypage_02").attr("src","/ticketfactory/resources/image/btn_mypage_02_off.png");
				$("#mypage_03").attr("src","/ticketfactory/resources/image/btn_mypage_03_off.png");
				$("#mypage_04").attr("src","/ticketfactory/resources/image/btn_mypage_04_on.png");
				
			},
			
			error:function(e){
				alert("로그인이 필요합니다.\n로그인 후 이용해주세요.^^");
			}
			
			
		});
		
	});
	
	
	
});

</script>


</head>
<body>


<!-- 마이페이지 부분 -->
<div id="mypage_session">
	<!-- side bar 부분 -->
	<div id="mypage_aside">
		<div>
			<img alt="마이페이지" 
			src="/ticketfactory/resources/image/title_mypage.png" ">
		</div>
		<div >
		<p align="center" style="padding-top:15px; background-color:#ddd; font-size: 10pt; ">
		내 포인트</p>
		<p align="center" style="padding-bottom:15px; background-color:#ddd; font-size: 10pt; ">
		<span style="font-size:20px; color:#ed3d84; font-weight:bold;">${loginDto.userPoint }</span>
		P</p>
		</div>
		<div>
		<img alt="구매내역" 
			src="/ticketfactory/resources/image/btn_mypage_01_on.png" 
			id="mypage_01">	
		</div>
		<div>
		<img alt="포인트내역" 
			src="/ticketfactory/resources/image/btn_mypage_02_off.png"
			id="mypage_02" >
		</div>
		<div>
		<img alt="회원정보수정" 
			src="/ticketfactory/resources/image/btn_mypage_03_off.png"
			id="mypage_03" >
		</div>
		<div>
		<img alt="내 문의내역" 
			src="/ticketfactory/resources/image/btn_mypage_04_off.png"
			id="mypage_04">
		</div>
	</div><!-- side bar 부분끝 -->
	
	<!-- 마이페이지 main부분 -->
	<div id="mypage_main">
		<p></p>
		<!-- ajax로 값받아와서 뿌려주는 부분 -->
		<div class="mypage_main_title" id="main_show"></div>		
	</div><!-- 마이페이지 main부분끝 -->

</div>


</body>
</html>
