<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>



<script>
	$(document).ready(function () {  
        var top = $('#adside').offset().top - parseFloat($('#adside').css('marginTop').replace(/auto/, 0));
        $(window).scroll(function (event) {
        var y = $(this).scrollTop();
  
       if (y >= top) {
          $('#adside').addClass('fixed');
       } else {
          $('#adside').removeClass('fixed');
      }
  });
    
        $("#bottom_price_list").click(function(){
        	
        	$("#bottom_price_list").css("color","#ff0000");
        	$("#grade_list").css("color","#555");
        	
        	$("#bottom_price_list_img").attr("src","/ticketfactory/resources/image/sort_tri_on.png");
        	$("#grade_list_img").attr("src","/ticketfactory/resources/image/sort_tri_off.png");
        	
        });
        
		$("#grade_list").click(function(){
        	
			$("#grade_list").css("color","#ff0000");
			$("#bottom_price_list").css("color","#555");
			
			$("#grade_list_img").attr("src","/ticketfactory/resources/image/sort_tri_on.png");
        	$("#bottom_price_list_img").attr("src","/ticketfactory/resources/image/sort_tri_off.png");
        });
		

        
});
</script>

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

<!-- sub menu -->
<script type="text/javascript">
	$(function() {
		$('nav ul li').hover(function() {
			//show its submenu
			$('ul', this).slideDown(150);
		}, function() {
			//hide its submenu
			$('ul', this).slideUp(150);
		});
	});
</script>

<script type="text/javascript">

function go(showId, showName){
	var param = encodeURIComponent(showName);
	document.f.action="<%=cp%>/layout.action?showId=" + showId+ "&showName=" + param;
		document.f.submit();

	}
	
	function changeColor() {

		var listNum = '${order}';
		//alert("ddd");
		if(listNum!=null){
		//alert(listNum);
		
		if(listNum=='price'){

	    	$("#bottom_price_list").css("color","#ff0000");
	    	$("#grade_list").css("color","#555");
	    	
	    	
	    	
	    	$("#bottom_price_list_img").attr("src","/ticketfactory/resources/image/sort_tri_on.png");
	    	$("#grade_list_img").attr("src","/ticketfactory/resources/image/sort_tri_off.png");
			
			
		}
		
		
		if(listNum=='star'){
			
			
			$("#grade_list").css("color","#ff0000");
			$("#bottom_price_list").css("color","#555");
			
			$("#grade_list_img").attr("src","/ticketfactory/resources/image/sort_tri_on.png");
	    	$("#bottom_price_list_img").attr("src","/ticketfactory/resources/image/sort_tri_off.png");
			
		}}
		
		
			genre = ${genre};
			
			$("#genre"+genre).css("color","#FF007F");
			$("#genre"+genre).css("font-weight","bold");
			
	

	}
</script>


</head>
<body onload="changeColor();">


