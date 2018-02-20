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

<link rel="stylesheet" href="/ticketfactory/resources/css/login.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/delete.css" type="text/css"/>

<script type="text/javascript">
/* 고객센터 탭에 마우스 올리고 내릴시 동작 */
function change(obj,a) {
	if (a==1) {
		obj.style.visibility = "visible";
	}
	
	if (a==2) {
		obj.style.visibility = "hidden";
	}
	 
	}
</script>



</head>
<body>


<div id="delete_session">
	<div id="delete_session_1">
	<table  width="100%">
	<tr>
		<td>
			<img alt="회원탈퇴" src="/ticketfactory/resources/image/custom_out.gif">
		</td>
	</tr>
	<tr>
		<td>
			<div id="delete_session_2">
				<table style="border: 1px dashed black;" width="100%">
				  <tr>
				  	<td>
				  		<div id="delete_session_3">
				  			<table style="font-size: 13px;" width="100%"  id="delete_info">
				  			<tr style="height: 30px">
					  			<td>
							  	&nbsp;&nbsp;&nbsp;&nbsp;
							  	</td>
							  	<td>
							  	<span style="color: red;">※ 회원 탈퇴 전 유의사항</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	회원탈퇴 신청 후에는 회원전용 서비스의 이용이 불가능합니다
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	회원 탈퇴 후 잔여 포인트는 모두 삭제되며 환불되지 않습니다. 포인트를 먼저 소진하신 후 탈퇴를 권장드립니다.
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  <span>
							  	회원탈퇴 이후에는 게시물 수정 및 삭제가 불가능합니다. 사전에 작성한 게시물을 수정하거나 삭제하기를 원하시는 경우에는 먼저 해당 게시물을
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	수정/삭제 하신 후 회원탈퇴를 해주시기 바랍니다.
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	[전자상거래등에서의소비자보호에관한법률], [통신비밀보호법], [정보통신망이용촉진및정보보호에관한법률] 등의 법률에 근거하여 계약 또는
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	 <tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	청약철회에 관한 기록, 대금결제 및 재화 등의 공급에 관한 기록은 일정기간 동안 그 정보를 보존합니다.
							  	</span>
							  	</td>
						  	</tr>
						  	
						  	<tr style="height: 30px">
					  			<td>
							  	<p>*</p>
							  	</td>
							  	<td>
							  	<span>
							  	회원탈퇴 이후에도 재가입이 가능합니다. 탈퇴 후 타임티켓 서비스를 다시 이용하고자 하는 경우에는 새로 회원가입을 해주시기 바랍니다
							  	</span>
							  	</td>
						  	</tr>
						  	</table>
						  </div>	
				  	</td>
				  </tr>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div id="delete_session_4">
				<table width="100%" style=" height: 45px; background-color:#EAEAEA ">
					<tr>
						<td>
							<label style="padding: 2px 5px; font-size: 13px;">
							※ 아래 정보를 다시 한번 입력한 후 회원탈퇴 버튼을 클릭하시면, 탈퇴처리 됩니다.
							</label>
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div id="delete_session_5">
			<form action="<%=cp%>/delete_ok.action" id="memOutForm" method="post">
				<table width="100%" style=" height: 80px; background-color: #EAEAEA">
					<tr>
						<td>
							<label style="padding: 2px 10px; font-size: 13px;">
							아이디
							</label>
						</td>
						<td>
							<input type="text" id="mem_out_id" name="userId" 
							style="width: 150px; height: 25px; padding: 0px;">
						</td>
					</tr>
						<tr>
						<td>
							<label style="padding: 2px 10px; font-size: 13px;">
							비밀번호
							</label>
						</td>
						<td>
							<input type="password" id="mem_out_pwd" name="userPwd" 
							style="width: 150px; height: 25px; padding: 0px;">		
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="text" id="mem_out_check" 
							style="border: 0px; display: none; background-color: #EAEAEA;
							width: 210px;"
							readonly="readonly">
						</td>
					</tr>	
				</table>
			</form><!-- 폼의 끝 -->
			</div>
		</td>
	</tr>
	<tr>
		<td>
		<div id="delete_session_6">
			<table width="100%" style="height: 80px;">
				<tr>
					<td>					
						<a id="mem_out_btn" style="cursor: pointer;">
							<img alt="회원탈퇴" 
							src="/ticketfactory/resources/image/member_mod_out_btn.gif">	
						</a>	
					</td>
				<tr>
			</table>			
		</div>
		
		</td>
	</tr>	
	</table>	
</div>
</div>


</body>
</html>
