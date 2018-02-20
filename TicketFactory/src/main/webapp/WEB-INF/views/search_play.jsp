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
<title>Insert title here</title>
</head>
<body>
<table>
<c:set var="i" value="1"/>
<c:forEach var="dto" items="${searchList }">
<tr id="choose_play" onclick="spread_playName(${i});">
	<td>
	<img alt="포스터사진" src=" ${dto.showPoster }" style="width: 50px; height: 50px;">
	</td>
	<td>
	${dto.showName}
	<input type="hidden" id="showNameModal${i}" value="${dto.showName}">
	</td>
	<td>
	${dto.showId}
	<input type="hidden" id="showIdModal${i}" value="${dto.showId}">
	</td>
</tr>
<c:set var="i" value="${i+1}"/>
</c:forEach>
<tr>
	<td colspan="3">
	<p>
		<c:if test="${totalDataCount!=0 }">
			${pageIndexList }
		</c:if>
		<c:if test="${totalDataCount==0 }">
			등록된 게시물이 없습니다.
		</c:if>
			
	</p>
	</td>
</tr>

</table>

</body>
</html>