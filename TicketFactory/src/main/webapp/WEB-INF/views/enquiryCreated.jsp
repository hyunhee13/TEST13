<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script>

<script src="/ticketfactory/resources/js/menu.js"></script>
<script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;

	 	str = f.eqType.value;
		/* str = str.trim(); */
		if(!str){
			alert("\n문의유형을 선택하세요.");
			f.eqType.focus();
			return;
		}
		f.eqType.value = str; 
		
		str = f.eqProduct1.value;
		str2 = f.eqProduct2.value;
		str = str.trim();
		str2 = str2.trim();
		if(!str && !str2){
			alert("\n문의상품을 선택하세요.");
			return;
		}
		if(!str){
			f.eqProduct.value=str2;
		}else if(!str2){
			f.eqProduct.value=str;
		}
		
		str = f.eqSubject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.eqSubject.focus();
			return;
		}
		f.eqSubject.value = str;
		
		str = f.eqContent.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.eqContent.focus();
			return;
		} 
		f.eqContent.value = str; 
		
		f.action = "<%=cp%>/eqCreated_ok.action";
		f.submit();
		
	}


</script>


<title>슈비두바</title>
</head>

<body>
<div class="wrap_topmargin">

	<table style="margin:auto;border:1px solid #d8d8d8;background-color:#ffffff;">
		<tr>
			<td>
				<div class="cs_wrap">
				
				<!-- 왼쪽메뉴창 -->
					<div class="cs_left_menu">
						<div class="cs_left_menu_title">
							<img src="/ticketfactory/resources/image/img_cstitle.png">
						</div>

						
						<div class="cs_left_menu_sub">
				
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/notiList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_notice_off.png" alt="공지사항">
								</p>
							</div>
							
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/faqList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_faq_off.png" alt="자주묻는질문">
								</p>
							</div>
						
							<div class="cs_left_menu_sub1">
								<p onclick="idCheck();" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_private_on.png" alt="일대일문의">
								</p>
							</div>
						
							<div class="cs_left_menu_sub2">
								<p onclick="javascript:location.href='<%=cp%>/refundList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_refund.png" alt="환불취소안내">
								</p>
							</div>
						</div>	
					</div>
				<!-- 왼쪽메뉴창 끝 -->
				
			
			<!-- 게시판부분 -->
				<!-- 글작성 실제 부분 -->
		<div class="cs_content">
			<div class="cs_content_title">
				<p>
					<img src="/ticketfactory/resources/image/title_private.png" style="padding:0 0 0 2px;">
				</p>
			</div>
			<center><div class="cs_content_bar"></div></center>
	
			<div style="width:750px; padding:15px 23px 0 23px;">


		<!-- 글작성 실제 부분 -->

		

		<table width="100%"  bgcolor="#f9f9f9" cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
			  <td>
				<table width="100%" cellpadding="0" cellspacing="0">
				<form name="myForm" method="post" action="">
					<tr style="border:1px solid #dedede; height:40px;">
						<td style="width:100px; background-color:#f1f1f1; padding-left:10px; color:#5e5e5e;" class="smfont4">문의유형</td>
						<td style="padding:5px 0 5px 10px;">

							<script> 
							function show(ans) { 
							if(ans=="1") { area1.style.display=''; area2.style.display='none';} 
							else { area1.style.display='none'; area2.style.display='';} 
							} 
							</script> 

							<input name="eqType" type="radio" value="환불/취소" style="vertical-align:bottom;" onclick="show(1);">
							<span style="padding-right:20px;">&nbsp;환불/취소 요청</span>
							<input name="eqType" type="radio" value="관람문의" style="vertical-align:bottom;" onclick="show(2);">
							<span style="padding-right:20px;">&nbsp;관람 문의</span>
							<input name="eqType" type="radio" value="기타" style="vertical-align:bottom;" onclick="show(3);">
							기타</span>
						</td>
					</tr>

					<tr id="area1"	style="border:1px solid #dedede; height:40px; display:none;">
						<td style="width:100px; background-color:#f1f1f1; padding-left:10px; color:#5e5e5e;" class="smfont4"></td>
						<td style="padding:5px 0 5px 10px; line-height:200%;">
							<p style=" color:red; font-weight:600;">
							1) 티켓명/관람일시 필수 기재 : 
							<input type='text' name="eqProduct1" class='input_New' maxlength=60 style="width:300px;">
							<input type="hidden" name="eqProduct" value="">

							</p>
							<p style=" color:red; font-weight:600">
							2) 남은 관람일시에 따른 공제금 발생 확인(관람당일 환불불가)
							</p>
							<p style="color:#313131; ">* '구매날짜와 관람일에 따라 환불에 대한 위약공제금이 발생합니다.
								<a href="<%=cp%>/refundList.action" target="_blank">
								<span style="padding-left:10px; text-decoration:underline;">▷환불/취소규정 바로가기</span></a>
							</p>
							<div style="padding-left:15px; line-height:150%; color:#777">
								<p>- 관람일 7일 전 ~ : 티켓 금액 전액 환불</p>
								<p>- 관람일 6일 전 ~ 4일 전까지 : 10% 공제 후 환불</p>
								<p>- 관람일 3일 전 ~ 2일 전까지 : 20% 공제 후 환불</p>
								<p>- 관람일 1일 전 오후 6시까지 : 30% 공제 후 환불</p>
								<p style="color:red;">- 관람일 1일 전 오후 6시 ~ 관람일 당일 : 환불/취소 불가</p>
								<p>* 구매 당일 요청 시 전액 환불(구매일=관람일 일 경우는 불가)</p>
							</div>							
							<p style="color:#0000ff; padding-top:5px;">
							3) 결제수단별 환불방법</p>
							<div style="padding-left:15px; line-height:150%; color:#777">
								<p>- 카드결제 : 카드결제 전액(부분)취소  /  - 휴대폰결제 : 타임티켓으로 공제금 입금 시 전액취소(부분취소불가)</p>
								<p>- 실시간계좌, 무통장입금 : 공제금 제외 계좌이체 환불 (*구매/환불 시점에 따라 환불 방법은 변경될 수 있습니다.)</p>
							</div>							
