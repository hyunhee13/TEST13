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

<script type="text/javascript">

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
		document.f.submit();

	}
</script>

<link rel="stylesheet" href="<c:url value="/resources/css/seeMore.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/oneplus.css"/>" type="text/css"/>

<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>
</head>
<body>


<div style="text-align:center; border-bottom:25px solid #554341; background-color:#46c9c3;">
	<img src="/ticketfactory/resources/image/1plus1.JPG" style="width:900px;">
</div>


<div class="oneplus_d">
	<div style="height: 50px;"></div>
	<div>
		<img src="/ticketfactory/resources/image/howto.JPG">
		<br/>
	</div>
	<div>
		<img src="/ticketfactory/resources/image/howto_d.JPG">
	</div>
	<div style="height: 50px;"></div>
	<div>
		<img src="/ticketfactory/resources/image/1plus1_v.JPG">
		<br/><br/>
	</div>
	<div class="oneplus_content">
		<!-- 1+1하는 티켓 정보 띄우는 곳!!! -->
		
		<form action="" method="post" name="f">
			<div id="">
				<table width="100%">
				
							<c:set var="doneLoop" value="false" />
							<c:set var="r" value="1" />
							
							<c:if test="${empty lists }">
									<tr height="100px;"><td width="100%"></td></tr>
									<tr><td width="100%" align="center" style="font-size: 12px;">현재 예매가능한 1+1티켓이 없습니다.</td></tr>
							</c:if>

								<%-- <c:forEach var="dto" items="${lists }" varStatus="status"> --%>
								<c:forEach var="dto" items="${lists }">


									<c:if test="${not doneLoop }">
										<c:if test="${r==1 }">
											<tr height="20px;"><td></td></tr>
											<tr>
										</c:if>

										<td width="200px" align="center">
											<table
											onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
											onMouseOut="this.style.border='1px solid #dbdbdb';this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
											class="oneplus_table"
											onclick="go('${dto.showId}','${dto.showName }');">
												<tr>
													<td colspan="2">
													
													<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
													
													<img alt="사진넣는곳"
														src="${dto.showPoster }" width="200" height="239" onclick="go('${dto.showId}','${dto.showName }');"></td>
																
												</tr>

												<tr>
													<td colspan="2"
														style="height: 22px; font-weight: bold; font-size: 12pt;">[${dto.placeAddr}] ${dto.showName }</td>
												</tr>

												<tr>
			
													<td
														style="height: 30px; color: #FF007F; font-weight: bold;">
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
										</td>
										
										<c:set var="r" value="${r+1 }" />
										<c:if test="${r ==5 }">
											</tr>
											<c:set var="r" value="1" />
										</c:if>
										<%-- <c:if test="${status.count == 16}">
											<c:set var="doneLoop" value="true" />
										</c:if> --%>
									</c:if>
								</c:forEach>

								<c:if test="${r!=1 }">
									<c:forEach var="r" begin="${r }" end="4" step="1">
									<td width="200px;"></td>
									</c:forEach>
									</tr>
								</c:if>
				
				</table>
			</div>
			</form>
	</div>
	<br/><br/>
</div>



</body>
</html>