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
		
		str = f.notiSubject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.notiSubject.focus();
			return;
		}
		f.notiSubject.value = str;
		
		str = f.notiContent.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.notiContent.focus();
			return;
		}
		f.notiContent.value = str;
		
		f.action = "<%=cp%>/notiUpdated_ok.action";
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

<title>공지사항 글쓰기</title>
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

						
						<div class="cs_left_menu_sub">
				
							<div class="cs_left_menu_sub1">
								<p onclick="javascript:location.href='<%=cp%>/notiList.action';" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_notice_on.png" alt="공지사항">
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
				
			<!-- 게시판부분 -->
			<div class="cs_content">
				<div class="cs_content_title">
					<p>
						<img src="/ticketfactory/resources/image/title_notice.png" style="padding:0 0 0 2px;">
					</p>
				</div>
		
				<center><div class="cs_content_bar"></div></center>

				<div style="width:750px; padding:15px 23px 0 23px;">


			<!-- 글작성 실제 부분 -->


		<form action="" name="myForm" method="post">

		<table width="100%"  bgcolor="#f9f9f9" cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
			  <td>
				<table width="100%" cellpadding="0" cellspacing="0">
				
					<tr style="border:1px solid #dedede; height:40px;">
						<td style="width:100px; background-color:#f1f1f1; 
						padding-left:10px; color:#5e5e5e;" class="smfont4">제목</td>				
						<td style="padding:5px 0 5px 10px;">
						<input name='notiSubject' value="${dto.notiSubject}" type='text' class="input_New" 
						maxlength="100" style="width:580px;">	
						</td>
					</tr>
					
					<tr style="border:1px solid #dedede; height:40px;">
						<td style="width:100px; background-color:#f1f1f1; 
						padding-left:10px; color:#5e5e5e;" class="smfont4">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>				
						<td style="padding:5px 0 5px 10px;">
						<textarea name="notiContent" style="height: 183px; 
						width: 580px; padding-left: 7px; padding-top: 5px;">${dto.notiContent }</textarea></td>
					</tr>

				</table>
			  </td>
			</tr>
		</table>
	
		<div style="margin: 15px 0px 5px 260px;">
		
		<input type="hidden" name="notiNum" value="${dto.notiNum }"/>
		<input type="hidden" name="pageNum" value="${pageNum }"/>
		
			<input type="button" value=" 수정하기 " class="btn2" 
			onclick="sendIt();"/>
			<input type="button" value=" 수정취소 " class="btn2" 
			onclick="javascript:location.href='<%=cp%>/notiList.action';"/>	
		</div>
		
		</form>

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