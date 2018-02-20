<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주간예매순위</title>

<script type="text/javascript">

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
		document.f.submit();

	}
</script>

<link rel="stylesheet" href="/ticketfactory/resources/css/weekBest.css" type="text/css"/>

<script type="text/javascript" src="/ticketfactory/resources/js/modal.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>

</head>

<body bgcolor="#EEEEEE">

<div id="weekBestTotal">

	<!-- 메인 이미지 -->
	<img src="/ticketfactory/resources/image/weekBest.GIF" id="titleImg"/>
	
	<div id="col">
		<p class="ticketName">티켓명</p>
		<p class="showPlace">장소</p>
		<p class="showGrade">평점</p>
		<p class="showPrice">가격</p>
	</div>
	
 <form action="" method="post" name="f">
 <c:forEach var="searchList" items="${searchList }">
	
		<div id="ticketInfo"
		onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
				onMouseOut="this.style.border='0px'; this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
				onclick="go('${searchList.showId}','${searchList.showName }');">
		
			<img src="${searchList.showPoster }" class="poster">
				
				<table class="showInfo"
				>
					<tr><td style="padding-top: 16px; color: #757575;"> <!-- 공연하는 지역 -->
						${searchList.placeAddr } 
					</td></tr>
					
					<!-- 공연의 장르&이름 -->
					<tr><td style="font-weight: bold; font-size: 15px; padding-bottom: 13px; ">[${searchList.showGenre }]&nbsp;${searchList.showName }</td></tr>
					<!-- <tr><td></td></tr> -->
				</table>
			
			<p class="showPlace">
				${searchList.placeName }
			</p>
			<p class="showGrade">평점 
				<c:set var="complete" value="0"/>
				<c:forEach var="star" items="${avgStar }">
				<c:if test="${star.showId == searchList.showId }">
					${star.starAVG}
					<c:set var="complete" value="1"/>
				</c:if>
				</c:forEach>
				
				<c:if test="${complete==0 }">
				없음
				</c:if>
			
			</p>
			
			<p class="showPrice">
				<c:if test="${!empty searchList.seatState }">
					${searchList.seatState }
				</c:if>
				<c:if test="${empty searchList.seatState }">
					${searchList.showPrice }
				</c:if>
			
			</p>
			
			
		</div> <!-- ticketInfo DIV...end -->

	</c:forEach></form>

</div> <!-- weekBestTotal DIV...end -->




</body>
</html>




