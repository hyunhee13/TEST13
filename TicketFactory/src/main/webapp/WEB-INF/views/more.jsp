<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link rel="stylesheet" href="<c:url value="/resources/css/start.css"/>"
	type="text/css" />
<link rel="stylesheet" href="/ticketfactory/resources/css/menu.css"
	type="text/css" />
<link rel="stylesheet" href="/ticketfactory/resources/css/mainbody.css"
	type="text/css" />
<script type="text/javascript">

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
		document.f.submit();

	}
</script>

</head>
<body>


	<p style="margin: auto;">
	<h2>
		<a href="more.action?genre=1">연극</a>/ <a href="more.action?genre=2">오페라</a>/
		<a href="more.action?genre=3">뮤지컬</a>/ <a href="more.action?genre=4">국악</a>/
		<a href="more.action?genre=5">클래식</a>/<br /> <a
			href="more.action?genre=6">서울</a>/ <a href="more.action?genre=7">경기</a>/
		<a href="more.action?genre=8">충청</a>/ <a href="more.action?genre=9">경상</a>/
		<a href="more.action?genre=10">전라</a>/ <a href="more.action?genre=11">그외지역</a>/
	</h2>

	<br />
	<hr>
	<div class="main_wbg_area" style="padding-top: 50px;">
		<div class="main_wrap">
			<div style="padding-bottom: 30px;">



				<div class="main_topline" style="margin-top: 20px;">


					<form action="" method="post" name="f">
						<table width=100% border=0 cellspacing='0' cellpadding='0'>

							<c:set var="doneLoop" value="false" />
							<c:set var="r" value="1" />
							<c:if test="${!empty show }">
								<c:forEach var="dto" items="${show }" varStatus="status">


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
														<span
															style='background: #c388ff; padding: 2px 3px 1px 3px; color: #fff; font-size: 11px; margin-left: 3px;'>NEW</span>
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
							</c:if>
							
							<c:if test="${empty show }">
								<c:forEach var="dto" items="${area }" varStatus="status">


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
														<span
															style='background: #c388ff; padding: 2px 3px 1px 3px; color: #fff; font-size: 11px; margin-left: 3px;'>NEW</span>
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
							</c:if>
						</table>
					</form>



				</div>
			</div>

		</div>

	</div>

</body>
</html>