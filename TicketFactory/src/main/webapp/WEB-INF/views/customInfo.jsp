<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

	<%-- <div id="col" style="background-color: #F7FFFF;">
		<p class="userId">회원아이디</p>
		<p class="userName">회원이름</p>
		<p class="addr_num">우편번호</p>
		<p class="addr">회원주소 + 상세주소</p>
		<p class="gender">성별</p>
		<p class="userTel">전화번호</p>
		<p class="userEmail">이메일</p>
		<p class="userPoint">회원포인트</p>
	</div>


	<c:forEach var="customList" items="${allCustomInfoList }">
		<div id="listInfo">
			<p class="userId">&nbsp;${customList.userId }</p>
			<p class="userName">&nbsp;${customList.userName }</p>
			<p class="addr_num">&nbsp;${customList.userAddr_num }</p>
			<p class="addr">&nbsp;${customList.userAddr } ${customList.userAddr_detail }</p>
			<p class="gender">&nbsp;${customList.userGender }</p>
			<p class="userTel">&nbsp;${customList.userTel }</p>
			<p class="userEmail">&nbsp;${customList.userEmail }</p>
			<p class="userPoint">&nbsp;${customList.userPoint }</p>
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
							<td align="center" width="70px;">회원아이디</td>
							<td align="center" style="width:55px;">회원이름</td>
							<td align="center" style="width:60px;">우편번호</td>
							<td align="center" style="width:280px;">회원주소 + 상세주소</td>
							<td align="center" style="width:37px;">성별</td>
							<td align="center" style="width:60px;">전화번호</td>
							<td align="center" style="width:110px;">이메일</td>
							<td align="center" style="width:55px;">회원포인트</td>	
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
						<c:forEach var="customList" items="${allCustomInfoList }">
						
						<tr height="40" onmouseup="this.style.backgroundColor='#f7f7f7';" 
						onmouseover="this.style.backgroundColor='';" style="width: 993px;">
						
							<td style="width: 108px;" align="center">
							${customList.userId }
							</td>
					 
					 		<td style="width: 125px;" align="center">
					 		${customList.userName }
					 		</td>
							
							<td width="110px;" align="center">
							${customList.userAddr_num }
							</td>
							 
							<td width="650px;" align="center">
							${customList.userAddr } ${customList.userAddr_detail }
							</td>
							  
							<td width="82px;" align="center">
							${customList.userGender }
							</td>
							  
							<td width="80px;" align="center">							
							${customList.userTel }
							</td>
							  
							<td width="160px;" align="center">
							${customList.userEmail }
							</td>
							  
							<td width="100px;" align="center">
							${customList.userPoint }
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
	
		<div id="paging">
		<c:if test="${dataCount!=0 }">
			${pageIndexList }
		</c:if>
		<c:if test="${dataCount==0 }">
			티켓 예매된 적이 없어요~
		</c:if>
	</div>
	
	
	