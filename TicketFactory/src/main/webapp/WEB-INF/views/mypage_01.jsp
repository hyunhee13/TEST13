<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function bookCancel() {
	 
	 f = document.myForm;
	 
	 f.action = "<%=cp%>/bookCancel.action";
	 f.submit();
}
</script>
</head>
<body>
<form action="" name="myForm">
<!-- 구매내역 상단제목 -->
<img src="/ticketfactory/resources/image/title_my_buy.png" style="padding:0 0 0 2px; margin-left: 18px;" alt="구매내역">	
<div style="float:right; padding-right:18px; padding-top: 3px;
	line-height:25px; font-size: 10pt; ">
	<a href="" style="color: #666; font-weight: lighter;">▶카드/현금 영수증 확인(Click!)</a>
</div>
<div class="mypage_main_bar"></div>
<!-- 구매내역 하단  -->	
<div style="width:100%; padding:0 23px 0 23px; line-height: normal;">

<table cellpadding="0" cellspacing="0" width="750" bgcolor="#FFFFFF" >
	<tbody>
		<tr>
			<td>
				<table cellspacing="0" style="width:100%; margin: 0;">
				<tbody>
					<tr>
						<td >
							<table cellspacing="0" style="width:100%;">
								<tbody>
									<tr>
										<td style="width:3px;">
											<img src="/ticketfactory/resources/image/icon_table_left.gif">
										</td>
										<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
											<table cellspacing="0" style="width:100%;">
												<tbody>
													<tr>
														<td class="myTable" align="center">구매날짜</td>
														<td class="myTable" align="center">티켓정보</td>
														<td class="myTable" align="center" style="width:80px;">수량</td>
														<td class="myTable" align="center" style="width:90px;">상태</td>
														<td class="myTable" align="center" style="width:75px;">기타</td>
													</tr>
												</tbody>
											</table>
										</td>
										<td style="width:3px;">
											<img src="/ticketfactory/resources/image/icon_table_right.gif">
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>

<table cellpadding="0" cellspacing="0" width="750" bgcolor="#FFFFFF">



					

					<c:forEach var="second_List" items="${all_list }" begin="${start-1}" end="${end-1 }" step="1">
						<c:set var="totalBookSu" value="0"></c:set>
						<c:set var="totalPrice" value="0"/>
						<c:set var="stop" value="0" />
						<tr style="border: 1px solid #dedede;">
							<td align="center" style="width: 230px;">
								<c:forEach var="bookList" items="${second_List }" begin="0" end="0" step="1">
								<p>${bookList.bookDate }</p>
								</c:forEach>
							</td>
							<td align="center" style="width: 250px;">
								<table cellpadding="0" cellspacing="0">
								
									
									<c:if test="${stop==0 }">
										<c:forEach var="bookList" items="${second_List }">
											<tr>
												<td style="width: 70px;">≫티켓명</td>
												<td><a href="<%=cp%>/layout.action?showId=${bookList.showId }">${bookList.showId }</a></td>
											</tr>
											<tr>
												<td>≫관람자</td>
											<td>${loginDto.userName }(${loginDto.userTel })</td>
											</tr>		
											<tr>
												<td class="left">≫관람일시</td>
												<td>${bookList.showDay }${bookList.showTime }</td>
											</tr>
											<tr>
												<td class="left">≫티켓가격</td>
												<td>${bookList.bookPrice }원/ ${bookList.bookSu }장</td>
												<!-- 총 가격/ 티켓 장 수 -->
											</tr>
											<tr style="background-color: orange;">
												<td class="left">≫예매번호</td>
												<td id="bookNum">${bookList.bookNum }&nbsp;&nbsp;
													${bookList.seat }</td>
											</tr>

												<c:set var="totalBookSu" value="${totalBookSu+bookList.bookSu }"></c:set>
												<c:set var="price" value="${bookList.bookSu*bookList.bookPrice }"/>
												<c:set var="totalPrice" value="${totalPrice+price}"/>
												<c:set var = "usedPoint" value="${bookList.usedPoint }">
												</c:set>
												<c:set var="bookState" value="${bookList.bookState }"></c:set>
												<c:set var="bookCancelNum" value="${fn:substring(bookList.bookNum,0,15)}"></c:set>
										</c:forEach>
									</c:if>
									<c:set var="stop" value="${stop+1}" />
									<tr>
										<td class="left">≫결제방법</td>
										<td>${payment }<br />입금계좌 : 010203-04-050607
										</td>
									</tr>
								

								</table>
							</td>
							
							<td style="padding-left: 20px;">
							총 ${totalBookSu }장
							</td>
							
							<td style="padding-left: 30px;">
							${bookState }
							</td>
							<td align="center"><p class="etc">
							
							<input type="button" class="btn2222" value="결제 취소" onclick="bookCancel();"/>
			
							<input type="hidden" name="bookCancelNum" value="${bookCancelNum }">
							<input type="hidden" name="pageNum" value="${pageNum }">
							<input type="hidden" name="mypageNum" value="01">
							</p>
							</td>
						</tr>
					</c:forEach>


			<tr>
				<td style="padding: 30px 0 20px 0;" align="center" colspan="5">
					<div id="page">
						<p>
							<c:if test="${totalDataCount!=0 }">
								${pageIndexList }
							</c:if>
							<c:if test="${totalDataCount==0 }">
								등록된 게시물이 없습니다.
							</c:if>
					
						</p>
					</div>
				</td>
			</tr>

		</table>
</div>

</form>

</body>
</html>
