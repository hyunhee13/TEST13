<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<select id="selectTime" name="selectTime" onchange="calcPrice(this.value)" onclick="check()">

<option>시간선택</option>

<c:forEach var="dto" items="${SeatDTO }">
	
	<c:forEach var="i" begin="0" end="${su-1}" step="1">
	
	<fmt:parseNumber var="ticketPrice" value="${price[i]/100*70 }"/> 
	
		<c:set var="event" value="${show.event}"/>

	<c:if test="${i==0  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat1},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat1})</option>
	</c:if>
	
	<c:if test="${i==0 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat1},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat1})</option>
	</c:if>
	
	<c:if test="${i==1  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat2},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat1})</option>
	</c:if>
	
	<c:if test="${i==1 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat2},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat1})</option>
	</c:if>
	
	<c:if test="${i==2  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat3},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat3})</option>
	</c:if>
	
	<c:if test="${i==2 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat3},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat3})</option>
	</c:if>
	
	<c:if test="${i==3  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat4},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat4})</option>
	</c:if>
	
	<c:if test="${i==3 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat4},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat4})</option>
	</c:if>

	<c:if test="${i==4  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat5},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat5})</option>
	</c:if>
	
	<c:if test="${i==4 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat5},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat5})</option>
	</c:if>
	
	<c:if test="${i==5  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat6},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat6})</option>
	</c:if>
	
	<c:if test="${i==5 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat6},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat6})</option>
	</c:if>
	
	<c:if test="${i==6  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat7},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat7})</option>
	</c:if>
	
	<c:if test="${i==6 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat7},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat7})</option>
	</c:if>
	
	<c:if test="${i==7  && event!='oneplus'}">	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat8},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] ${event } (${dto.seat8})</option>
	</c:if>
	
	<c:if test="${i==7 && event=='oneplus'}">
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat8},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] <1+1행사> (${dto.seat8})</option>
	</c:if>
	<%-- <c:if test="${i==0 }">
	
		<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat1},${i+1}">
		시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat1})</option>
	</c:if>
	<c:if test="${i==1 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat2},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat2})</option>
	</c:if>
	<c:if test="${i==2 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat3},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat3})</option>
	</c:if>
	<c:if test="${i==3 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat4},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat4})</option>
	</c:if>
	<c:if test="${i==4 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat5},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat5})</option>
	</c:if>
	<c:if test="${i==5 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat6},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat6})</option>
	</c:if>
	<c:if test="${i==6 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat7},${i+1}"> 
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat7})</option>
	</c:if>
	<c:if test="${i==7 }">
	
	<option value="${dto.showTime },${seat[i]},${ticketPrice},${dto.seat8},${i+1}">
	시간:${dto.showTime} [${seat[i]} ${ticketPrice}원] (${dto.seat8})</option>
	</c:if> --%>
	
	</c:forEach>

</c:forEach>

</select>


		
		
		


</body>
</html>