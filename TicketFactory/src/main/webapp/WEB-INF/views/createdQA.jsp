<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/list.css" type="text/css"/> -->


</head>
<body>

<div>
	
	<form action="" name="qnaForm" method="post">
	<div>
		<div>
			<dl>
				<dt>작성자</dt>
				<dd>
					<input type="text" name="name" size="35" maxlength="20" class="boxTF"
					value="${sessionScope.loginDto}" readonly="readonly"/>
				</dd>							
			</dl>		
		</div>
		
		<div >
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
					<textarea rows="12" cols="63" name="content" class="boxTA"></textarea>
				</dd>							
			</dl>		
		</div> 
	
	</div>	
	
	<div id="bbsCreated_footer">
	<input type="button" value=" 등록 " class="btn2" 
	onclick="sendItQa();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
	onclick="document.qnaForm.content.focus();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/layout.action?showId=${sessionScope.showId}&showName=${show.showName}';"/>


	</div>
	
	</form>
	
</div>

</body>
</html>




































