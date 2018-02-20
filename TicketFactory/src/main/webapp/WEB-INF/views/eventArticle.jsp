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
<title>Insert title here</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<script type="text/javascript">
	
	function color(){
		
		$("#a").css("color","#FF007F");
		
	}
	
</script>


</head>
<body onload="color();">

<div id="Wrap">
		
	<div id="section_wrap">

		<div id="talk_menu">

			<div class="talk_menu_home">
				<p><a href="bbs_list.php?tb=talk_main"><span class="talk_menu_off">티켓톡 홈</span></a></p>
			</div>
			
			<div class="talk_menu_title_bar"></div>

			<div class="talk_menu_sub">
				<p><a href="<%=cp%>/eventList.action"><span class="talk_menu_on" id="a">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span></a>
				</p>
				
				<p><a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">실시간 별점</span></a>
				</p>
				<p>
					<a href="<%=cp%>/yangdoList.action"><span class="talk_menu_on">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">티켓양도</span>
					</a>
				</p>

			</div>

			<div class="talk_menu_title_bar2"></div>

	</div>
		<div id="right_content">
			<div style="padding-bottom:30px;">
			
				<center>
					<table cellpadding="0" cellspacing="0" style="width:100%; background:#f8f8f8; border-bottom:1px solid #ccc;">
						<tr>
							<td style="padding:20px; width:70%">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td style="font-size:14px; text-align:left; padding-bottom:10px; ">
											<span style="color:#aaa;">[${dto.ebTitle }]</span>
										</td>
										
										<td class="talk_detail_date">
											${dto.ebCreated}&nbsp;&nbsp;|&nbsp;&nbsp;조회수 <span style="color:#08a2cc;">${dto.ebHitCount}</span>
										</td>
									</tr>		
									
									<tr>
										<td class="talk_detail_title">
											${dto.ebSubject }
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

					<table border="0" cellspacing="0" cellpadding="0" style="width:95%;">
						<tr>
							<td style="padding:40px 10px 40px 10px;">
							${dto.ebContent }
							</td>
						</tr>
					</table>

					<table cellspacing="0" cellpadding="0" style="width:95%;">
						<tr>
							<td align="center" style="padding-right:10px;">	
							
							<c:if test="${sessionScope.adminId=='admin' }">
								<input type="button" value=" 수정하기 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/eventUpdated.action?ebNum=${dto.ebNum}&pageNum=${pageNum}';"/>
								
								<input type="button" value=" 삭제하기 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/eventDeleted.action?${params}&ebNum=${dto.ebNum}';"/>
								
								<input type="button" value=" 목록 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/eventList.action?${params}';"/>
							</c:if>
							
							<c:if test="${empty sessionScope.adminId }">
								<input type="button" value=" 목록 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/eventList.action?${params}';"/>
							</c:if>
	
							</td>
						</tr>

					</table>

			</center>

			</div>
		</div>

	</div>
</div>


<div class="footer_pd"></div>
<br/><br/>
</body>
</html>