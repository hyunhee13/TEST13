<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%-- 	<div id="col" style="background-color: #FFFFF0;">
		<p class="showName">공연명</p>
		<p class="showPlace">공연장소</p>
		<p class="ticketPrice">티켓가격</p>
		<p class="runningTime">러닝타임</p>
		<p class="showGenre">장르</p>
		<p class="showTo">공연시작일</p>
		<p class="showFrom">공연종료일</p>
		<p class="accrue">누적</p>
	</div>

	<c:forEach var="showList" items="${showList }">
	<div id="listInfo">
	
		<p class="showName">&nbsp;${showList.showName }</p>
		<p class="showPlace">&nbsp;${showList.showPlace }</p>
		<p class="ticketPrice">
			<c:if test="${!empty showList.seatState }">
					&nbsp;${showList.seatState }
				</c:if>
				<c:if test="${empty showList.seatState }">
					&nbsp;${showList.showPrice }
				</c:if>
		</p>
		<p class="runningTime">&nbsp;${showList.showRuntime }</p>
		<p class="showGenre">&nbsp;${showList.showGenre }</p>
		<p class="showTo">&nbsp;${showList.showTo }</p>
		<p class="showFrom">&nbsp;${showList.showFrom }</p>
		<p class="accrue">&nbsp;누적값</p>
		<br/>
	</div>
	</c:forEach> --%>
	
	<div>
		
		<div style="width:100%; padding:15px 23px 0 23px;">

			<table cellspacing="0" style="width:933px;">
				<tr>
					<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_left.gif"></td>
					<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
						<table cellspacing="0" style="width:100%;">
						<tr>
							<td style="width:230px;" align="center">공연명</td>
							<td align="center" width="235px;">공연장소</td>
							<td align="center" style="width:90px;">티켓가격&nbsp;</td>
							<td align="center" style="width:110px;">러닝타임</td>
							<td align="center" style="width:63px;">장르</td>
							<td align="center" style="width:70px;">&nbsp;공연시작일</td>
							<td align="center" style="width:70px;">&nbsp;공연종료일</td>
							<td align="center" style="width:45px;">누적</td>
						</tr>
						</table>
					</td>
					<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_right.gif"></td>
				</tr>
			</table>

			<!-- 게시판 -->
			<table cellpadding="0" cellspacing="0" width="933px;" bgcolor="#FFFFFF">
				<tr>
					<td>
						<table width=100% cellpadding="0" cellspacing="0"  border=0>
							<tr>
								<td valign=top align=center>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
										<c:forEach var="showList" items="${showList}">
										
										<tr height="40" onmouseup="this.style.backgroundColor='#f7f7f7'"; 
										onmouseover="this.style.backgroundColor=''";>
										
											<td style="width: 350px;" align="center">&nbsp;${showList.showName }</td>
									 
									 		<td style="width: 320px;" align="center">&nbsp;${showList.showPlace }</td>
											
											<td width="120px;" align="center">
												<c:if test="${!empty showList.seatState }">${showList.seatState }
												</c:if>
												<c:if test="${empty showList.seatState }">${showList.showPrice }
												</c:if>
											</td>
											 
											<td width="150" align="center">&nbsp;${showList.showRuntime }</td>
											  
											<td width="98px;" align="center">
											&nbsp;${showList.showGenre }
											</td>
											  
											<td width="70" align="center">							
											&nbsp;${showList.showTo }
											</td>
											  
											<td width="70" align="center">
											&nbsp;${showList.showFrom }
											</td>
											  
											<td width="70" align="center">
											누적값
											</td>
												
										</tr>
											</c:forEach>
										<tr>
											<td style="height:1px;border-bottom:1px dotted #dbdbdb;"colspan="13"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table> 
					</td>
				</tr>
			</table>
			
			<!-- <div style="width:100%; padding-top:10px; padding-bottom:30px; text-align:center;">
	
			</div>  -->

		</div>
	
	</div>
	
	
	<div id="paging">
		<c:if test="${dataCount!=0 }">
			${pageIndexList }
		</c:if>
		<c:if test="${dataCount==0 }">
			티켓 예매된 적이 없어요~
		</c:if>
	</div>
	
	
	
