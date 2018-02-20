<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<select id="selectDate"
		onchange="changeTime(this.value,'${showId }')"
		onclick="check_play()">
		<option value="">날짜선택</option>
		<c:forEach var="date" items="${date }">
			<option value="${date.showDate },${date.showDay}">${date.showDate }[${date.showDay }]</option>
		</c:forEach>
	</select>

</body>
</html>