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

<!-- css파일 -->

<link rel="stylesheet" href="/ticketfactory/resources/css/login.css" type="text/css"/>
<!-- <link rel="stylesheet" href="/ticketfactory/resources/css/start.css" type="text/css"/> -->
<link rel="stylesheet" href="<c:url value="/resources/css/seeMore.css"/>" type="text/css" />

<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- 내가 정의한 js파일 -->
<script type="text/javascript" src="/ticketfactory/resources/js/util.js"></script>
<!-- <script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script> -->




</head>
<body style="background-color : #EAEAEA;">


<!-- 회원가입 창의 전체골격 조정 -->
<form  method="post" name="myForm" >
<div id="session" >
	<div>
		<img src="/ticketfactory/resources/image/signImg1.png">
	</div>
	
	<div style="margin-left: 21px; margin-top: 10px; 
	float: left; color: #313131; 
	font-size:16px; font-weight:bold;">회원가입</div>
	<div style="margin-left:165px; margin-top: 12px; margin-bottom:15px;
	float: left; font-size: 12px; text-align: left; color: #313131;">
	* 필수 입력항목 (아이디/비밀번호는 4자 이상 입력해주세요)</div>

<!-- 입력창  -->

<table cellpadding="0" cellspacing="0">

<tr>
	<td>아이디* </td>
	<td><input type="text" name="userId" id="userId" onkeyup="id_checker();"><br/>
	<!-- 아작스부분(아이디 중복확인) -->
	<input type="text" id="id_check" name="id_check" 
	style="display: none; border: 0px; width: 281px; "
	readonly="readonly">
	</td>
</tr>	
<tr>
	<td>비밀번호* </td>
	<td><input type="password" name="userPwd" style="padding: 4px;"></td>
</tr>	
<tr>
	<td>비밀번호확인* </td>
	<td><input type="password" name="userPwd2" onkeyup="pwdChecker();" style="padding: 4px;" >
	<input type="text" name="pass_ok" readonly="readonly" id="pwdch"
	style="border: 0; width: 180pt; padding: 1px;">
	</td>
</tr>
<tr>
	<td>이름* </td>
	<td><input type="text" name="userName" ></td>
</tr>
<tr>
	<td>성별* </td>
	<td>
	<input type="radio" name="userGender" value="남자">
	<span class="radio_text" >남자</span>
	<input type="radio" name="userGender" value="여자">
	<span class="radio_text" >여자</span>
	</td>
</tr>

<tr>
	<td>Email* </td>
	<td><input type="text" name="user_email1" >
	<label style="font-size: 10pt; color : #5D5D5D;
	font-family: 맑은 고딕; ">@</label>
	<input type="text" name="user_email2" disabled="disabled" >
	<select name="emailchk" onchange="email_input()" class="selectbox" style="height: 20px;" >
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
	onkeypress="return isNumberKey(event)" style="ime-mode:disabled;">
	<span style="width: 150pt; color: #FF007F; font-size: 9pt;">
	숫자만 입력해주세요.
	</span>
	</td>
</tr>
<tr>
	<td>우편번호* </td>
	<td><input type="text" 
	name="userAddr_num" class="postcodify_postcode5" 
	value="" readonly="readonly" />
	<input type="button" id="postcodify_search_button" 
	value="검색" style="width: 40px; height: 26px;"></td>
</tr>
<tr>
	<td>주소* </td>
	<td><input type="text" 
	name="userAddr" class="postcodify_jibeon_address" 
	value="" id="address_dis" readonly="readonly" /></td>
</tr>
<tr>
	<td>상세주소* </td>
	<td><input type="text" 
	name="userAddr_detail" class="postcodify_details" 
	value="" id="address_dis" /></td>							
</tr>
</table><!-- 회원가입창끝 -->

<!-- 약관동의와 가입버튼 -->
	<div alt="약관동의" align="center" style="width:85%; margin:40px auto; "">
		<div style="font-size:13px; color:#656565;">
			<input type="checkbox" class="checkBox" name="agreement">
				<span style="font-size: 11px;">
				<a class="pink" id="custom_rule" style="cursor:pointer; text-decoration: none;">
				회원이용약관</a> 및 
				<a class="pink" id="custom_info" style="cursor:pointer; text-decoration: none;">
				개인정보 수집/이용</a>에 대해 동의합니다.</span>		
		</div>
	
		<div alt="가입버튼" style="text-align:center; margin:30px 0 50px 0;">
			<a href="javascript:sendIt();" >
			<input type="hidden" name="mode" value="sign">
			<img src="/ticketfactory/resources/image/btn_join_ok.png">
		</a>
		</div>
		
	</div>
</div>
</form><!-- 폼의 마지막 --><!-- 약관동의와 가입버튼끝 -->


</body>


</html>



