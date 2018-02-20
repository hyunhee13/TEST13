<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>실시간 별점</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<script type="text/javascript"
	src="<c:url value="/resources/js/ajax.js"/>"></script>

<script>

$(document).ready(function () {  
	    var top = $('#adside').offset().top - parseFloat($('#adside').css('marginTop').replace(/auto/, 0));
	    $(window).scroll(function (event) {
	    var y = $(this).scrollTop();
	
	   if (y >= top) {
	      $('#adside').addClass('fixed');
	   } else {
	      $('#adside').removeClass('fixed');
	  }
	});
});

function changeReviewBoard(page){

	
	location.href="<%=cp%>/changeReviewBoard.action";
	
}
</script>

<style type="text/css">
.effect:hover{

	background-color: #EAEAEA;
	 
}  
</style>


<script type="text/javascript">
	
	function color(){
		
		$("#b").css("color","#FF007F");
		
	}
	
</script>


</head>
<body onload="color();">

<div id="Wrap">
	<div id="section_wrap">
		
		
		<div id="talk_menu">

			<div class="talk_menu_home">
				<p><a href="bbs_list.php?tb=talk_main"><span class="talk_menu_off">티켓톡 홈</span></a></p>
			</div>
			<div class="talk_menu_title_bar"></div>

			<div class="talk_menu_sub">
				<p><a href="<%=cp%>/eventList.action"><span class="talk_menu_on" id="a">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span></a>
				</p>
				
				<p><a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on" id="b">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">실시간 별점</span></a>
				</p>
				<p>
					<a href="<%=cp%>/yangdoList.action"><span class="talk_menu_on" id="c">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">티켓양도</span>
					</a>
				</p>

			</div>

			<div class="talk_menu_title_bar2"></div>

		</div>
		 
		<div id="right_content">
			<div style="padding-bottom:30px;">
				<div style="padding:23px 23px 0 23px;">
					<div class="talk_title">
					실시간별점
					</div>
				
					<div class="talk_subtitle">
					실시간으로 올라오는 리뷰를 참고하세요!&nbsp;
					공연 별 전체 평점도 알아 볼 수 있습니다.<br/>
					<b>이제는 공연도 비교해보고 똑똑하게 예매하세요.</b>
					</div>
					<div style="float: right;">
						<input type="button" class="reviewTxt" id="byPlay" value="▶ 연극별 별점 바로가기 ▶"
						onclick="changeReviewBoard();">

					</div>
<br/><br/>
				<div id="reviewList">
					<center>
					<c:forEach var="dto" items="${lists}">
						<hr style="border: 2px dotted #FFB2D9;">
						<div style="padding:15px; width: 750px; height: 135px; float: left;" class="effect">
						<a href="layout.action?showId=${dto.showId }">

						<div style="text-align:left;">
							<!--왼쪽 이미지-->
							<div style="float:left;">
								
								<img src='${dto.showPoster }' alt="test" style="width:160px; height: 130px;">
								
							</div>
				
							<!--오른쪽 티켓정보-->

							<div style="margin-left:170px;padding-top:8px;">
								
								<div class="ellipsis" style="width:530px; height:30px; vertical-align:bottom;">
									<span style="font-size:15px; font-weight:600; color:#313131;">제목 : ${dto.showName }</span>
									
								</div>
				
								
				
								<c:if test="${empty mode }">
								<div>
									<span style="font-size:14px; color:#e81b19; padding-bottom:10px; vertical-align:bottom;">관객평점 : <img alt="test" src="${dto.star2 }"></span>
								</div><br/>
								
								<div style="height:25px; padding-top:5px; vertical-align:bottom;">
									<div style="float:left; vertical-align:bottom;">${dto.name }</div>
									<div style="float:left; text-align:right; vertical-align:bottom;"><span style="color:#aaa; padding:0 10px;">|</span>${dto.created }</div>		
									<div style="vertical-align:bottom;"><span style="color:#aaa; padding:0 10px;">|</span>장&nbsp;소 : ${dto.showPlace } </div>
									<div style="margin-bottom:10px;; line-height:1.9em;">
									<span style="padding-left:7px; font-size: 15px; color: #F361A6;"><b>${dto.content }</b></span>
									</div>
								</div>
								</c:if>
								
								<c:if test="${!empty mode }">
								
								<div>
									<span style="font-size:14px; color:#e81b19; padding-bottom:10px; vertical-align:bottom; font-weight: bold;">평균평점 : <img alt="test" src="${dto.star2 }"></span>
								</div><br/>
								<div style="height:25px; padding-top:5px; vertical-align:bottom;">
									<div style="vertical-align:bottom; font-weight: bold;">장&nbsp;소 : ${dto.showPlace } </div>
								</div>
								</c:if>
							
							
								
				
							</div>
							

						</div>
					
						</a>
					</div>
					
					</c:forEach>					
					</center>
				</div>
					
		
					<div style="margin-top:20px; margin-bottom:20px; text-align: center; width: 100%">
							<div>
								<c:if test="${dataCount!=0 }">
									${pageIndexList }
								</c:if>
								<c:if test="${dataCount==0 }">
									등록 된 게시물이 없습니다.
								</c:if>
							</div>
					</div>
					

				</div>
			</div>

		</div>
	</div>
</div>



</body>
</html>