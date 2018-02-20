<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[예매]티켓chu~</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/book.css" type="text/css"/>

<script type="text/javascript" src="/ticketfactory/resources/js/func.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/modal.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>



<script type="text/javascript">


//	티켓수량에 대한 값 변화
/* 	function changeSu() {
	
		$('#myPoint').text('${dtoCus.userPoint}');	// 내 포인트 초기화
	
		var showPrice = splitPrice('${dtoShow.showPrice}'); // DB에서 숫자만 불러옴(가격부분)
		
		var su = $("select[name=chanSu]").val(); // selectbox에서 선택한 옵션값
	
		var totalPrice = (showPrice * su);
		
		$('#totalPrice').text(totalPrice);
		$('#hapPrice').text(totalPrice);
		$('#hiddenPrice').val(totalPrice);
	} */
	
	
	
//	'삭제'버튼 눌렀을 경우 ========> 지금은 구매티켓 여러개 있어도 아무거나 '삭제'버튼 한번 누르면 전체 삭제될듯
	function removeDIV(i) {
	
		var testPrice = $('#hapPrice').text().trim(); // 총 결제금액
		
		var subPrice = $('#totalPrice'+i).text().trim(); // DIV삭제할때 차감해야할 금액
		
		var result = testPrice - subPrice; // 총 결제금액에서 차감된 금액
		
		$('#hapPrice').text(result);
		$('#hiddenPrice').val(result);
		
		
		if($('#hapPrice').text() < 0 ) {
			$('#hapPrice').text("0");
		}
		
		var testi = Number($('#i').val());
		testi = testi - 1;
		$('#i').val(testi);
		
		$('#list'+i).remove(); // DIV삭제
	}
	
	
	
	
//	'포인트사용하기'버튼 눌렀을 경우
	function pointBtn() {
		
		var f = document.myBook;
		
		if(!f.usedPoint.value) { // point 미입력 상태에서 버튼을 눌렀을 경우
			alert("사용할 포인트를 입력해주세요");
			f.usedPoint.focus();
			return;
		}
		
		if(!chkNumber(f.usedPoint.value)) { // point 입력란에 숫자가 아닌 다른 문자 입력하였을 경우
			alert("숫자만 입력 가능합니다");
			f.usedPoint.focus();
			return;
		}
		
		if(Number(f.usedPoint.value)%100 != 0) {
			alert("100단위로 입력해주세요");
			return;
		}
		
		if(Number(f.usedPoint.value) > '${dtoCus.userPoint}') { // 입력한 포인트가 적립된 포인트보다 부족한 경우
			
			alert("회원포인트가 부족합니다");
			f.usedPoint.focus();
			return;	
			
		} else if(Number(f.usedPoint.value) > Number($('#hapPrice').text().trim())) { // 입력한 포인트가 총 결제금액보다 많은 경우
			
			alert("총 결제금액보다 적게 입력해주세요");
			f.usedPoint.focus();
			return;
			
		} else { // 입력한 값 만큼 포인트와 결제금액에서 차감
			
			var userPoint = Number('${dtoCus.userPoint}');
			var usedPoint = Number(f.usedPoint.value);
			
			var showPoint = $('#myPoint').text();
			
		//	차감된 후의 포인트값
			var subPoint = showPoint - usedPoint;
			$('#myPoint').text(subPoint);
			
			var totalPrice = $('#hapPrice').text();
			
			var subPrice = totalPrice - usedPoint;
			$('#hapPrice').text(subPrice);
			$('#hiddenPrice').val(subPrice);
			
			var tttt = userPoint - $('#myPoint').text();
			$('#totalUsedPoint').val(tttt);
			
			/* selectBox사용했을때의 코딩(변경필요)
			var subPrice = (splitPrice('${dtoShow.showPrice}') * $("select[name=chanSu]").val()) - Number(f.usedPoint.value);
			$('#totalPrice2').text(subPrice);
			*/
			
			return;
		}
	}
	
	
