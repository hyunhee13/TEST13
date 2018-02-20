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
<title>벤트찌</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> -->

<!-- <script>

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
});
</script> -->

<script type="text/javascript">
	
	function color(){
		
		$("#a").css("color","#FF007F");
		
	}
	
</script>


</head>
<body onload="color();">

<div id="Wrap">
	
	<div id="section_wrap">
	
	<!-- 	<div id="adsideWrapper">	
		<div id="adside"> -->

		<div id="talk_menu">

			<div class="talk_menu_home">
				<p><a href="bbs_list.php?tb=talk_main"><span class="talk_menu_off">티켓톡 홈</span></a></p>
			</div>
			<div class="talk_menu_title_bar"></div>

			<div class="talk_menu_sub">
				<p><a href="<%=cp%>/eventList.action"><span class="talk_menu_on" id="a">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span></a>
				</p>
				
				<p><a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on" id="b">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">실시간 별점</span></a>
				</p>
				<p>
					<a href="<%=cp%>/yangdoList.action"><span class="talk_menu_on" id="c">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">티켓양도</span>
					</a>
				</p>

			</div>

			<div class="talk_menu_title_bar2"></div>

		</div>
		<!-- </div>
		</div> -->
		
		<div id="right_content">
			<div style="padding-bottom:30px;">
				<div style="padding:23px 23px 0 23px;">
					<div class="talk_title">
					이벤트/기획전
					</div>
				
					<div class="talk_subtitle">
					타임티켓이 준비한 다양한 이벤트 / 특별한 기획전을 만나보세요!
					</div>

					<hr class="talk_title_underline">
				
					<center>
						<div style="margin-top:20px; width:100%;">
							
							<table width=100% cellpadding=0 cellspacing=0  border=0>	
								<c:forEach var="dto" items="${lists}">
								<tr>
									<td valign=top align=center>
									
									<div style="position:relative; margin:0px 10px 8px 10px; cursor:pointer; " 
									class="border0" onMouseOver="this.className='border2';" onMouseOut="this.className='border0'" 
									onclick="location.href='${articleUrl}&ebNum=${dto.ebNum}';">
									
										<div style="float:left; width:150px; height:150px; background:#f1f1f1;">
											<img src="${imageUrl}${dto.ebTitleimage}" style="width:150px; height:150px;">
										</div>
					
										<div style="float:left; background:#f1f1f1;  width: 553px; height:135px; padding-right:15px; padding-left:20px; padding-top:15px; text-align:left; font-size:14px; vertical-align:top;">
									
											<div style="color:#e81b19; height:25px;">
												[${dto.ebTitle }]
											</div>
					
											<div style="height:20px;">
												<span style="color: #313131; font-weight:600; ">
													<b>
														<a href="${articleUrl}&ebNum=${dto.ebNum}">${dto.ebSubject }</a>
													</b>
												</span>
											</div>
					
											<div style="height:55px; line-height:150%;">
												<div style="color:#777;">${dto.ebTitleContent }</div>
											</div>
							
											<div style="height:35px;">
												<div style="color:#313131;">기간 : ${dto.ebPeriodFrom }~${dto.ebPeriodTo }</div>
											</div>
					
										</div>
					
									<div style="clear:both;"></div>
									
									</div>
									
									</td>	
								</tr>
								</c:forEach>
							</table> 
						</div>
					</center>
		
					<div style="margin-top:20px; text-align: center; width: 100%">
							<div>
								<c:if test="${dataCount!=0 }">
									${pageIndexList }
								</c:if>
								<c:if test="${dataCount==0 }">
									등록 된 게시물이 없습니다.
								</c:if>
							</div>
					</div>
					<br/>
					<!-- 글쓰기버튼 -->
					<c:if test="${sessionScope.adminId=='admin' }">
					<div style="padding:1px 1px 15px 15px; text-align: right;  padding-right: 11px;">
						<a href='<%=cp%>/eventCreated.action'>
						<img src='/ticketfactory/resources/image/btn_write.png' 
						border=0 height='40' alt='글쓰기' style="width: 65px; height: 35px;">
						</a>
					</div>
					</c:if>

					<table cellpadding="0" cellspacing="0" style="width:100%;">
						<tr height="0">
							<td align="right" style="padding-top:20px;"></td>
						</tr>  
					</table>

				</div>
			</div>

		</div>
	</div>
	<div class="footer_pd"></div>
</div>


</body>
</html>