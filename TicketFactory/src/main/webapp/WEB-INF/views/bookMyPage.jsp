<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이티켓</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/myBook.css" type="text/css"/>

<script type="text/javascript" src="/ticketfactory/resources/js/modal.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>

<script type="text/javascript">

	var divCount = Number('${divCount}');
	
	var heightV = (divCount * 20) + 250;
	/* 
	
	if(divCount != 1) {
		
		$('.ticketInfo').attr({style:'height:' + heightV + 'px'});
	} 
	
	 */
	 
	var f = document.myForm;

	function payConfirm() {
		
		alert("무통장입금 결제 되었습니다");
		
		f.action = "<%=cp%>/myPage.action?bookNum=${dtoBook.bookNum}";
		f.submit();
	}
	
	
//	예매취소
	function bookCancel() {
		 
		 f = document.myForm;
		 
		 f.action = "<%=cp%>/bookCancel.action";
		 f.submit();
	 }
	 
//	새로고침 금지
	function noEvent() {

		if (event.keyCode == 116) {

		alert('새로고침금지!!');

		event.keyCode= 2;

		return false;

		}
	}
	
	document.onkeydown = noEvent;
	/* 
	function checkHeight(){
		alert('${bookSize}');
		
 		var objSet   = document.getElementById(objSet); 
		var objTarHeight= document.getElementById(objTar).offsetHeight;
		
		if(objSet.offsetHeight<objTarHeight){
			  objSet.style.height  = objTarHeight + "px";
		}
	}
	  */

</script>
</head>



<body bgcolor="#eeeeee" onload="checkHeight()">


<div id="myTicket"> <!-- 전체 border(바탕색이 하얀부분) -->

	<br/><br/><p class="title">구매내역</p>
	<div class="line01"></div>
	<p class="title01" >주문완료</p>
	<div class="line02"></div>
	
	<form action="" name="myForm" method="post">
	
	<div id="success">
	
		<p class="title01" align="center">티켓주문이 정상적으로 완료되었습니다</p>
		
		<div class="info01">
			-  구매 시 입력한 휴대폰 번호로 <span style="font-weight: bold;">SMS티켓이 자동 발송</span>됩니다.<br/>
			-  구매내역 확인 및 SMS티켓 재발송은 마이티켓에서 가능합니다.<br/>
			※ <span style="color: red;">무통장입금</span>을 선택하신 경우 아래 지정된 계좌로 <span style="color: red;">신청 후 3시간 이내에 입금</span>되어야 구매가 완료됩니다.<br/>
						<span style="padding-left: 13px; line-height: 70%;">(3시간 후 자동 취소)</span>
			
		</div>
	
	</div> <!-- success DIV...end -->
	
	<div id="successInfo">
	
		<div class="col">
			<p class="day">구매날짜</p>
			<p class="description">구매내역</p>
			<p class="su">수량</p>
			<p class="state">상태</p>
		</div>
		
		
		
		<div class="ticketInfo" >
		
			<p class="day">${dtoBook.bookDate }</p>
			
			<table>
			<tr><td></td></tr>
			<tr>
				<td class="left">≫티켓명</td>
				<td>${showName }</td>
			</tr>
			<tr>
				<td class="left">≫관람자</td>
				<td>${dtoCus.userName } (${dtoCus.userTel })</td>
			</tr>
			<tr style="border-bottom: 1px solid #353535;"><td></td></tr>
			
			
			
			
			<c:set var="totalBookSu" value="0"></c:set>
			<c:forEach var="bookList" items="${bookList }">
			<tr>
				<td class="left">≫관람일시</td>
				<td>${bookList.showDay }&nbsp; ${bookList.showTime }</td>
			</tr>
 			<tr>
				<td class="left">≫티켓가격</td><fmt:parseNumber var="perPrice" value="${bookList.bookPrice/bookList.bookSu }"/> 
				<td>[${bookList.seat }]&nbsp;${bookList.bookPrice }원 / ${bookList.bookSu }장&nbsp;
				<c:if test="${bookList.bookSu!=1 }">
				(1장 : ${perPrice}원)
				</c:if>
				</td> <!-- 총 가격/ 티켓 장 수 -->
			</tr>
			<tr>
				<td class="left" >≫예매번호</td>
				<td id="bookNum">${bookList.bookNum }</td>
			</tr>
			<tr style="border-bottom: 1px solid #353535;"><td></td></tr>
			<c:set var="totalBookSu" value="${totalBookSu + bookList.bookSu}"></c:set>
			</c:forEach>
			
			
			
			
			<tr>
				<td class="left">≫결제방법</td>
				<td>${payment }<br/>
				<c:if test="${payment=='무통장입금' }">입금계좌 : 010203-04-050607</c:if>
				</td>
			</tr>
			
			
			<tr><td></td></tr>
			<tr>
				<td class="left">≫결제금액</td>
				<td>${totalPrice }원 <!-- 총 결제 금액 -->
					<c:if test="${dtoBook.usedPoint != 0}">
						(point : ${dtoBook.usedPoint })
					</c:if>
				</td>
			</tr>
			<tr><td></td></tr>
			</table>
			
			
			<p class="su">${totalBookSu }장</p>
			<p class="state">
				<c:if test="${payment=='무통장입금' }">미입금</c:if>
				<c:if test="${payment!='무통장입금' }">결제완료</c:if>
			</p>
			
		</div> <!-- ticketInfo DIV...end -->
		
	
	
	</div> <!-- successInfo DIV...end -->

	
	<div id="btn" >
	
		<input class="btn1" type="button" value="메인" onclick="javascript:location.href='<%=cp%>/main.action';"/>
		<input class="btn2" type="button" value="구매 내역" onclick="javascript:location.href='<%=cp%>/mypage.action?pageNum=01';"/>
		<c:if test="${payment=='무통장입금' }">
			<input type="button" value="무통장입금결제" onclick="payConfirm();" class="btn3">
		</c:if>
			<input type="button" class="btn2" value="결제 취소" onclick="bookCancel();"/>
			
			<input type="hidden" name="bookCancelNum" value="${bookCancelNum }">
	</div>
	
	
<br/><br/><br/>

</form>
	
</div> <!-- myTicket DIV...end -->



</body>
</html>