<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%-- 
	<div id="col" style="background-color: #E9FFE0;">
		<p class="userGrade">계급</p>
		<p class="userId">회원아이디</p>
		<p class="userName">회원이름</p>
		<p class="addr">회원주소 + 상세주소</p>
		<p class="gender">성별</p>
		<p class="userTel">전화번호</p>
		<p class="userEmailGrade">이메일</p>
		<p class="userPointGrade">회원포인트</p>
		<p class="accruePrice">누적금액</p>
	</div>



	<c:forEach var="cusList" items="${cusList }">
	<div id="listInfo">
	
		<p class="userGrade">
			<c:forEach var="bookList" items="${bookList }">
				<c:if test="${cusList.userId==bookList.userId }">
					<c:if test="${bookList.bookPrice>=200000 }">
						&nbsp;VIP
					</c:if>
					<c:if test="${bookList.bookPrice>=50000 && bookList.bookPrice<200000 }">
						&nbsp;Gold
					</c:if>
					<c:if test="${bookList.bookPrice<50000 }">
						&nbsp;Silver
					</c:if>
				</c:if>
			</c:forEach>
		</p>
		<p class="userId">&nbsp;${cusList.userId }</p>
		<p class="userName">&nbsp;${cusList.userName }</p>
		<p class="addr">&nbsp;${cusList.userAddr } ${cusList.userAddr_detail }</p>
		<p class="gender">&nbsp;${cusList.userGender }</p>
		<p class="userTel">&nbsp;${cusList.userTel }</p>
		<p class="userEmailGrade">&nbsp;${cusList.userEmail }</p>
		<p class="userPointGrade">&nbsp;${cusList.userPoint }</p>
		
		<p class="accruePrice">
			<c:forEach var="bookList" items="${bookList }">
				<c:if test="${cusList.userId==bookList.userId }">
					&nbsp;${bookList.bookPrice }원
				</c:if>
			</c:forEach>
		</p>
	</div>
	</c:forEach> --%>
	
	
<div>
	<div style="width:100%; padding:15px 23px 0 23px;">
		<table style="width:933px;">
			<tr>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_left.gif"></td>
				<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
					
					<table style="width:100%;">
					
						<tr>
							<td style="width:42px;" align="center">계급</td>
							<td align="center" width="65px;">회원아이디</td>
							<td align="center" style="width:55px;">회원이름</td>
							<td align="center" style="width:250px;">회원주소 + 상세주소</td>
							<td align="center" style="width:37px;">성별</td>
							<td align="center" style="width:60px;">전화번호</td>
							<td align="center" style="width:110px;">이메일</td>
							<td align="center" style="width:55px;">회원포인트</td>
							<td align="center" style="width:55px;">누적금액</td>
						</tr>
					</table>
				</td>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_right.gif"></td>
			</tr>
		</table>

		<!-- 게시판 -->
		<table style="width: 933px;">
			<tr>
				<td>
					<table style="width: 933px; background-color: #ffffff;">
						<c:forEach var="cusList" items="${cusList}">
						
						<tr height="40" onmouseup="this.style.backgroundColor='#f7f7f7';" 
						onmouseover="this.style.backgroundColor='';" style="width: 993px;">
						
							<td style="width: 70px;" align="center">
								<c:forEach var="bookList" items="${bookList }">
									<c:if test="${cusList.userId==bookList.userId }">
										<c:if test="${bookList.bookPrice>=200000 }">
											&nbsp;VIP
										</c:if>
										<c:if test="${bookList.bookPrice>=50000 && bookList.bookPrice<200000 }">
											&nbsp;Gold
										</c:if>
										<c:if test="${bookList.bookPrice<50000 }">
											&nbsp;Silver
										</c:if>
									</c:if>
								</c:forEach>	
							</td>
					 
					 		<td style="width: 110px;" align="center">${cusList.userId }</td>
							
							<td width="110px;" align="center">
							${cusList.userName }
							</td>
							 
							<td width="650px;" align="center">${cusList.userAddr } ${cusList.userAddr_detail }</td>
							  
							<td width="82px;" align="center">
							${cusList.userGender }
							</td>
							  
							<td width="80px;" align="center">							
							${cusList.userTel }
							</td>
							  
							<td width="160px;" align="center">
							${cusList.userEmail }
							</td>
							  
							<td width="100px;" align="center">
							${cusList.userPoint }
							</td>
							
							<td width="100px;" align="center">
								<c:forEach var="bookList" items="${bookList }">
									<c:if test="${cusList.userId==bookList.userId }">
										&nbsp;${bookList.bookPrice }원
									</c:if>
								</c:forEach>
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
	</div>
</div>
	
	
	
<%-- 	
	${bookList.bookPrice } &nbsp;&nbsp;
 --%>
	
	
	
	
	