//	무통장입금에 대한 설명 불러오는 ajax
	function accouInfo(){
	 	$('#pay').attr({style:'height:200px'});
	
		var post = "";
		$.ajax({
			type: "post",
			url: "account.action",
			success:function(page) {
				document.getElementById("accountInfo").innerHTML = page;
			}
		});
	}
	

//	결제하기 버튼 클릭시 뜰 예매내역 화면
	function sendIt() {
		
		var f = document.myBook;
		var str = ""; // 테스트 할 변수
		

//	결제할 DIV가 없는 경우
		if( !Number($('#hiddenPrice').val()) ||  $('#i').val()==0 ) {
			alert("예매할 공연이 없습니다");
			return;
		}
		
		//	포인트 입력 안한경우
		str = f.usedPoint.value;
		if(!str) {
			f.usedPoint.value=0;
			return;
		}
		
		// 회원이름 미 입력시
		str = f.userName.value;
		str = str.trim();
		if(!str) {
			alert("관람자 이름을 입력해주세요");
			f.userName.focus();
			return;
		}
		f.userName.value = str;
		
		// 회원전화번호 미 입력시
		str = f.userTel.value;
		str = str.trim();
		if(!str) {
			alert("휴대폰 번호를 입력해주세요");
			f.userTel.focus();
			return;
		}
		f.userTel.value = str;
		
		// 회원이메일 미 입력시
		str = f.userEmail.value;
		str = str.trim();
		if(!str) {
			alert("E-Mail을 입력해주세요");
			f.userEmail.focus();
			return;
		}
		f.userEmail.value = str;
		
	//	체크박스[유의사항]
		if(!f.check_1.checked) {
			alert("유의사항을 확인 후 동의해주세요");
			f.check_1.focus();
			return false;
		}
	
	//	체크박스[환불/취소]
		if(!f.check_2.checked) {
			alert("환불 및 취소 규정을 확인한 후 동의해주세요!\n(관람일 전날 18시 이후 환불/취소 불가)");
			f.check_2.focus();
			return false;
		}
		
	//	결제수단[radio btn]
		if($("input:radio[name='accou']").is(":checked") == false){
			alert("결제 방법을 선택해주세요");
			return false;
		}
	
		f.action = "<%=cp%>/bookMyPage.action";
		f.submit();
	}
</script>

</head>


<body bgcolor="#EEEEEE">





<!-- --------------------------------------------------------------------------------- -->

<div id="bookTotal">

	<div id="title">
		<p class="title01">주문/결제</p>
		<span class="title02">주문내역을 확인하시고 신중하게 결제하세요</span>
	</div>
	
	<form action="" name="myBook" method="post">
	
