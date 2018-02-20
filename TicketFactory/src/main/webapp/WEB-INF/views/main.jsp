<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script>

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId="+ showId + "&showName=" + param;
	document.f.submit();

}
function goToday(showId, showName){
	var param = encodeURIComponent(showName);
	document.tf.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
	document.tf.submit();

}



</script>


<!-- <script src="/ticketfactory/resources/js/menu.js"></script> -->
<!-- <script src="/ticketfactory/resources/js/jquery.ulslide.js"></script> -->

<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/main.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/mainbody.css" type="text/css"/>

<title>티켓 팩토리</title>
</head>
<body>



	<div id="wrap">
		<div id="wrap_in">
			<div id="main_bn">
			<li><img src="/ticketfactory/resources/image/image1.jpg" style="width: 700px; height: 410px;"/></li>
			<li><a href="oneplus.action"><img src="/ticketfactory/resources/image/image13.png" style="width: 700px; height: 410px;"/></a></li>
			<li><img src="/ticketfactory/resources/image/image22.png" style="width: 700px; height: 410px;"/></li>
			
			<div id="main_bn_btn">
				<li><a href="#"><img
						src="/ticketfactory/resources/image/blt.png"></a></li>
				<li><a href="#"><img
						src="/ticketfactory/resources/image/blt.png"></a></li>
				<li><a href="#"><img
						src="/ticketfactory/resources/image/blt.png"></a></li>
			
			</div>
		</div>
		
		<div id="main_bn2">
			<div id="main_side">
				<a href="weekBest.action"><img src="/ticketfactory/resources/image/best_show.JPG" style="width: 300px; height: 204px;"></a>
			</div>
			<div id="main_side">
				<a href="yangdoList.action"><img alt="" src="/ticketfactory/resources/image/event.JPG" style="width: 300px; height: 204px;"></a>
			</div>
		</div>
		</div>

	</div>          


