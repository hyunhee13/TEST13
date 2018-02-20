<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- <script type="text/javascript" src="//code.jquery.com/jquery-3.1.1.min.js"></script> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">

	function sendIt(){
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/eqList.action";
		f.submit();
		
	}
	
	function preCreate(){
		
		var f = document.createForm;
		f.action = "<%=cp%>/eqCreated.action";
		f.submit();
	}
	
	function loginCheck(eqNum,eqId){
		
		if('${sessionScope.adminId}'=='admin'){
			location.href='${articleUrl }'+"&eqNum="+eqNum;
			return;
		}

		 if('${loginDto.userId}'==""){
			alert("로그인이 필요한 페이지입니다.\n로그인 후 이용해주세요^^");
		}else if(eqId=='${loginDto.userId}'){
			location.href='${articleUrl }'+"&eqNum="+eqNum;
		}else{
			alert("본인 문의사항만 확인이 가능합니다. \n더 궁금하신 사항은 고객센터로 문의해주세요^^");
		}
	}

</script>


<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script> -->

<script src="/ticketfactory/resources/js/menu.js"></script>
<!-- <script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script> -->

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>


<title>슈비두바</title>
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
									<img src="/ticketfactory/resources/image/btn_faq_off.png" alt="자주묻는질문">
								</p>
							</div>
						
							<div class="cs_left_menu_sub1">
								<p onclick="idCheck();" style="cursor:pointer;">
									<img src="/ticketfactory/resources/image/btn_private_on.png" alt="일대일문의">
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
						<img src="/ticketfactory/resources/image/title_private.png" style="padding:0 0 0 2px;">
					</p>
				</div>
				
				<center><div class="cs_content_bar"></div></center>
			
			
			
			<div style="width:100%; padding:15px 23px 0 23px;">

			<table cellspacing="0" style="width:750px;">
			<tr>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_left.gif"></td>
				<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
					<table cellspacing="0" style="width:100%;">
					<tr>
						<td class="myTable" style="width:44px;" align="center">번호</td>
						<td class="myTable" align="center">제목</td>
						<td class="myTable" align="center" style="width:60px;">아이디</td>
						<td class="myTable" align="center" style="width:100px;">작성일</td>
						<td class="myTable" align="center" style="width:60px;">처리상태</td>
					</tr>
					</table>
				</td>
				<td style="width:3px;"><img src="/ticketfactory/resources/image/icon_table_right.gif"></td>
			</tr>
			</table>

			<!-- 게시판 -->
			<table cellpadding="0" cellspacing="0" width="750" bgcolor="#FFFFFF">
				<tr>
					<td>
						<table width=100% cellpadding=0 cellspacing=0  border=0>
							<tr>
								<td valign=top align=center>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
			
										<c:forEach var="dto" items="${lists}">
											<tr height="40" onmouseup="this.style.backgroundColor='#f7f7f7'"; 
											onmouseover="this.style.backgroundColor=''"; class="listCss">
												<td width="80" align="center">${dto.eqListNum }</td>
											  	<!--<td align="left" width="100"><font color="#FF6D01"></font></td>-->
											 		<td align="left" width="650">
											  
											 		 <!-- 문의내용 -->
													<span style="color:#777; font-size:11px;">
													[${dto.eqType }]
													</span>
													
													<a href='javascript:void(0);'onclick="loginCheck('${dto.eqNum}','${dto.eqId }');"> 
													<%-- <a href='${articleUrl }&eqNum=${dto.eqNum}'> --%>
													${dto.eqSubject }
													<c:if test="${dto.commentNum!=0 }">
													<font style="font-family: 맑은 고딕; color: blue; font-size: 11px;">(${dto.commentNum })</font>
													</c:if>
													</a>
																	
										  			</td>
													  <td width="200" align="right" style="padding-right:10px;">${dto.eqId }</td>
													  <td width="150" align="center">${dto.eqCreated }</font></td>
													  <td width="70" align="center">
														<c:if test="${dto.commentNum==0}">
													  	<img src=/ticketfactory/resources/image/stat_private_01.png border=0 align=absmiddle alt='접수대기'>
														</c:if>
														<c:if test="${dto.commentNum!=0}">
														<img src=/ticketfactory/resources/image/stat_private_03.png border=0 align=absmiddle alt='처리완료'>
														</c:if>
													  </td>
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
			
			<div style="width:100%; padding-top:30px; padding-bottom:30px; text-align:center;">
			
			<!-- 페이징처리 -->
			<div style="padding-right: 50px;">
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
								<input type="radio" name="searchKey" value="eqSubject" checked> 제목
								<input type="radio" name="searchKey" value="eqId"> 이름
								<input type="radio" name="searchKey" value="eqContent"> 내용		
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
						<div style="text-align:right; padding:1px 1px 15px 15px;" class="createBtn">
						<form action="" name="createForm" method="post">
						<img src='/ticketfactory/resources/image/btn_write.png' 
						border=0 height='40' alt='글쓰기' onclick="preCreate();" style="width: 65px; height: 35px;">
						</form></div>

					</td>
					</c:if>

				</tr>
			</table>


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