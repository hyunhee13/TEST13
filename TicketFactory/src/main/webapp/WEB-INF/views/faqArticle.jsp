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

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		str = f.faqSubject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.faqSubject.focus();
			return;
		}
		f.faqSubject.value = str;
		
		str = f.faqContent.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.faqContent.focus();
			return;
		}
		f.faqContent.value = str;
		
		f.action = "<%=cp%>/faqCreated_ok.action?pageNum=${pageNum}";
		f.submit();
		
	}


</script>


<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script>

<script src="/ticketfactory/resources/js/menu.js"></script>
<script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script>


<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<title>faq 글본당</title>
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
				<!-- 왼쪽메뉴창 끝 -->
				
			<!-- 게시판부분 -->
			<div class="cs_content">
				<div class="cs_content_title">
					<p>
						<img src="/ticketfactory/resources/image/title_faq.png" style="padding:0 0 0 2px;">
					</p>
				</div>
		
				<center><div class="cs_content_bar"></div></center>

				<div style="width:750px; padding:15px 23px 0 23px;">


			<!-- 글작성 실제 부분 -->


		<div style="width:100%; padding:15px 0 23px;">

			<table cellpadding="0" cellspacing="0" width="750"">
				<tr>
					<td bgcolor="#F5F5F5" style="border:1px solid #dbdbdb; border-bottom:0px; ">
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td style="padding:10px 20px 10px 20px;width:600px;"><b><font color=#767676; style="font-size: 15px;">${dto.faqSubject }</b></td>
								<td align="right" style="padding:10px 20px;width:230px;">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td style="font-size:12px;">
											
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<div style="width:750px;" >
				<table width="750" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" style="border:1px solid #dbdbdb;">
					<tr>
						<td align="left"></td>
					</tr>
					<tr>
						<td style="line-height:19px;">
						<div style="padding:10px 20px;">
						<div class="notice_wrap" style="font-size: 13px;">  
						${dto.faqContent }
						</div>
		
						<center></center></div>
						
						</td>
					</tr>
				</table>
			</div>
	
		<c:if test="${sessionScope.adminId=='admin' }">
		<div style="margin: 15px 0px 5px 260px;">
			<input type="button" value=" 수정하기 " class="btn2" 
			onclick="javascript:location.href='<%=cp%>/faqUpdated.action?faqNum=${dto.faqNum}&pageNum=${pageNum}';"/>
			<input type="reset" value=" 삭제하기" class="btn2" 
			onclick="javascript:location.href='<%=cp%>/faqDeleted.action?faqNum=${dto.faqNum}&pageNum=${pageNum}';"/>
			<input type="button" value=" 리스트" class="btn2" 
			onclick="javascript:location.href='<%=cp%>/faqList.action?${params}';"/>	
		</div>
		</c:if>
		
		<c:if test="${empty sessionScope.adminId }">
		<div style="margin: 15px 260px 50px 310px;">
			<input type="button" value=" 리스트" class="btn2" 
			onclick="javascript:location.href='<%=cp%>/faqList.action?${params}';"/>
		</div>
		</c:if>
		
		

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