<div class="main_wbg_area">
		<div class="main_wrap">



						<!-- 오늘티켓/마감임박 -->
						<div>

							<span
								style="margin-bottom: 20px; font-size: 20px; letter-spacing: -1px; font-weight: 500;"
								alt="오늘티켓">마감임박 <span style="color: #ed3d84"> 오늘티켓</span></span>
							<a href="today.action?genre=1"> <img
								src="/ticketfactory/resources/image/btn_more.png"
								style="vertical-align: -2px; padding-left: 10px; padding-right: 10px;"
								alt="더보기">
							</a>

							<div class="main_topline" style="margin-top: 20px;">

								<form method="post" name="tf">
									<table width=100% border=0 cellpadding='0' cellspacing='0'>
										<c:set var="doneLoop" value="false" />
										<c:set var="r" value="1" />
										<c:forEach var="dto" items="${todayList }" varStatus="status">

											<c:if test="${not doneLoop }">
												<c:if test="${r==1 }">
													<tr>
												</c:if>


												<td valign=top align=center>
												<%-- <a href='javascript:void(0);' onclick="goToday('${dto.showId}','${dto.showName }');"
												<a href='goToday('${dto.showId}','${dto.showName }'); return false;'
													class="underline"> --%>

														<div class="main_day_wrap main_shadow1"
															onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
															onMouseOut="this.style.border='1px solid #dbdbdb';this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
															onclick="goToday('${dto.showId}','${dto.showName }');">

															<div style="position: relative; z-index: 0;"
																align="right">
																<div
																	style="position: absolute; width: 120px; top: 3px; right: 3px;"></div>
															</div>

															<div style="width: 185px; line-height: 0%;">
															
															<c:if test="${!empty dto.event }">
															<div style="position:relative; z-index:0; width:100%;" align="right">
															<div style="position:absolute; width:100%; top:3px; right:4px;;">
															<div class="circle1">1+1</div>
															</div>
															</div></c:if>
															
																<img src='${dto.showPoster }'
																	style="width: 180px; height: 190px;"
																	>
																
																
															</div>

															<div
																style="width: 165px; border-top: 1px solid #d6d6d6; padding: 10px 4px;">
																<div style="text-align: left; padding-bottom: 8px;"
																	class="main13bold ellip">${dto.showName }</div>
																<div>
																	<div style="float: left; font-size: 12px;">57%</div>
																	<div style="float: right; line-height: 13px;"
																		class="price14bold">
																		<c:if test="${!empty dto.seatState }">
																				${dto.seatState }
																			</c:if>
																		<c:if test="${empty dto.seatState }">
																				${dto.showPrice }
																			</c:if>
																	</div>
															
																</div>
															</div>
														</div>
												<!-- </a> -->
												</td>

												<c:set var="r" value="${r+1 }" />
												<c:if test="${r ==6 }">
													</tr>
													<c:set var="r" value="1" />
												</c:if>
												<c:if test="${status.count == 10}">
													<c:set var="doneLoop" value="true" />
												</c:if>

											</c:if>
										</c:forEach>
										<c:if test="${r!=11 }">
											<c:forEach var="r" begin="${r }" end="10" step="1">
												<td width="185"></td>
											</c:forEach>
											</tr>
										</c:if>

									</table>
								</form>


							</div>
						</div>
					</div>
				</div>



						<!-- 쉽고 편리한 티켓예매 -->
						<div class="main_wbg_area" style="padding-top: 50px;">
							<div class="main_wrap">
								<div style="padding-bottom: 30px;">
									<span
										style="margin-bottom: 20px; font-size: 20px; letter-spacing: -1px; font-weight: 500;"
										alt="예매티켓"> 쉽고 편리한<span style="color: #ed3d84">
											티켓예매</span></span> <a href="reserve_ticket.action?genre=1">&nbsp; <img
										src="/ticketfactory/resources/image/btn_more.png"
										style="vertical-align: -2px; padding-left: 10px; padding-right: 10px;"
										alt="더보기"></a>


									<div class="main_topline" style="margin-top: 20px;">


										<form action="" method="post" name="f">
											<table width=100% border=0 cellspacing='0' cellpadding='0'>

												<c:set var="doneLoop" value="false" />
												<c:set var="r" value="1" />
												<c:forEach var="dto" items="${lists }" varStatus="status">

													<c:if test="${not doneLoop }">
														<c:if test="${r==1 }">
															<tr>
														</c:if>



														<td valign=top align=center>
															<!-- <a	href='./index.php?number=2939&category=2096r01r01&mode=perform'> -->
															<div style="padding: 0 0 40px 0;">
																<div
																	style="position: relative; width: 140px; height: 200px;">
																	<img src='${dto.showPoster }'
																		style="border: 1px solid #dbdbdb; width: 100%; cursor: pointer; height: 190px;"
																		onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
																		onMouseOut="this.style.border='1px solid #dbdbdb';this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
																		class="main_shadow"
																		onclick="go('${dto.showId}','${dto.showName }');">
																		
																 	<div style="position: absolute; top: 3px; right: -1px;">
																 		<c:if test="${empty dto.event }">
																		<span
																			style='background: #c388ff; padding: 2px 3px 1px 3px; color: #fff; font-size: 11px; margin-left: 3px;'>NEW</span>
																		</c:if>
																		<c:if test="${!empty dto.event}">
																		<span
																			style='background: #46c9c3; padding: 2px 3px 1px 3px; color: #fff; font-size: 11px; margin-left: 3px;'>1+1티켓</span>
																		</c:if>
																	</div>
																	
																</div>

																<div class="main_rows_02_bottom">
																	<div class="main_rows_02_title ellip">${dto.showName }</div>
																	<div
																		style="float: left; font-size: 12px; line-height: 20px;">
																		70%</div>
																	<div style="float: right; line-height: 20px;"
																		class="price13">
																		<c:if test="${!empty dto.seatState }">
																				${dto.seatState }
																			</c:if>
																		<c:if test="${empty dto.seatState }">
																				${dto.showPrice }
																			</c:if>
																		<!-- <span class="won12" style="vertical-align: top; line-height: 20px; padding: 0 0 0 1px;"></span> -->
																	</div>
																	<div class="price13"
																		style="display: none; margin-left: 39px;">무료</div>
																</div>
															</div>
														</td>

														<c:set var="r" value="${r+1 }" />
														<c:if test="${r ==7 }">
															</tr>
															<c:set var="r" value="1" />
														</c:if>
														<c:if test="${status.count == 24}">
															<c:set var="doneLoop" value="true" />
														</c:if>
													</c:if>
												</c:forEach>
											</table>
										</form>



									</div>
								</div>

							</div>

						</div>
						<!-- 쉽고 편리한 티켓예매 -->


</body>
</html>