<!-- 01 구매티켓 정보 -->
	<div id="num0">01</div>
	<div id="sub">구매티켓 정보</div>
	
	<br/>
	
	<div id="ticketInfo">
		
		<div id="col">
			<p class="info">티켓정보</p>
			<p class="price">티켓가격</p>
			<p class="su">수량</p>
			<p class="totalPrice">주문금액</p>
			<p class="deleted">삭제</p>
		</div> 


		
		<c:set var="i" value="0"></c:set>
		<c:forEach var="dto" items="${lists }">
			
			<div id="list${i }">
				<div id="list">
				<div class="poster">
					<img src="${show.showPoster }" width="70" height="70" >
				</div>
				
				<table id="info"> <!-- 공연이름,공연날짜,시간 띄우는 테이블 -->
				<tr height="10px;">
					<td class="showNameInfo" name="showName">${show.showName }</td>
				</tr>
				<tr>
					<td class="showDayInfo">└&nbsp; ${dto.showDay } / &nbsp;${dto.showTime }</td>
				</tr>
				</table> <!-- info Table...end -->
					<input type="hidden" name="showDay${i }" value="${dto.showDay }">
					<input type="hidden" name="showTime${i }" value="${dto.showTime }">
				
				
				<p class="price" >
					<fmt:parseNumber var="testBookPrice" value="${dto.bookPrice / dto.bookSu  }"/>
						${dto.seat }&nbsp;${testBookPrice }원
						<input type="hidden" name="price${i}" value="${dto.bookPrice}">
						<input type="hidden" name="seat_grade${i }" value="${dto.seat }">
						<input type="hidden" name="seat_num${i }" value="${dto.seat_num }">
				</p>
				
				<p class="su">&nbsp;
					<%-- <select name="chanSu" onchange="changeSu()">
					
						<!-- 잔여티켓수량이 20장 이상인 경우 -->
						 <c:if test="${dtoTime.seat>=20 }">
							<c:forEach var="su" begin="1" end="20" step="1">
								<c:if test="${dto.bookSu != su }">
									<option value="${su }">${su }
								</c:if>
								<c:if test="${bookSu == su }">
									<option value="${dto.bookSu }" selected="selected">${dto.bookSu }
								</c:if>
							</c:forEach>
						</c:if>
						
						<!-- 잔여티켓수량이 20장 미만인 경우 -->
						<c:if test="${dtoTime.seat<20 }">
							<c:forEach var="su" begin="1" end="${dtoTime.seat }" step="1">
								<c:if test="${dto.bookSu != su }">
									<option value="${su }">${su }
								</c:if>
								<c:if test="${dto.bookSu == su }">
									<option value="${dto.bookSu }" selected="selected">${bookSu }
								</c:if>
							</c:forEach>
						</c:if> 
						
					</select> --%>
					
					${dto.bookSu }매 
					<input type="hidden" name="bookSu${i}" value="${dto.bookSu}">	
				</p>
				
				<p class="totalPrice" id="totalPrice${i }" >
					${dto.bookPrice }
				</p>
				
				<p class="deleted">&nbsp;<input type="button" name="delDIV" value="X" class="removeDIVBtn" onclick="removeDIV(${i});"> </p>
					
				</div>	
			</div> 
		<c:set var="i" value="${i+1}"></c:set>
		</c:forEach>
			

	</div> <!-- ticketInfo...end -->
	
	
	<div id="pointInfo">
		
		<img src="/ticketfactory/resources/image/img01.GIF" width="17px;" height="17px;" style="vertical-align: middle;"><p>포인트사용</p>
		<div class="textBox">
			<input type="text" name="usedPoint" style="BORDER-TOP: #e2e2e2 1px solid; HEIGHT: 19px; BORDER-RIGHT: #e2e2e2 1px solid;
									WIDTH: 100px; BORDER-BOTTOM: #e2e2e2 1px solid; PADDING-LEFT: 3px; BORDER-LEFT: #e2e2e2 1px solid; LINE-HEIGHT: 18px" />
			<input type="button" value="포인트사용하기" class="pointButton" onclick="pointBtn();"/>
			
		</div>
		<img src="/ticketfactory/resources/image/point.GIF" style="vertical-align: middle; padding-left: 8px;" width="20px;" height="20px;"/>
		<p2>내 포인트: <span id="myPoint" style="font-weight: bold;" name="myPoint">${dtoCus.userPoint }</span> p</p2>
	</div>
	<p style="padding-left: 20px; color: #FF4848; font-family: 맑은 고딕; font-size: 11px; margin-top: 0px;">* 100단위로 입력해주세요</p>
	
	<div id="price">
		<p class="text">총 주문금액 : </p>
		<p class="totalPrice" id="hapPrice" align="right" name="bookPrice">${total_priceWon }</p>	
		<p class="own">원</p>
		<input type="hidden" id="hiddenPrice" name="totalPrice" value="${total_priceWon }"> <!-- 총 결제금액(포인트차감 안한값) -->
	</div>
	
	<br/><br/>
	
	
	
