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
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>

 
</head>
<body>

<img src="/ticketfactory/resources/image/title_my_modify.png" style="padding:0 0 0 2px; margin-left: 18px;" alt="구매내역">	
	<div style="float:right; padding-right:18px; padding-top: 3px;
		line-height:25px; font-size: 10pt; ">
	</div>
	<div class="mypage_main_bar"></div>
	
<form  method="post" name="myForm" >
<div id="session" style="height: 500px; margin: 10px auto;">
<!-- 입력창  -->
<table cellpadding="0" cellspacing="0">

<tr>
	<td>아이디* </td>
	<td><input type="text" name="userId" id="userId" 
	readonly="readonly" value="${loginDto.userId }" style="border: 0px;">
	<!-- 아작스부분(아이디 중복확인) -->
	</td>
</tr>	
<tr>
	<td>비밀번호* </td>
	<td>
	<input type="password" name="userPwd" style="padding: 4px;" value="${loginDto.userPwd }">
	<!-- 업데이트 안할시 원래 패스워드로 유지 -->
	
	</td>
</tr>	
<tr>
	<td>비밀번호확인* </td>
	<td><input type="password" name="userPwd2" 
	onkeyup="pwdChecker();" style="padding: 4px;" value="${loginDto.userPwd }">
	<input type="text" name="pass_ok" readonly="readonly" id="pwdch"
	style="border: 0; width: 180pt; padding: 1px;" >
	</td>
</tr>
<tr>
	<td>이름* </td>
	<td>
	<input type="text" name="userName" 
	value="${loginDto.userName }" readonly="readonly"
	style="border: 0px;" >
	</td>
</tr>
<tr>
	<td>성별* </td>
	<td>
	<c:if test="${loginDto.userGender=='남자' }">
	<input type="radio" name="userGender" value="남자" checked="checked">
	<span class="radio_text" >남자</span>
	<input type="radio" name="userGender" value="여자">
	<span class="radio_text" >여자</span>
	</c:if>
	<c:if test="${loginDto.userGender=='여자'}">
	<input type="radio" name="userGender" value="남자" >
	<span class="radio_text" >남자</span>
	<input type="radio" name="userGender" value="여자" checked="checked">
	<span class="radio_text" >여자</span>
	</c:if>
	</td>
</tr>

<tr >
	<td>Email* </td>
	<td><input type="text" name="user_email1" value="${email_first }">
	<label style="font-size: 10pt; color : #5D5D5D;
	font-family: 맑은 고딕; ">@</label>
	<input type="text" name="user_email2" disabled="disabled" value="${email_last }">
	<select name="emailchk" onchange="email_input()" class="selectbox" style="height: 31px;">
		<option value="0">선택하세요</option>
		<option value="9">직접입력</option>
		<option value="hanmail.net">hanmail.net</option>
		<option value="naver.com">naver.com</option>
		<option value="daum.net">daum.net</option>
		<option value="nate.com">nate.com</option>
		<option value="gmail.com">gmail.com</option>	
	</select>
	<input type="hidden" name="userEmail" ><!-- 넘길때 받을 진짜 값  -->
	</td>
</tr>

<tr>
	<td>전화번호* </td>
	<td><input type="text" name="userTel"
	onkeypress="return isNumberKey(event)"
	style="ime-mode:disabled;" value="${loginDto.userTel }">
	<span style="width: 150pt; color: #FF007F; font-size: 9pt;">
	숫자만 입력해주세요.
	</span>
	</td>
</tr>
<tr>
	<td>우편번호* </td>
	<td><input type="text" 
	name="userAddr_num" class="postcodify_postcode5" 
	value="${loginDto.userAddr_num }" readonly="readonly"/>
	<input type="button" id="postcodify_search_button" 
	value="검색" style="width: 40px; height: 25px;"></td>
</tr>
<tr>
	<td>주소* </td>
	<td><input type="text" 
	name="userAddr" class="postcodify_jibeon_address" 
	value="${loginDto.userAddr }" id="address_dis" readonly="readonly" /></td>
</tr>
<tr>
	<td>상세주소* </td>
	<td><input type="text" 
	name="userAddr_detail" class="postcodify_details" 
	value="${loginDto.userAddr_detail }" id="address_dis" /></td>							
</tr>
</table><!-- 회원가입창끝 -->

<div alt="수정버튼,탈퇴버튼" style="text-align:center; margin:30px 0 50px 0;">
	<a href="javascript:sendIt();">
		<input type="hidden" name="mode" value="mypage">
		<input type="hidden" name="mypageNum" value="1">
		<input type="hidden" name="pageNum" value="${pageNum }">
		<img src="/ticketfactory/resources/image/btn_member_modify.png"
		class="modify_btn">
	</a>
	<a href="<%=cp%>/delete.action">
		<img src="/ticketfactory/resources/image/btn_member_out.png"
		class="modify_btn" style="margin-left: 10px;">
	</a>
</div>
	
</div>
</form>
</body>
</html>