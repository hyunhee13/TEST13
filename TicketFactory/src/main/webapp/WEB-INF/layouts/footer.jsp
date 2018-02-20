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
</head>
<body>
<br/><br/>
<!-- 하단 -->
<div id="footer">
	<div id="footer_1">
		<div id="footer_menu">
			<ul>
				<li onclick="" style="cursor:pointer;">Ticket Factory?</li>
				<li id="custom_rule_footer" style="cursor:pointer;">이용약관</li>
				<li id="custom_info_footer" style="cursor:pointer; ">개인정보취급방침</li>
				<li onclick="javascript:location.href='<%=cp%>/group.action'" style="cursor:pointer;">단체관람</li>
				<li onclick="javascript:location.href='<%=cp %>/faqList.action'" style="cursor:pointer;">고객센터</li>
			</ul>
		</div>
	</div>

	<div id="footer_2" >
		<div id="footer_copyright">
			<div style="float:left; margin-left:70px;">
				<img src="/ticketfactory/resources/image/logo_footer_.png" style="padding-top:5px; width: 100px; height: 80px;">
			</div>
			<div style="float:left; margin-left:40px; font-size:11px; line-height:180%; letter-spacing:0.8px; color:#d6d6d6; ">
				<p>(주)티켓팩토리&nbsp;&nbsp;|&nbsp;&nbsp;대표이사 : 신동화&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 105-87-89446&nbsp;&nbsp;|&nbsp;&nbsp;통신판매업신고 : 2014-서울금천-0792</p>
				<p>서울 강남구 테헤란로 123 &nbsp;&nbsp;|&nbsp;&nbsp;개인정보관리책임자 : 최숙향(shtm0559@nate.com )</p>
				<p>Copyright @ Ticket Factory All Rights Reserved&nbsp;&nbsp;|&nbsp;&nbsp;Hosting by 심플렉스인터넷(주)&nbsp;&nbsp;|&nbsp;&nbsp;고객센터 : 02-6255-8061</p>
			</div>
		</div>
	</div>
</div><!-- 하단끝 -->

</body>
</html>