<!-- 02 관람자 정보 -->
	<div id="num0">02</div>
	<div id="sub">관람자 정보</div>
	
	<div id="showInfo">
	
	<table>
	
	<tr>
		<td class="name"><img src="/ticketfactory/resources/image/img01.GIF" width="17px;" height="17px;" style="vertical-align: middle;"/>이름</td>
		<td class="nameInfo">
		<input type="text" name="userName" value="${dtoCus.userName }" style="WIDTH: 110px; height: 20px; PADDING-LEFT: 3px; margin-left: 6px; font-size: 11px; color: #353535;
		BORDER-TOP: #707070 1px solid; BORDER-RIGHT: #707070 1px solid; BORDER-BOTTOM: #707070 1px solid;  BORDER-LEFT: #707070 1px solid;"/>
		<SPAN style="FONT-SIZE: 11px; FONT-FAMILY: dotum; COLOR: #313131; word-spacing: 0.1em;">&nbsp;&nbsp;* 실제 티켓을 수령하실 분의 성함을 입력해주세요.</SPAN>
		</td>
	</tr>
	
	<tr>
		<td class="tel"><img src="/ticketfactory/resources/image/img01.GIF" width="17px;" height="17px;" style="vertical-align: middle;"/>휴대폰 번호</td>
		<td class="telInfo">
		<input type="text" name="userTel" value="${dtoCus.userTel }" style="WIDTH: 150px; height: 20px; PADDING-LEFT: 3px; margin: 0px 0px 6px 6px; font-size: 11px; color: #353535;
		BORDER-TOP: #707070 1px solid; BORDER-RIGHT: #707070 1px solid; BORDER-BOTTOM: #707070 1px solid;  BORDER-LEFT: #707070 1px solid;"/>
		<br/>
		<SPAN style="FONT-SIZE: 11px; FONT-FAMILY: dotum; COLOR: #313131">* 입력하신 휴대폰번호로 예매내역 문자를 수신할 수 있습니다.
		<br/>
		<SPAN style="FONT-SIZE: 11px; FONT-FAMILY: dotum; COLOR: #FF0000">* 번호를 잘못 입력하실 경우 예매내역 수신은 물론 취소/변경 관련 긴급연락이 불가</SPAN>하니 신중히 입력해주세요!</SPAN>
		</td>
	</tr>
	
	<tr>
		<td class="name"><img src="/ticketfactory/resources/image/img01.GIF" width="17px;" height="17px;" style="vertical-align: middle;"/>이메일 주소</td>
		<td class="nameInfo">
		<input type="text" name="userEmail" value="${dtoCus.userEmail }" style="WIDTH: 150px; height: 20px; PADDING-LEFT: 3px; margin-left: 6px; font-size: 11px; color: #353535;
		BORDER-TOP: #707070 1px solid; BORDER-RIGHT: #707070 1px solid; BORDER-BOTTOM: #707070 1px solid;  BORDER-LEFT: #707070 1px solid;"/>
		</td>
	</tr>

	</table>
		
	</div> <!-- showInfo...end -->


	<br/><br/>
	
