<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/list.css" type="text/css"/>
<link rel="stylesheet" href="<c:url value="/resources/css/detail2.css"/>" type="text/css"/>

<style type="text/css">
.classname {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) );
	background:-moz-linear-gradient( center top, #ededed 5%, #dfdfdf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf');
	background-color:#ededed;
	-webkit-border-top-left-radius:12px;
	-moz-border-radius-topleft:12px;
	border-top-left-radius:12px;
	-webkit-border-top-right-radius:12px;
	-moz-border-radius-topright:12px;
	border-top-right-radius:12px;
	-webkit-border-bottom-right-radius:12px;
	-moz-border-radius-bottomright:12px;
	border-bottom-right-radius:12px;
	-webkit-border-bottom-left-radius:12px;
	-moz-border-radius-bottomleft:12px;
	border-bottom-left-radius:12px;
	text-indent:0px;
	border:1px solid #dcdcdc;
	display:inline-block;
	color:#777777;
	font-family:arial;
	font-size:14px;
	font-weight:bold;
	font-style:normal;
	height:25px;
	line-height:25px;
	width:47px;
	text-decoration:none;
	text-align:center;
	text-shadow:1px 1px 0px #ffffff;
}
.classname:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) );
	background:-moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed');
	background-color:#dfdfdf;
}.classname:active {
	position:relative;
	top:1px;
}</style>

</head>

<body>

<h2><font color="#313131" style="font-family: tahoma;">
실제 구매 회원님들의 생생한 <font color="#FF007F">관람후기</font></font></h2><br/>

<!-- 작성버튼 -->
<c:if test="${message=='댓글사용가능' }">
<div >
		<p class="content">
		<input type="button" value="" class="reviewButton" onclick="changeView('created.action','${sessionScope.showId}','${dto.num }');">
		</p>
</div><br/>
</c:if>
<hr>

<div align="center" style="font-size: 20px;">
<c:if test="${lists.isEmpty()}">
	리뷰가 존재하지 않습니다
</c:if>
</div>

<c:forEach var="dto" items="${lists}">
<div id="reviewContainer" class="reviewContainer">
<div id="reviewTop" class="reviewTop">
<font class="reviewContent">작성자 : ${dto.userId}│ 작성날짜 : ${dto.created } <span style="float: right; width: 100px;"><img alt="test" src="${dto.star2}"></span></font>
								<c:if test="${message=='댓글사용가능'}">
								<c:if test="${sessionScope.loginDto.userId==dto.userId }">
								│ <input type="button" value="수정" class="classname" onclick="changeReview('updateReview.action','${sessionScope.showId}','${dto.num }');" 
								id="detail_btn" name="detail_btn">
								
								│ <a href="<%=cp%>/deleted_ok.action?num=${dto.num}"><img alt="" src="/ticketfactory/resources/image/delete.png"></a> 
								</c:if>
								</c:if> 
								
</div>

<div id="reviewBottom" class="reviewBottom">
<font class="reviewContent">${dto.content }</font>
</div></div>
</c:forEach>

<br/>

<!-- 페이징 -->
<div>
	<c:if test="${dataCount!=0 }">
			${pageIndexList }
	</c:if>
	<c:if test="${dataCount==0 }">
			등록된게시물이 없습니다.
	</c:if>
</div>
<br/>


<%-- <div class="menubar" id="created">
		<p class="content">
		<input type="button" value="WRITE" class="submit-button"
		onclick="changeView('created.action','${sessionScope.showId}');" id="detail_btn" name="detail_btn">
		</p>
</div> --%>






</body>
</html>