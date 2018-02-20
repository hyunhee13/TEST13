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
</head>
<link rel="stylesheet" href="<c:url value="/resources/css/detail2.css"/>" type="text/css"/>


<body>

<img alt="" src="<%=cp %>/resources/image/w_nowonsale.png" width="925"><br/><br/>
<img alt="" src="<%=cp %>/resources/image/1plus1_w.png" width="925"><br/><br/>



<h2><font color="#313131" style="font-family: tahoma;">구매 전 꼭 확인하세요!</font></h2>
<hr><br/>

<p class="notice">
<font class="pink">예매정보</font><br/>
공연기간: ${show.showFrom } ~ ${show.showTo }<br/>
예매가능시간: 공연10분 전까지<br/>
<br/>
</p>

<p class="notice">
<font class="pink">1+1티켓 이용안내</font><br/>
1+1티켓은 한 장으로 두 명 이용이 가능한 티켓입니다(2인권)<br/>
1+1티켓은 전체 회차가 아닌 일부 회차에만 적용될 수도 있습니다<br/>
"시간" 선택시 [1+1티켓]이 명시된 권종을 구매해주세요! ex)오후0시[1+1티켓]<br/>
공연에 1+1티켓 "마크"가 보이더라도 구매시 [1+1티켓]을 선택하지 않은 경우 1인만 이용 가능합니다<br/>
<br/>
</p>

<p class="notice">
<font class="pink">관람정보</font><br/>
관람등급: ${show.showLimit }(신분증 등 증빙자료 지참)<br/>
공연시간: 약 ${show.showRuntime }<br/>
티켓배부: 현장수령(공연 60분 전부터 공연장 앞 매표소 배부)<br/>
티켓교환: 문자/마이티켓 제시 및 본인확인 후 발권<br/>
입장시간: 공연시작 20분 전 부터 입장 가능<br/>
좌석배정: 현정 매표소 수령 순서대로 좌석 배정(앞/뒤, 중앙/사이드)<br/>
<br/>
</p>

<p class="notice">
<font class="pink">주의사항</font><br/>
<font color="red">
※티켓팩토리는 비지정석 예매입니다. 상단 좌석배정 방식을 확인하세요!<br/>
※당일 관람티켓 취소/환불/변경 불가 - 신중히 구매해주세요<br/>
※부득이한 사정으로 관람할 수 없을 경우 티켓양도/판매 게시판을 이용해주세요!<br/>
</font>
공연 시작 후 입장 불가, 공연 중 퇴장 시 재입장 불가<br/>
지각으로 관람하지 못할 시 취소/환불/변경 불가<br/>
관람 연령 미숙지로 인한 취소/환불/변경 불가<br/>
음식물 반입 금지, 공연 중 사진/동영상 촬영 금지<br/>
공연 취소/변경 발생시, 개별 연락을 드릴 수 있습니다.<br/>
<br/>
</p>


<font class="pink">환불규정 및 안내사항</font><br/>
<table width="100%" border="0px;" cellpadding="0" cellspacing="0">
<tr height="100%" align="center" valign="middle" style="border: solid 0px;">
	<td width="50%" height="70" align="left" 
	style="padding-left: 10px; border: solid 1px #CFCFCF;
	border-right: 0px; border-bottom: 0px; border-top: 0px;">
	<font class="refund">
		<font color="red">
		※ 구매 시점과 무관하게 관람 당일은 환불/취소/변경 불가<br/>
		</font>
		▷ 오늘티켓 : 취소 및 환불, 날짜/시간 변경 불가<br/>
		▷ 내일티켓 : 구매일 오후6시 이전 요청 시 전액 환불, 이후 불가<br/>
		<font color="red">
		※ 날짜/시간/티켓 변경은 불가하며, 환불 후 재구매해야 합니다.<br/>
		※ 환불처리는 오후6시까지 공제금이 입금되어야 가능합니다.<br/>
		※ 취소/환불은 마이페이지 > 주문취소를 통해서 신청해주세요.<br/>
		</font>
	</font>
	</td>
	<td width="50%" height="70" align="left" 
	style="padding-left: 10px; border: solid 1px #CFCFCF;
	border-right: 0px; border-bottom: 0px; border-top: 0px;">
	<font class="refund">
		▷ 예매티켓 : 구매일/관람일에 따라 아래와 같이 차등 환불<br/>
		&nbsp;1) 구매 당일 요청 시 전액 환불<font color="red">(관람일 당일티켓은 환불 불가)</font><br/>
		&nbsp;2) 관람일 7일 전~ : 티켓 금액 전액 환불<br/>
		&nbsp;3) 관람일 6일 전 ~ 4일 전까지 : 10% 공제 후 환불<br/>
		&nbsp;4) 관람일 3일 전 ~ 2일 전까지 : 20% 공제 후 환불<br/>
		&nbsp;5) 관람일 1일 전 오후 6시까지 : 30% 공제 후 환불<br/>
		<font color="red">
		&nbsp;6) 관람일 1일 전 오후 6시 ~ 관람일 당일 : 환불/취소 불가</font><br/>
	</font>
	</td>
</tr>
</table>
<br/>

</body>
</html>