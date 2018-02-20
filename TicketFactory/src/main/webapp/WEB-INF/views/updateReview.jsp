<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" href="/springwebmybatis/resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="/springwebmybatis/resources/css/created.css" type="text/css"/>

<script type="text/javascript" src="/springwebmybatis/resources/js/util.js"></script>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.name.focus();
			return;
		}		
		/*
		if(!isValidKorean(str)){			
			alert("\n이름을 정확히 입력하세요.");
			f.name.focus();
			return;
		}
		*/
		f.name.value = str;
		
		if(f.email.value){
			
			if(!isValidEmail(f.email.value)){
				alert("\n정상적인 E-Mail을 입력하세요.");
				f.email.focus();
				return;
			}
		}
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		
		str = f.pwd.value;
		str = str.trim();
		if(!str){
			alert("\n패스워드를 입력하세요.");
			f.pwd.focus();
			return;
		}
		f.pwd.value = str;
		
		
		f.action = "created_ok.action";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="bbs">
	
	<form action="" name="myForm" method="post">
		<div class="createdForm">
		<div class="">
			<dl>
				<dt style="padding-bottom: 8px; padding-left: 30px;font-size: 18px;white-space: normal;color: #000;display: inline-block;font-weight: bold;">Username</dt>
				<dd>
					<input type="text" name="name" size="35" maxlength="20" class="form1"
					value="${sessionScope.loginDto.userId}" style="border: 1px solid #d6d6d6; border-radius: 5px; box-shadow: inset 0 1px 4px #AAA;
					 width: 327px; height: 21px;" readonly="readonly"/>
				</dd>							
			</dl>		
		</div>
			
		<div>
			<dl>
				<dt style="padding-bottom: 8px; padding-left: 30px;font-size: 18px;white-space: normal;color: #000;display: inline-block;font-weight: bold;">StarPoint</dt>
				<dd>
					<select name="star" style="border: 1px solid #d6d6d6; border-radius: 5px; box-shadow: inset 0 1px 4px #AAA;
					 width: 327px; height: 21px;">
						<option value="5">★ ★ ★ ★ ★</option>
						<option value="4">★ ★ ★ ★ ☆</option>
						<option value="3">★ ★ ★ ☆ ☆</option>
						<option value="2">★ ★ ☆ ☆ ☆</option>
						<option value="1">★ ☆ ☆ ☆ ☆</option>
					</select>
				</dd>							
			</dl>		
		</div>
		
	
		<div id="bbsCreated_content" >
			<dl>
				<dt style="padding-bottom: 8px; padding-left: 30px;font-size: 18px;white-space: normal;color: #000;display: inline-block;font-weight: bold;">내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
					<textarea rows="12" cols="63" name="content" style="border: 1px solid #d6d6d6; border-radius: 5px; box-shadow: inset 0 1px 4px #AAA;
					 width: 630px; height: 300px;"></textarea>
				</dd>							
			</dl>		
		</div><br/>
	
	<div id="bbsCreated_footer">
	<input type="button" value=" 수정하기 " class="button1" 
	onclick="sendReview();"/>
	<input type="reset" value=" 다시입력 " class="button2" 
	onclick="document.myForm.subject.focus();"/>
	<input type="button" value=" 작성취소 " class="button3" 
	onclick="javascript:location.href='<%=cp%>/layout.action?showId=${sessionScope.showId}&showName=${show.showName}';"/>	
	</div>
	</div>
	<input type="hidden" name="num" value="${dto.num }">
	
	</form>
	
</div>

</body>
</html>




































