<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>
<html>
<head>
	<title>Home</title>
</head>

<script type="text/javascript">

function go(showId, showName){
	
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId="+showId+"&showName=" + param;
	document.f.submit();

}

</script>


<body>

<form action="" method="post" name="f" id="f">
homeee
<br/><br/>
<c:set var="i" value="0"/>
<c:forEach var="dto" items="${lists }">
<c:if test="${i<5 }">
<%-- <a href="<%=cp%>/layout.action?showId=${dto.showId}&showName=${dto.showName}"> --%>
<img src="${dto.showPoster }" width="170" height="220" onclick="go('${dto.showId}','${dto.showName }')">&nbsp;${dto.showId }
<c:set var="i" value="${i+1 }"/>
</c:if>
</c:forEach>
</form>

<br/>
<a href="<%=cp %>/main.action">main</a><br/>
<a href="<%=cp %>/start.action">start</a><br/>
<a href="<%=cp %>/adminOneplus.action">adminOneplus</a><br/>


</body>
</html>
