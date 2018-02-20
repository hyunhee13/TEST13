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
<title>관리자1+1티켓등록페이지</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">



</head>
<body>

<div id="adminOneplus_content_main_1">
	<div id="adminOneplus_content_main_2">
		<p><font class="genre">공연 ㅣ </font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(1,'${state}');" id="1">연극</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(2,'${state}');">뮤지컬</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(3,'${state}');">클래식</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(4,'${state}');">국악</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(5,'${state}');">오페라</a></font>
		</p>
		<div style="height: 10px"></div>
		<p><font class="genre">지역 ㅣ </font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(6,'${state}');">서울</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(7,'${state}');">경기</a></font>&nbsp;&nbsp;&nbsp;&nbsp;
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(8,'${state}');">충청</a></font>&nbsp;&nbsp;&nbsp;
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(9,'${state}');">경상</a></font>
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(10,'${state}');">전라</a></font>&nbsp;&nbsp;
			<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">
			<font class="genre_kind"><a href='javascript:void(0);' onclick="kind(11,'${state}');">그외지역</a></font>
		</p>
		
	</div>
	<div id="adminOneplus_bar"></div>
	
	<div id="adminOneplus_content_main_3">
		<div id="adminOneplus_content_session_1">
		
		  <p><!-- <button class="w3-button w3-border w3-hover-light-green oneplusBtn" style="font-family: 맑은 고딕;" onclick="kind(1,'add');"> -->
		  
		  <c:if test="${state=='add' }">
		  <button class="bbbtn" style="font-family: 맑은 고딕;" onclick="kind(1,'add');" value="add" id="add">티켓 추가</button>
		<button class="bbtn" style="font-family: 맑은 고딕;" onclick="kind(1,'remove')" value="remove" id="remove">티켓 제거</button></p>
		</c:if>
		 <c:if test="${state=='remove' }">
		  <button class="bbtn" style="font-family: 맑은 고딕;" onclick="kind(1,'add');" value="add" id="add">티켓 추가</button>
		<button class="bbbtn" style="font-family: 맑은 고딕;" onclick="kind(1,'remove')" value="remove" id="remove">티켓 제거</button></p>
		</c:if>
		
		
	
			<form action="" method="post" name="f">
			<div id="show_content_list1">
			
				<c:set var="doneLoop" value="false" />
				
				<c:if test="${empty show }">
					<c:if test="${empty area }">		
								<p style="font-family: 맑은 고딕; font-size: 10pt; text-align: center; color: red;">조건에 해당하는 '1+1티켓'이 없습니다.</p>
					</c:if>
				</c:if>

				<c:if test="${!empty show }">
				<c:forEach var="dto" items="${show }" varStatus="status">
				
													
				<c:if test="${not doneLoop }">
				<table width="100%" style="font-family: 맑은 고딕;">
					<tr height="90px;">
						<td width="100%">
							<table width="100%" height="100%" style="padding: 5px 0px 5px 0px;"
 							onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
							onMouseOut="this.style.border='0px'; this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
							>
								<tr>
									<td width="5%" style="padding-left: 13px;"><input type="checkbox" name="oneplusCheck" value="${dto.showId }" onclick="popUp('${state}','${genre }');"></td>
									<td width="16%">
									
									<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
									
									
										<img alt="포스터" src="${dto.showPoster }" style="width: 130px; height: 90px;" >
									</td>
									<td class="adminOneplus_content_name" width="37%">[${dto.placeAddr}] ${dto.showName }</td>
									<td width="10%" style="color: #FF007F;"><c:choose>
															<c:when test="${dto.avgStar ==0 }">
															☆☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==1 }">
															☆☆☆☆★
															</c:when>
															<c:when test="${dto.avgStar==2 }">
															☆☆☆★★
															</c:when>
															<c:when test="${dto.avgStar==3 }">
															☆☆★★★
															</c:when>
															<c:when test="${dto.avgStar==4 }">
															☆★★★★
															</c:when>
															<c:when test="${dto.avgStar==5 }">
															★★★★★
															</c:when>
														</c:choose></td>
									<td class="adminOneplus_content_place" width="16%" align="center">${dto.placeName }</td>
									<td class="adminOneplus_content_price" width="16%">
										<c:if test="${!empty dto.seatState }">
												${dto.seatState }
												<c:if test="${dto.priceForCompare !=0}">
													<br/>(최저가 ${dto.priceForCompare })
												</c:if>
																			
										</c:if>
										<c:if test="${empty dto.seatState }">
												${dto.showPrice }
										</c:if>
									</td>
								</tr>
							</table>
							<table width="100%">
								<tr height="1px" style="background-color: #dbdbdb"><td colspan="5"></td></tr>
							</table>
						</td>
					</tr>
				</table>
				
				
				</c:if>
				
				
				</c:forEach>
				</c:if>
				
				<!--     //////////////////////////////////////               -->
				<c:if test="${empty show }">
				<c:forEach var="dto" items="${area }" varStatus="status">
				
				
				<c:if test="${not doneLoop }">
				<table width="100%" style="font-family: 맑은 고딕;">
					<tr height="95px;">
						<td width="100%">
							<table width="100%" height="95px;" style="padding: 5px 0px 5px 0px;"
 							onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
							onMouseOut="this.style.border='0px'; this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
							>
								<tr>
									<td width="5%" style="padding-left: 13px;"><input type="checkbox" name="oneplusCheck" value="${dto.showId }" onclick="popUp('${state}','${genre }');"></td>
									<td width="16%">
									
 									<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
													
										<img alt="포스터" src="${dto.showPoster }" style="width: 130px; height: 90px;" >
									</td>
									<td class="adminOneplus_content_name" width="37%">[${dto.placeAddr}] ${dto.showName }</td>
									<td width="10%" style="color: #FF007F;"><c:choose>
															<c:when test="${dto.avgStar ==0 }">
															☆☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==1 }">
															☆☆☆☆★
															</c:when>
															<c:when test="${dto.avgStar==2 }">
															☆☆☆★★
															</c:when>
															<c:when test="${dto.avgStar==3 }">
															☆☆★★★
															</c:when>
															<c:when test="${dto.avgStar==4 }">
															☆★★★★
															</c:when>
															<c:when test="${dto.avgStar==5 }">
															★★★★★
															</c:when>
														</c:choose></td>
									<td class="adminOneplus_content_place" width="16%" align="center">${dto.placeName }</td>
									<td class="adminOneplus_content_price" width="16%">
										<c:if test="${!empty dto.seatState }">
												${dto.seatState }
												<c:if test="${dto.priceForCompare !=0}">
													<br/>(최저가 ${dto.priceForCompare })
												</c:if>
																			
										</c:if>
										<c:if test="${empty dto.seatState }">
												${dto.showPrice }
										</c:if>	
															
									</td>
								</tr>
							</table>
							<table width="100%">
								<tr height="1px" style="background-color: #dbdbdb"><td colspan="6"></td></tr>
							</table>
						</td>
					</tr>
				</table>
				
				<c:if test="${status.count == 11}">
					<c:set var="doneLoop" value="true" />
				</c:if>
				</c:if>
				
				
				</c:forEach>
				</c:if>
				
				
			</div>
			</form>
			<br/>
			<c:if test="${!empty show }">
			<div class="pageIndex">${pageIndexList }</div>
			</c:if>
			<c:if test="${!empty area }">
			<div class="pageIndex">${pageIndexList }</div>
			</c:if>
			
		</div>
	</div>
</div>

</body>
</html>