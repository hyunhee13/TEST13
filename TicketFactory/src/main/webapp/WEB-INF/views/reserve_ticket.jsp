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

<link rel="stylesheet" href="/ticketfactory/resources/css/showContent.css" type="text/css"/>
<link rel="stylesheet" href="<c:url value="/resources/css/seeMore.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/reserve_ticket.css"/>" type="text/css" />




<!-- 로그인 마우스오버시에 -->
<script type="text/javascript">
		var timeout = 100;
		var closetimer = 0;
		var ddmenuitem = 0;
		function top_gnb_open() {
			top_gnb_canceltimer();
			top_gnb_close();
			ddmenuitem = $(this).find('ul').eq(0).css(
					'visibility', 'visible');
		}
		function top_gnb_close() {
			if (ddmenuitem)
				ddmenuitem.css('visibility', 'hidden');
		}
		function top_gnb_timer() {
			closetimer = window.setTimeout(top_gnb_close,
					timeout);
		}
		function top_gnb_canceltimer() {
			if (closetimer) {
				window.clearTimeout(closetimer);
				closetimer = null;
			}
		}
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
	$(document).ready(function() {
		$('#top_gnb > li').bind('mouseover', top_gnb_open);
		$('#top_gnb > li').bind('mouseout', top_gnb_timer);
	});
	document.onclick = top_gnb_close;
</script>
<script type="text/javascript">

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
		document.f.submit();

	}
	
function changeColor() {
	
	genre = ${genre};
	
	$("#genre"+genre).css("color","#FF007F");
	$("#genre"+genre).css("font-weight","bold");
	
}
</script>

</head>
<body onload="changeColor()">