<!-- 03 유의 사항 -->
	<div id="num0">03</div>
	<div id="sub">유의 사항</div>
	
	<div id="noticeInfo">
		<STRONG>* 구매 후 환불/취소 관련 주의사항</STRONG><BR>
		<DIV>- 티켓 이용 당일은 환불 및 취소, 변경이 불가합니다.</DIV>
		<DIV>- 당일이 아닐 경우 규정에 따라 공제금이 발생할 수 있습니다.</DIV>
		<DIV style="COLOR: red">- 예매 후 관람 당일에 다른 시간으로 재예매를 하더라도 기존 티켓은 환불이 불가합니다.</DIV>
		<DIV>&nbsp;</DIV>
		<DIV><STRONG>1. 티켓 사용조건</STRONG><BR>고객은 사이트에 명시된 내용 및 “구매 전 유의사항”을 확인해야 할 책임이 있으며, 기재된 조건에 따라서만 티켓을 사용하실 수 있습니다.</DIV>
		<DIV>&nbsp;</DIV>
		<DIV><STRONG>2. 제휴 업체간 회원의 구매정보 제공</STRONG><BR>티켓 사용체크 및 본인 사용 확인을 위해 타임티켓(www.timeticket.co.kr)과 제휴 업체간 회원의 구매정보를 제공하고 있습니다.&nbsp;</DIV>
		<DIV>- 제공 업체 : 구매자가 구매한 티켓/상품의 서비스 제공 업체</DIV>
		<DIV>- 제공 목적 : 티켓 본인 사용체크 및 본인확인, 예약 서비스 제공 시 본인확인</DIV>
		<DIV>- 제공 항목 : 티켓의 경우 이름, 전화번호, 구매번호, 구매갯수, QR코드 및 코드번호 등 서비스 이행을 위한 필수적인 항목</DIV>
		<DIV>&nbsp;</DIV>
		<DIV><STRONG>3. 구매 후 환불 규정&nbsp;</STRONG></DIV>
		<DIV>- 공연/전시 상품의 특성상 이용 당일의 티켓은 환불 및 취소가 불가합니다.</DIV>
		<DIV>- 환불은 각 상품 상세페이지에 명시되어 있는 '환불규정 및 안내사항'을 따릅니다.<BR>- 사용 기간이 경과한 티켓은 잔여금액에 대한 환불이 불가능합니다.<BR>- 기타 약관 및 “사이트”의 이용안내에 규정되지 않은 취소 및 환불에 대한 사항에 대해서는 소비자 피해보상 규정에서 정한 바에 따릅니다.&nbsp;</DIV>
		<DIV>&nbsp;</DIV>
		<DIV><STRONG>4. 티켓의 유효기간</STRONG><BR>-&nbsp;공연/전시 상품의 특성상 고객의 사정으로 인하여 사이트 등에 명시된 유효기간이 경과된 티켓은 사용할 수 없습니다.&nbsp;</DIV>
		<DIV>- 지정된 이용 시간을 준수하지 못해 사용하지 못한 티켓에 대해서는 환불 및 취소가 불가합니다.<BR>&nbsp;</DIV>
		<DIV><STRONG>5. 티켓 서비스/상품 이용에 대한 책임</STRONG></DIV>
		<DIV>티켓 발행 이후, 서비스/상품과 관련된 책임은 실질적인 서비스/상품을 제공하는 제휴업체가 부담합니다. 또한 서비스 및 상품의 품질 및 이행에 대하여 전자상거래 등에서의 소비자보호에 관한 법률에 근거해 ㈜타임티켓은 고객에게 최선을 다하겠습니다.</DIV>
		
	</div> <!-- noticeInfo...end -->
	
	<div class="check">
		<input type="checkbox" name="check_1" id="check_1" style="width: 13px; height: 13px; vertical-align: middle;">
		<LABEL style="CURSOR: pointer; FONT-SIZE: 13px" for=check_1> 위 유의사항을 확인하였으며 이에 동의합니다.</LABEL>
	</div>
	
	<div class="check">
		<input type="checkbox" name="check_2" id="check_2" style="width: 13px; height: 13px; vertical-align: middle;">
		<LABEL style="CURSOR: pointer; FONT-SIZE: 13px" for=check_2> 환불 및 취소는 관람일 전날 18시 까지</SPAN> 신청 가능하며, 
		<SPAN style="TEXT-DECORATION: underline; FONT-WEIGHT: bold; COLOR: red">관람일 당일은 환불/취소/변경이 절대 불가</SPAN>한 점에 동의합니다.</LABEL>
	</div>
	
	
	<br/><br/>
	
	
<!-- 04 결제 수단 -->
	<div id="num0">04</div>
	<div id="sub">결제 수단</div>
	
	<div id="pay">
		
		<div id="payInfo1"><input type="radio" name="accou" value="신용(체크)카드"/>신용(체크)카드</div>
		<div id="payInfo"><input type="radio" name="accou" value="휴대폰결제"/>휴대폰결제</div>
		<div id="payInfo"><input type="radio" name="accou" value="실시간계좌이체"/>실시간계좌이체</div>
		<div id="payInfo"><input type="radio" name="accou" value="무통장입금" onchange="accouInfo();" />무통장입금(가상계좌)</div>
		
		<br/><br/><br/><br/>
		<div id="accountInfo" ></div>
		
		
	</div> <!-- pay...end -->
	

	<br/><br/>
	
	<div class="payButton1">
		<input type="hidden" name="i" value="${i }" id="i">
		<input type="hidden" name="totalUsedPoint" id="totalUsedPoint" value="0">
		
		<input type="button" class="payButton2" value="결제하기" onclick="sendIt();"/>
	</div>
	<br/><br/>
	
	
	</form>
	
</div>



</body>
</html>













