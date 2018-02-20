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


<script type="text/javascript">

//화면이 시작되면 데이터를 불러와서 출력
$(function(){
	
	listPage(1);
	
});

//등록하기 버튼을 클릭하면 실행
$(document).ready(function(){

	$("#sendButton").click(function(){
		
		var params = "eqcContent=" + $("#eqcContent").val() + 
					"&eqNum=" +  $("#eqNum").val();
		
		$.ajax({
			
			type:"POST",
			url:"<%=cp%>/eqcCreated.action",
			data:params,
			success:function(args){
				
				//listData에 args 뿌리기
				$("#listData").html(args);
				//Ajax는 새로고침을 하지않으므로 썼던 내용 지워버리기!
				$("#eqcContent").val("");
				
			},
			beforeSend:showRequest,
			error:function(e){
				alert(e.responseText);
			}
			
		});
		
	});
	
});

function showRequest(){
	
	var name = $.trim($("#name").val());
	var eqcContent = $.trim($("#eqcContent").val());
	
	if(!eqcContent){
		alert("내용을 입력해주세요.")
		$("#eqcContent").focus();
		return false;
	}
	
	if(eqcContent.length>200){
		alert("내용은 200자 까지만 가능합니다!")
		$("#eqcContent").focus();
		return false;
	}
	
	//반드시 적어줘야 한다 true 짱!
	return true;	
}

function listPage(page){
	
	var url = "<%=cp%>/eqcList.action";
	var eqNum = $("#eqNum").val();
	var pageNum = $("#pageNum").val();
	
	$.post(url,{eqNum:eqNum,pageNum:page},function(args){
		
		$("#listData").html(args);
		
	});
	//none 상태니 보여라~!
	$("#listData").show();
	
}

function deleteData(num,page,eqNum){
	
	var url = "<%=cp%>/eqcDeleted.action";
	
	//변수:값
	$.post(url,{eqcNum:num,pageNum:page,eqNum:eqNum},function(args){
		
		$("#listData").html(args);
		
	});
	
}

</script>


<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script> -->

<!-- <script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script> -->

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
			
				<div style="width:750px; padding:15px 23px 0 23px;">


		<table cellspacing='0' cellpadding='0' >
			<tr>
				<td style='padding:5px 10px; border:1px solid #dedede; font-size: 13px; font-weight: 600' bgcolor="#ffffff">

					<table cellspacing='0' cellpadding='0' border='0' width="728">

						<tr>
							<td>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class='smfont' height='30' width='80'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' 
										align='absmiddle'> 제목</td>
										<td><b>${dto.eqSubject }</b></td>
									</tr>
								</table>
							</td>
						</tr>

						<tr>
							<td height='1' bgcolor='#f2f2f2'></td>
						</tr>

						<tr>
							<td>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class='smfont' height='30' width='80'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' align='absmiddle'> 문의유형</td>
										<td width='190'>${dto.eqType }</td>
										<td class='smfont' height='30' width='70'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' align='absmiddle'> 문의상품</td>
										<td width='390'>${dto.eqProduct } &nbsp; </td>
									</tr>
								</table>
							</td>
						</tr>

						<tr>
							<td height='1' bgcolor='#f2f2f2'></td>
						</tr>

						<tr>
							<td>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class='smfont' height='30' width='80'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' align='absmiddle'> 작성시간</td>
										<td width='190'>${dto.eqCreated}</td>
										<td class='smfont' height='30' width='70'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' align='absmiddle'> 작성자 ID</td>
										<td width='190'>${dto.eqId }</td>
										<td class='smfont' height='30' width='70'>
										<img src='/ticketfactory/resources/image/detail_board_arrow_icon.gif' align='absmiddle'> 휴대폰번호</td>
										<td width='100'>${dto.eqTel }</td>

									</tr>
								</table>
							</td>
						</tr>

						<tr>
							<td height='1' bgcolor='#f2f2f2'></td>
						</tr>	
					
					</table>
					 
				</td>
			</tr>
		</table>
		
		<!-- 앙내용 -->
		<div  style="border:1px solid #dedede; margin-top:15px; width:748px; line-height:170%;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#FFFFFF" style="padding:5px 15px; font-size: 13px;">

						

						<div style="padding:3px;"></div>

						

						<div style="padding:3px;"></div>

						${dto.eqContent }
						
						
						<div style="padding:5px;"></div>

					</td>
				</tr>
			</table>
		</div>
		
		
		<!-- ajax 댓글등록 -->

	<input type="hidden" id="eqNum" value="${dto.eqNum}" name="eqNum">
		<c:if test="${loginDto.userId!='' }">
		<input type="hidden" id="eqId" value="${loginDto.userId}" name="eqId">
		</c:if>
		<c:if test="${loginDto.userId=='' }">
		<input type="hidden" id="eqId" value="${sessionScope.adminId}" name="eqId">
		</c:if> 
		
		<br/>
		
		<c:if test="${!empty sessionScope.adminId }">
		
		<table border=0 width=100% cellpadding='0' cellspacing='0'>
			<tr>
				<td style='border:1px solid #e4e4e4; padding:10px;' bgcolor='#f8f8f8'>
					<table cellpadding=0 cellspacing=0 width='100%'>
						<tr>
							<td>
							<textarea name=short_comment maxlength=5000 id="eqcContent"
							style="font:12px '돋움'; width:99%; height:75px; 
							border:1px solid #e5e5e5; -webkit-border-radius:0; 
							-webkit-appearance:none; padding-left: 5px; padding-top: 5px;" ></textarea>
							</td>
							<td style="width:64px; padding-left:5px;">
							<input type="image" src="/ticketfactory/resources/image/memo_add.png" 
							style='width:80px;-webkit-border-radius:0; -webkit-appearance:none;'
							id="sendButton">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		</c:if>
		

		<!-- 댓글등록창 끝 -->
		
		
		<!-- 댓글리스트 -->
		<span id="listData" style="display: none;"></span>
		
		<!-- 삭제 글보기 버튼 -->

				<div style="text-align:right; padding:15px 0px 20px 15px;" class="listBtn">
					<img src='/ticketfactory/resources/image/btn_delete.png' 
					border=0; style='height:40px; margin-left:3px;'
					onclick="javascript:location.href='<%=cp%>/eqDeleted.action?${params}&eqNum=${dto.eqNum}';">				
					<img src='/ticketfactory/resources/image/btn_list.png' 
					style='height:40px; padding-left:5px;' border=0;
					onclick="javascript:location.href='<%=cp%>/eqList.action?${params}';">	
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