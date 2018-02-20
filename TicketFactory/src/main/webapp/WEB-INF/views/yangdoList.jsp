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
<title>양도리스</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<!-- <script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script> -->
<script type="text/javascript">

	function sendIt(){
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/yangdoList.action";
		f.submit();
		
	}

</script>

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
});
</script>


<script type="text/javascript">
	
	function color(){
		
		$("#c").css("color","#FF007F");
		
	}
	
</script>

</head>
<body onload="color();">

<div id="Wrap">
	<div id="section_wrap">
		<div id="talk_menu">

			<div class="talk_menu_home">
				<p><span class="talk_menu_off">티켓톡 홈</span></p>
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
		</div>

		<div id="right_content">
			<div style="padding-bottom:30px;">
				<div style="padding:23px 23px 0 23px;">
					<div class="talk_title">
					양도 & 판매
					</div>
				
					<div class="talk_subtitle">
					피치못할 사정으로 공연예매가 불가능할 때! 티켓을 양도하거나 판매해주세요.<br/>
					(모든 거래는 티켓팩토리가 관리하에 안전하게 거래되고 있습니다.)
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
									onclick="location.href='${articleUrl}&ydNum=${dto.ydNum}';">
									
										<div style="float:left; background:#f1f1f1;  width: 710px; height:40px; 
										padding-right:15px; padding-left:20px; padding-top:20px; text-align:left;
										 font-size:14px; vertical-align:top;">
									
											<div style="color:#e81b19; height:27px;">
												[${dto.ydType }] &nbsp;&nbsp;
												
												<font style="color: #313131; font-weight:600; font-size: 16px;">
													<b>
														<a href="${articleUrl}&ydNum=${dto.ydNum}">${dto.ydSubject }</a>
													</b>
												</font>
												
												<font style="color:#313131; float: right;">작성자 : <b>${dto.ydId}</b> &nbsp;&nbsp; 작성일 : <b>${dto.ydCreated}</b></font>
							
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
		
					<div style="margin-top:20px; margin-bottom:20px; text-align: center; width: 100%">
							<div>
								<c:if test="${dataCount!=0 }">
									${pageIndexList }
								</c:if>
								<c:if test="${dataCount==0 }">
									등록 된 게시물이 없습니다.
								</c:if>
							</div>
					</div>
					
			<table cellpadding="0" cellspacing="0" width="750">
				<tr>
					<td style="padding-left: 250px;">
				<!-- 검색폼 // 시작 -->
					<table border='0' cellspacing='0' cellpadding='0'>
						<tr>
						  <td height='25' border='0'>
							<form action="" name="searchForm" method="post">
								<input type="radio" name="searchKey" value="ydSubject" checked> 제목
								<input type="radio" name="searchKey" value="ydType"> 타입
								<input type="radio" name="searchKey" value="ydContent"> 내용		
								<input type="text" name="searchValue" class="textField">
								<input type='image' src='/ticketfactory/resources/image/bbs_search.gif' 
								border=0 value='검색' align='absmiddle' onclick="sendIt()";
								style="padding-bottom:2px;">			
							</form>	
						  </td>
						</tr>
					</table>
					<!-- 검색폼 // 끝 -->
					</td>

					<c:if test="${!empty sessionScope.loginDto }">
					<td align="right">
						<div style="padding:1px 1px 15px 15px; text-align: right;  padding-right: 11px;">
							<a href='<%=cp%>/yangdoCreated.action'>
							<img src='/ticketfactory/resources/image/btn_write.png' 
							border=0 height='40' alt='글쓰기' style="width: 65px; height: 35px;">
							</a>
						</div>

					</td>
					</c:if>

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