<!--
							<p style="color:#0000ff; padding-top:5px;">
							※ 무통장입금/실시간계좌이체로 구매하신 경우 환불받으실 '은행명/계좌번호/예금주명'을 함께 남겨주세요!<br>
							공제금 미발생시 전액, 공제금 발생시 공제금을 제외한 금액을 남겨주신 계좌로 환불해드립니다.</p>
-->
						</td>
					</tr>
					
					<tr id="area2" style="border:1px solid #dedede; display:none;">
						<td style="width:100px; background-color:#f1f1f1; padding-left:10px; color:#5e5e5e;" class="smfont4"></td>
						<td style="padding:5px 0 5px 10px;">
						  ┗ 문의 상품명 : <input name="eqProduct2" type='text' class="input_New" maxlength="60" style="width:350px;">
						</td>
					</tr>

					<tr style="border:1px solid #dedede; height:40px;">
						<td style="width:100px; background-color:#f1f1f1; padding-left:10px; color:#5e5e5e;" class="smfont4">휴대폰번호</td>
						<td style="padding:5px 0 5px 10px;">
							<input type='text' name='eqTel' maxlength=20 class="input_New" value='${sessionScope.loginDto.userTel }' style="width:150px;">
							<input type="hidden" name="eqId" value="${sessionScope.loginDto.userId }">
						</td>
					</tr>

					<tr style="border:1px solid #dedede; height:40px;">
						<td style="width:100px; background-color:#f1f1f1; padding-left:10px; color:#5e5e5e;" class="smfont4">제목</td>
						<td style="padding:5px 0 5px 10px;">
						<input name="eqSubject" type='text' class="input_New" 
						maxlength="100" style="width:580px;"></td>
					</tr>
					

				</table>

			  </td>
			</tr>
		</table>

		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
			<tr>
			  <td>
			  <br/>
				<textarea rows="20" cols="105" style="width: 748px; border: 1px solid grey;  padding-left: 7px; padding-top: 5px;" name="eqContent"></textarea>
			  </td>
			</tr>
		</table>

		<div style="text-align:right; padding:20px 0px 5px 15px;">	
			<!-- <input type="image" value='등록' src='/ticketfactory/resources/image/btn_regist.png' 
			width=80; border=0; style="-webkit-border-radius:0; -webkit-appearance:none;"
			onclick="sendIt();"> -->
			<input type="button" value=" 등록하기 " class="btn2" 
			onclick="sendIt();"/>
			<input type="button" value=" 작성취소 " class="btn2" 
			onclick="javascript:location.href='<%=cp%>/eqList.action';"/>
		</div>

		</form>

		</div>
	
	</div>

</div>

	</td>
</tr>
</table>
	
</div>

</body>
</html>