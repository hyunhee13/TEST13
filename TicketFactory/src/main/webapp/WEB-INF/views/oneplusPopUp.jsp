<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/ticketfactory/resources/css/adminOneplus.css" type="text/css"/>
<script type="text/javascript">
    self.window.focus();
</script>



<script type="text/javascript">

	function addPlus(){
		
		alert("티켓을 추가하시겠습니까?");
		document.f.action="addOneplus.action";
		document.f.submit();
		opener.parent.oneplusReload('${state}','${genre}');
		 self.close();
	}
	
	function removePlus(){
		
		alert("티켓을 삭제하시겠습니까?");
		document.f.action="removeOneplus.action";
		document.f.submit();
		opener.parent.oneplusReload('${state}','${genre}');
		 self.close();
	}
	
	

</script>

</head>
<body>

<form action="" name="f" method="post">
<table class="type09">
    <thead>
    <tr>
        <th scope="cols">SHOWID</th>
        <th scope="cols">SHOWNAME</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="dto" items="${lists }">
	    <tr>
	        <th scope="row">${dto.showId }</th>
	        <td style="text-align: center;">${dto.showName }</td>
	    </tr>   
    </c:forEach>
    </tbody>
</table>
<br/>
<c:if test="${state=='add' }">
<p id="pLoc">* 최종 추가 전에 티켓을 잘 확인해주세요.</p>
<input type="button" value="1+1티켓 추가하기" onclick="addPlus();" class="css3button"></c:if>
<c:if test="${state=='remove' }">
<p id="pLoc">* 최종 삭제 전에 티켓을 잘 확인해주세요.</p>
<input type="button" value="1+1티켓 삭제하기" onclick="removePlus();" class="css3button"></c:if>

<input type="hidden" name="selected" value="${selected }">

</form>

</body>
</html>