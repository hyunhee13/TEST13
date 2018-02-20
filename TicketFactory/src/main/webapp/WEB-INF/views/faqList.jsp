<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 
<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>  

<script type="text/javascript">

	function sendIt(){
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/notiList.action";
		f.submit();
		
	}
	

</script>


<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script> -->

<script src="/ticketfactory/resources/js/menu.js"></script>
<!-- <script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script>
 -->
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>


<title>공지사항</title>
</head>

<body>

<div class="wrap_topmargin">

	<table style="margin:auto;border:1px solid #d8d8d8;background-color:#ffffff;">
		<tr>
			<td>
				<div class="cs_wrap">
				
					<!-- 왼쪽메뉴창 -->
					<div class="cs_left_menu">
						<div class="cs_left_menu_title">
							<img src="/ticketfactory/resources/image/img_cstitle.png">
						</div>

						
						<div class="cs_left_menu_sub">
				
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/notiList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_notice_off.png" alt="공지사항">
								</p>
							</div>
							
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/faqList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_faq_on.png" alt="자주묻는질문">
								</p>
							</div>
						
							<div class="cs_left_menu_sub1">
								<p onclick="idCheck();" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_private_off.png" alt="일대일문의">
								</p>
							</div>
						
							<div class="cs_left_menu_sub2">
								<p onclick="javascript:location.href='<%=cp%>/refundList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_refund.png" alt="환불취소안내">
								</p>
							</div>
						</div>	
					</div>
					<!-- 끝 -->
				
			<!-- 게시판부분 아작스 ㅎㅎ 시발안해
			<div id="customerCenter" style="display: none"></div>
			
			<span id="listData" style="display: none"></span>
			
			<span id="listData2" style="display: none"></span> -->
				
			<div class="cs_content">
			<div class="cs_content_title">
				<p>
					<img src="/ticketfactory/resources/image/title_faq.png" style="padding:0 0 0 2px;">
				</p>
			</div>
			
			<center><div class="cs_content_bar"></div></center>
	
			<div style="width:100%; padding:20px 23px 0 23px;">
	
				<div style="width:700px; border:5px solid #f285b5; 
				margin-bottom:20px; padding:20px; height: 70px; padding-bottom: 30px;">
					<table>
					<c:forEach var="dto" items="${fhlists}">
						<tr height="40" class="listCss">
							<p style="width:685px; border-bottom:1px solid #e6e6e6; padding-bottom:5px; 
							padding-left:15px; padding-top: 5px;">	
							<a href="${articleUrl}&faqNum=${dto.faqNum}">
							Q. ${dto.faqSubject }
							</a>
							</p>
						</tr>
					</c:forEach>	
					</table>
				</div>

			<table cellspacing="0" width="750">
			<tr>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_left.gif"></td>
				<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
					<table cellspacing="0" style="width:100%;">
					<tr>
						<td class="myTable" style="width:50px;" align="center">번호</td>
						<td class="myTable" align="center" style="width:400px;">제목</td>
					</tr>
					</table>
				</td>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_right.gif"></td>
			</tr>
			</table>

			<table cellpadding="0" cellspacing="0" width="750" bgcolor="#FFFFFF">
				<tr>
					<td>
						<table width=100% cellpadding=0 cellspacing=0  border=0>
							<tr>
								<td valign=top align=center>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
									<c:forEach var="dto" items="${lists}">
										<tr height="40" class="listCss">
											<td width="55" align="center">${dto.faqNum}</td>
											<td width="1"></td>
											<td width="400" align="left" style="padding-left:10px;">
											<a href='${articleUrl}&faqNum=${dto.faqNum}'>
											${dto.faqSubject }</a></td>
											<td width="1"></td>
										</tr>
									</c:forEach>	
										<tr>
											<td style="height:1px;border-bottom:1px dotted #dbdbdb;"colspan="13"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
						

			<div style="width:100%; padding-top:30px; text-align:center;">

			
			
			<!-- 페이징처리 -->
			<div id='page'>
				<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
				<c:if test="${dataCount==0 }">
					등록 된 게시물이 없습니다.
				</c:if>
			</div>
			
			<!-- 글쓰기버튼 -->
			<c:if test="${!empty sessionScope.adminId }">
			<div style="text-align:right; padding:1px 1px 15px 15px;  padding-right: 44px;">
				<a href='<%=cp%>/faqCreated.action?pageNum=${currentPage}'>
				<img src='/ticketfactory/resources/image/btn_write.png' 
				border=0 height='40' alt='글쓰기' style="width: 65px; height: 35px;">
				</a>
			</div>
			</c:if>

	

		</div>
	
	</div>

</div>	




	</div>
	</td>
	</tr>
	</table>
		
	</div>

<br/><br/>
</body>
</html>