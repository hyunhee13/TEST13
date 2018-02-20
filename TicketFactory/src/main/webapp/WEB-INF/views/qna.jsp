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

<link rel="stylesheet" href="<c:url value="/resources/css/detail2.css"/>" type="text/css"/>
<link rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"
	type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/top.css"/>"
type="text/css" />

<style type="text/css">
.answerQA {
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
	height:15px;
	float:inherit;
	line-height:25px;
	width:15px;
	text-decoration:none;
	text-align:justify;
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

<!-- <script type="text/javascript">

	function sendItQnaReply(groupNum,showId){
		
		f = document.qnaForm;
					
		if(!str){
			alert("\n작성자를 입력하세요.");
			f.name.focus();
			return;
		}			
			
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		alert(groupNum);
		alert(showId);
		f.action = "created_okQnaReply.action?groupNum="+groupNum+"&showId="+showId;
		f.submit();
	
	}
</script> -->

<script type="text/javascript">

	function sendItQa(){
		
		f = document.myFormQA{
			
			
		str = f.nameQA.value;
		str = str.trim();
		if(!str){
			alert("\n작성자를 입력하세요.");
			f.nameQA.focus();
			return;
		}			
			
		str = f.contentQA.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.contentQA.focus();
			return;
		}
		f.contentQA.value = str;
		
		f.action = "created_okQA.action";
		f.submit();
	
	}
</script>

</head>
<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr height="100%">
	<td width="50%">
		<h2><font color="#313131" style="font-family: tahoma;">
		티켓 관련 문의사항을 남겨주세요</font></h2>
	</td>
	<td width="50%" style="padding-right: 10px;">
		<a href="eqList.action"><img alt="" src="<%=cp %>/resources/image/qna_btn.png" align="right"></a>
	</td>
</tr>
<tr height="100%">
	<td align="right" colspan="2" width="100%" style="padding-right: 10px;">
		<font color="red" style="font-family: 맑은 고딕; font-size: 10pt;">
		
		
	<%-- 	<div style="float: left;">
		<p class="content">
		<input type="button" value="" class="qnaButton" onclick="changeView('createdQna.action','${sessionScope.showId}');">
		</p>
		</div> --%>
		
		 
		
		
		※취소 및 환불 문의는 '1:1문의하기'를 이용해주세요.</font>
	</td>
</tr>
</table><hr/>
<br/>


<!-- qna 리스트 -->
<div id="allQna_wrap">
<form action="" method="post" name="qnaForm">
<div id="qnawrite">

<textarea name="content" rows="4" style="height:80px; width:486px; margin : 20px auto;
border-color:#bababa; border-width:1px; border-style:solid; background-color:#FFFFFF; padding-left: 5px; padding-top: 2px;">
</textarea>

<input type="hidden" name="userIdQna" value="${loginDto }">

<input type="image" src="/ticketfactory/resources/image/btn_reply_ok.png" onclick="sendItQa();" value="글쓰기">

</div>
</form>
<c:forEach var="dtoQna" items="${listsQA}">
<c:if test="${dtoQna.depth == 0 }">
	<div id="balloon" class="balloon">
	작성자 : ${dtoQna.userId} │ ${dtoQna.created } &nbsp; 
	<c:if test="${sessionScope.loginDto.userId==dtoQna.userId }">
	<a href="<%=cp%>/deleted_okQna.action?boardNum=${dtoQna.boardNum}" style="margin-top: 10px;"><img alt="" src="/ticketfactory/resources/image/delete.png" ></a>
	</c:if>
	<img alt="" src="/ticketfactory/resources/image/delete.png" style="visibility: hidden;">
	<br/>
	&nbsp;&nbsp;&nbsp;<span class="Q">Q.&nbsp;</span>${dtoQna.content }. 
	<c:if test="${adminDto!=null}">
	<input type="image" src="/ticketfactory/resources/image/reply.png" value="답변" class="answerQA" onclick="changeView('createdQnaReply.action','${sessionScope.showId}','${dtoQna.groupNum }','${dtoQna.boardNum }');"/>
	</c:if>
	</div>
</c:if>
<c:if test="${dtoQna.depth != 0 }">
	<div id="answer" class="answer">	
	작성자 : ${dtoQna.name } │ ${dtoQna.created } &nbsp; 
	<c:if test="${adminDto!=null}">
	<a href="<%=cp%>/deleted_okQna.action?boardNum=${dtoQna.boardNum}"><img alt="" src="/ticketfactory/resources/image/delete.png"></a>
	</c:if>
	<img alt="" src="/ticketfactory/resources/image/delete.png" style="visibility: hidden;"/>
	<br/>
	&nbsp;&nbsp;&nbsp;<span class="A">A.&nbsp;</span>${dtoQna.content }
	</div>
	
</c:if>	
</c:forEach>
</div>


</body>
</html>