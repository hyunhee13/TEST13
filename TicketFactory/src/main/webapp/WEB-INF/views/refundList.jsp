<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script>

<script src="/ticketfactory/resources/js/menu.js"></script>
<script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>


<title>슈비두바</title>
</head>

<body>
<!-- 아오 공지사항창 시작 -->
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

						
						<div class="cs_left_menu_sub" style="height: 1060px;">
				
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/notiList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_notice_off.png" alt="공지사항">
								</p>
							</div>
							
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/faqList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_faq_off.png" alt="자주묻는질문">
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
				<!-- 왼쪽메뉴창 끝 -->
				
			<!-- 게시판부분 아작스 ㅎㅎ 시발안해
			<div id="customerCenter" style="display: none"></div>
			
			<span id="listData" style="display: none"></span>
			
			<span id="listData2" style="display: none"></span> -->
			
			<!-- 게시판부분 -->
			<div class="cs_content">
				<div class="cs_content_title">
					<p>
						<img src="/ticketfactory/resources/image/title_refundinfo.png" style="padding:0 0 0 2px;">
					</p>
				</div>
				<center><div class="cs_content_bar"></div></center>
		
				<div style="width:100%; padding:15px 23px 0 23px;">
		
				<img src="/ticketfactory/resources/image/refundinfo_01.png" style="padding:20px 0 50px 0;">
		
				</div>
			
			</div>


	</div>
	</td>
	</tr>
	</table>
		
	</div>



</body>
</html>