<div id="show_content_session">
	<div id="adsideWrapper">	
	    <div id="adside">
			<div id="show_content_session_1">						
				<p style="font-size: 12pt; font-weight: bold; color: #313131;">
				오늘공연
				</p>
				<div id="show_content_session_bar"></div>
				
				<div id="show_content_session_2">
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="today.action?genre=1" id="genre1">연극</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="today.action?genre=2"  id="genre2">뮤지컬</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="today.action?genre=3"  id="genre3">클래식</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="today.action?genre=4"  id="genre4">국악</a></font>
					</p>
					<p onclick="">
					<img class="icon_dot" 
					src="/ticketfactory/resources/image/icon_dot.png">
					<font style=""><a href="today.action?genre=5"  id="genre5">오페라</a></font>
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
						<font style=""><a href="today.action?genre=6"  id="genre6">서울</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="today.action?genre=7"  id="genre7">경기</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="today.action?genre=8"  id="genre8">충청</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="today.action?genre=9"  id="genre9">경상</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="today.action?genre=10"  id="genre10">전라</a></font>
						</p>
						<p onclick="">
						<img class="icon_dot" 
						src="/ticketfactory/resources/image/icon_dot.png">
						<font style=""><a href="today.action?genre=11"  id="genre11">그외지역</a></font>
						</p>
					</div>
				</div>
							
			</div>									
		</div>
	</div>
		
	<div id="show_content_main_1">
		<div id="show_content_main_2">
			<table>
			<tr>
				<td align="right">
					<div id="show_content_main3">
						<table>
						<tr>
							<td style="border-right: 1px solid #656565; 
							text-align: center; width: 80px; height: 10px">
							<span style="color:#FF007F; font-weight: bold; font-size: 11pt;">
							오늘티켓
							</span>
							</td>
							
							<td style="text-align: center; width: 168px;height: 10px; font-weight: bold; font-size: 11pt;">
								<span id="date">
								${today }
								</span>
							</td>
						
							<td style="border-right: 1px solid #656565; 
							text-align: right; width: 500px; padding-right: 8px;">
								<img class="icon_dot" 
									src="/ticketfactory/resources/image/sort_tri_off.png"
									width="5px" height="10px" id="bottom_price_list_img">
									<a href="today.action?genre=${genre }&order=price&listNum=1"><font style="color:#FF007F; 
									font-weight: bold; font-size: 11pt;"id="bottom_price_list">최저가순</font></a>
							</td>
							<td style="text-align: center; width: 80px">
								<img class="icon_dot" 
									src="/ticketfactory/resources/image/sort_tri_off.png"
									width="5px" height="10px" id="grade_list_img">
									<a href="today.action?genre=${genre }&order=star&listNum=2"><font style="color:#FF007F; 
									font-weight: bold; font-size: 11pt;" id="grade_list">평점순</font></a>
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
				<table width="100%">
				
							<c:set var="doneLoop" value="false" />
							<c:set var="r" value="1" />
							
							
							<c:if test="${empty show }">
								<c:if test="${empty area }">
									<tr height="100px;"><td width="100%"></td></tr>
									
									<tr><td width="100%" align="center" style="font-size: 12px;">${today }에 예매가능한 티켓이 없습니다.</td></tr>
								</c:if>
							</c:if>
							
							
							<c:if test="${!empty show }">
								<c:forEach var="dto" items="${show }" varStatus="status">


									<c:if test="${not doneLoop }">
										<c:if test="${r==1 }">
											<tr>
										</c:if>

										<td width="185px" align="center"> 
											<table id="content_table"width="185px;" height="300px" style="margin-top: 15px;"
											onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
											onMouseOut="this.style.border='1px solid white';this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
											onclick="go('${dto.showId}','${dto.showName }');">
												<tr>
													<td colspan="2" style="width: 185px; height: 240px; vertical-align: top;">
													
													<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
													
													<img alt="사진넣는곳"
														src="${dto.showPoster }" 
														style="vertical-align: top;" width="200" height="240px"></td>
																
												</tr>

												<tr>
													<td colspan="2"
														style="height: 45px; font-weight: bold; font-size: 10.5pt;">${dto.showName }&nbsp;
														
													</td>
												</tr>
												
												
												<tr>
													<td colspan="2"
														style="height: 22px; font-weight: bold; font-size: 15pt;">
														<c:choose>
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
														</c:choose>
													</td>
												</tr>

												<tr>
													<td style="height: 30px; font-size: 12pt; color: blue; font-weight: bold;">
													<span>60%</span>
													</td>
													<td align="right"
														style="height: 50px; color: #FF007F; font-weight: bold; font-size: 11pt; padding-right: 5px;">
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
										<c:if test="${status.count == 16}">
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

										<td width="185px" align="center"> 
											<table id="content_table"width="185px;" height="300px" style="margin-top: 15px;"
											onMouseOver="this.style.border='1px solid #ed3d84';this.style.opacity='.9'; this.style.filter='alpha(opacity=90)'"
											onMouseOut="this.style.border='1px solid white';this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
											 onclick="go('${dto.showId}','${dto.showName }');">
												<tr>
													<td colspan="2" style="width: 185px; height: 240px; vertical-align: top;">
													
													<c:if test="${!empty dto.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
													
													<img alt="사진넣는곳"
														src="${dto.showPoster }"
														style="vertical-align: top;" width="200" height="240px"></td>
																
												</tr>

												<tr>
													<td colspan="2"
														style="height: 45px; font-weight: bold; font-size: 10.5pt;">${dto.showName }&nbsp;
														
													</td>
												</tr>
												
												
												<tr>
													<td colspan="2"
														style="height: 22px; font-weight: bold; font-size: 15pt;">
														<c:choose>
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
														</c:choose>
													</td>
												</tr>
												
												<tr>
													<td style="height: 30px; font-size: 12pt; color: blue; font-weight: bold;"><span>60%</span>
													</td>
													<td align="right"
														style="height: 50px; color: #FF007F; font-weight: bold; font-size: 11pt; padding-right: 5px;">
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
										<c:if test="${status.count == 16}">
											<c:set var="doneLoop" value="true" />
										</c:if>
									</c:if>
								</c:forEach>
								</c:if>
								
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
	</div>
</div>
	

</body>
</html>