<div id="show_content_session">
	<div id="adsideWrapper">	
	    <div id="adside">
			<div id="show_content_session_1">						
				<p style="font-size: 12pt; font-weight: bold; color: #313131;">
				공연
				</p>
				<div id="show_content_session_bar"></div>
				
				<div id="show_content_session_2">
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="reserve_ticket.action?genre=1" id="genre1">연극</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="reserve_ticket.action?genre=2" id="genre2">뮤지컬</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="reserve_ticket.action?genre=3" id="genre3">클래식</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="reserve_ticket.action?genre=4" id="genre4">국악</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="reserve_ticket.action?genre=5" id="genre5">오페라</a></font>
					</p>
					
				</div>
				<div id="show_content_session_3">
					<p style="font-size: 12pt; font-weight: bold; color: #313131;">
					지역
					</p>
					<div id="show_content_session_bar"></div>
					
					<div id="show_content_session_2">
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=6" id="genre6">서울</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=7" id="genre7">경기</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=8" id="genre8">충청</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=9" id="genre9">경상</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=10" id="genre10">전라</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="reserve_ticket.action?genre=11" id="genre11">그외지역</a></font>
						</p>
					</div>
				</div>
									
			</div>									
		</div>
	</div>
	
	<div id="reserve_content_main_1">
		<div id="show_content_main_2">
			<table>
			<tr>
				<td align="right">
					<div id="show_content_main3">
						<table>
						<tr>
							<td style="text-align: center; width: 80px; height: 10px">
							<span style="color:#FF007F; font-weight: bold; font-size: 11pt;">
							공연예매
							</span>
							</td>
							
							<td style="text-align: center; width: 168px;height: 10px">
								<span id="date">
								 &nbsp;
								</span>
							</td>
						
							<td style="border-right: 1px solid #656565; 
							text-align: right; width: 500px; padding-right: 8px;">
								<img class="icon_dot" 
									src="/ticketfactory/resources/image/sort_tri_off.png"
									width="5px" height="10px" id="bottom_price_list_img">
									<a href="reserve_ticket.action?genre=${genre }&order=price"><font style="color:#FF007F; font-weight: bold; font-size: 11pt;"id="bottom_price_list">최저가순</font></a>
							</td>
							<td style="text-align: center; width: 80px">
								<img class="icon_dot" 
									src="/ticketfactory/resources/image/sort_tri_off.png"
									width="5px" height="10px" id="grade_list_img">
									<a href="reserve_ticket.action?genre=${genre }&order=star"><font style="color:#FF007F; font-weight: bold; font-size: 11pt;" id="grade_list">평점순</font></a>
							</td>
						</tr>
						</table>
					</div>
				</td>
			</tr>
			</table>
			<div id="show_content_main_bar"></div>
			
			<form action="" method="post" name="f">
			<div id="show_content_list1">
			
				<c:set var="doneLoop" value="false" />

				<c:if test="${!empty show }">
				<c:forEach var="dto" items="${show }" varStatus="status">
				
				
				<c:if test="${not doneLoop }">
				<table width="100%" style="font-family: 맑은 고딕;">
					<tr height="90px;">
						<td width="100%">
							<table width="100%" height="100%" style="padding: 5px 0px 5px 0px;"
 							onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
							onMouseOut="this.style.border='0px'; this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
							onclick="go('${dto.showId}','${dto.showName }');"
							class="reserve_content">
								<tr>
									<td width="16%">
									
									<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
									
									
										<img alt="포스터" src="${dto.showPoster }" style="width: 130px; height: 90px;" >
									</td>
									<td class="reserve_content_name" width="42%">[${dto.placeAddr}] ${dto.showName }</td>
									<td width="10%" style="color: #FF007F; font-size: 14px"><c:choose>
															<c:when test="${dto.avgStar ==0 }">
															☆☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==1 }">
															★☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==2 }">
															★★☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==3 }">
															★★★☆☆
															</c:when>
															<c:when test="${dto.avgStar==4 }">
															★★★★☆
															</c:when>
															<c:when test="${dto.avgStar==5 }">
															★★★★★
															</c:when>
														</c:choose></td>
									<td class="reserve_content_place" width="16%" align="center">${dto.placeName }</td>
									<td class="reserve_content_price" width="16%">
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
				
				<c:if test="${status.count == 20}">
					<c:set var="doneLoop" value="true" />
				</c:if>
				</c:if>
				
				
				</c:forEach>
				</c:if>
				
				<!--     //////////////////////////////////////               -->
				<c:if test="${empty show }">
				<c:forEach var="dto" items="${area }" varStatus="status">
				
				
				<c:if test="${not doneLoop }">
				<table width="100%" style="font-family: 맑은 고딕;">
					<tr height="90px;">
						<td width="100%">
							<table width="100%" height="100%" style="padding: 5px 0px 5px 0px;"
 							onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
							onMouseOut="this.style.border='0px'; this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
							onclick="go('${dto.showId}','${dto.showName }');"
							class="reserve_content">
								<tr>
									<td width="16%">
									
 									<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
													
										<img alt="포스터" src="${dto.showPoster }" style="width: 130px; height: 90px;" >
									</td>
									<td class="reserve_content_name" width="42%">[${dto.placeAddr}] ${dto.showName }</td>
									<td width="10%" style="color: #FF007F;"><c:choose>
															<c:when test="${dto.avgStar ==0 }">
															☆☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==1 }">
															★☆☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==2 }">
															★★☆☆☆
															</c:when>
															<c:when test="${dto.avgStar==3 }">
															★★★☆☆
															</c:when>
															<c:when test="${dto.avgStar==4 }">
															★★★★☆
															</c:when>
															<c:when test="${dto.avgStar==5 }">
															★★★★★
															</c:when>
														</c:choose></td>
									<td class="reserve_content_place" width="16%" align="center">${dto.placeName }</td>
									<td class="reserve_content_price" width="16%">
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
				
				<c:if test="${status.count == 20}">
					<c:set var="doneLoop" value="true" />
				</c:if>
				</c:if>
				
				
				</c:forEach>
				</c:if>
				
				
			</div>
			</form>
			<br/>
			<div class="pageIndex">${pageIndexList }</div>
		</div>
	</div>
</div>



<br/>


</body>
</html>
