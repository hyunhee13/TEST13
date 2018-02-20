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

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="/ticketfactory/resources/js/jquery-1.11.3.min.js"></script>

<script src="/ticketfactory/resources/js/jquery-1.7.2.min.js"></script>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<script type="text/javascript">

//화면이 시작되면 데이터를 불러와서 출력
$(function(){
	
	listPage(1);
	
});

//등록하기 버튼을 클릭하면 실행
$(document).ready(function(){

	$("#send").click(function(){
		
		//alert("스벌탱111");
		
		var params = "ydcContent=" + $("#ydcContent").val() + 
					"&ydNum=" +  $("#ydNum").val();
		
		$.ajax({
			
			type:"POST",
			url:"<%=cp%>/ydcCreated.action",
			data:params,
			success:function(args){
				
				//listData에 args 뿌리기
				$("#listData").html(args);
				//Ajax는 새로고침을 하지않으므로 썼던 내용 지워버리기!
				$("#ydcContent").val("");
				
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
	var ydcContent = $.trim($("#ydcContent").val());
	
	if(!ydcContent){
		alert("내용을 입력해주세요.")
		$("#ydcContent").focus();
		return false;
	}
	
	if(ydcContent.length>200){
		alert("내용은 200자 까지만 가능합니다!")
		$("#ydcContent").focus();
		return false;
	}
	
	//반드시 적어줘야 한다 true 짱!
	return true;	
}

function showRequest2(){
	
	var name = $.trim($("#name").val());
	var ydcContent = $.trim($("#ydccContent").val());
	
	if(!ydcContent){
		alert("내용을 입력해주세요.")
		$("#ydccContent").focus();
		return false;
	}
	
	if(ydcContent.length>200){
		alert("내용은 200자 까지만 가능합니다!")
		$("#ydccContent").focus();
		return false;
	}
	
	//반드시 적어줘야 한다 true 짱!
	return true;	
}

function listPage(page){
	
	var url = "<%=cp%>/ydcList.action";
	var ydNum = $("#ydNum").val();
	var pageNum = $("#pageNum").val();
	
	$.post(url,{ydNum:ydNum,pageNum:page},function(args){
		
		$("#listData").html(args);
		
	});
	//none 상태니 보여라~!
	$("#listData").show();
	
}

function deleteData(num,ydcId,ydNum){
	
 	var userId = $("#userId").val();
	var ydcId = ydcId;
	

 	if(userId!=ydcId){
		
		alert("회원님이 쓴 글이 아닙니다.")
		return;	
	
	}
	
	var url = "<%=cp%>/ydcDeleted.action";

	//변수:값
	$.post(url,{ydcNum:num,ydcId:ydcId,ydNum:ydNum},function(args){
		
		$("#listData").html(args);
		
	});
	
}



//댓글숨길꾸얌
function reply(reNum){
	
	var params = "reNum=" + reNum;
	
	$.ajax({
			
			type:"POST",
			url:"<%=cp%>/yangdoReply.action",
			data:params,
			success:function(args){
				
				if($("#replymode" + reNum).css("display") == "block"){
					
					$("#replymode" + reNum).css("display","none");
					
				}else{
				/* 	
					$("#replaymode").css("display","block");
					 */
					
					$("#replymode" + reNum).show();
				}
		
			},
			
			error:function(e){
				alert(e.responseText);
			}
	
		});
	
}


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
				<p><a href="bbs_list.php?tb=talk_main"><span class="talk_menu_off">티켓톡 홈</span></a></p>
			</div>
			
			<div class="talk_menu_title_bar"></div>

				<div class="talk_menu_sub">
				<p><a href="<%=cp%>/eventList.action"><span class="talk_menu_on">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span></a>
				</p>
				
				<p><a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on">
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
		
		<div id="right_content">
			<div style="padding-bottom:30px;">
			
				<center>
					<table cellpadding="0" cellspacing="0" style="width:100%; background:#f8f8f8; border-bottom:1px solid #ccc;">
						<tr>
							<td style="padding:20px; width:70%">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tr>
										<td style="font-size:15px; text-align:left; padding-bottom:10px; ">
											<span style="color:red;">[${dto.ydType }]</span>
										</td>
										
										<td class="talk_detail_date">
											${dto.ydCreated}&nbsp;&nbsp;|&nbsp;&nbsp;조회수 <span style="color:#08a2cc;">${dto.ydHitCount}</span>
										</td>
									</tr>		
									
									<tr>
										<td class="talk_detail_title" style="font-size: 16px; font-weight: bold;">
											${dto.ydSubject }
										</td>
										
										<td class="talk_detail_date">
											${dto.ydIpAddr}
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

					<table border="0" cellspacing="0" cellpadding="0" style="width:95%;">
						<tr>
							<td style="padding:40px 10px 40px 10px;">
							${dto.ydContent }
							</td>
						</tr>
					</table>
					
					<input type="hidden" id="userId" value="${loginDto.userId}" name="userId">
		

					<!-- ajax 댓글등록 -->	
					<input type="hidden" id="ydNum" value="${dto.ydNum}" name="ydNum">
					
					<br/>
					<table border=0 width=100% cellpadding='0' cellspacing='0'>
						<tr>
							<td style='border:1px solid #e4e4e4; padding:10px;' bgcolor='#f8f8f8'>
								<table cellpadding=0 cellspacing=0 width='100%'>
									<tr>
										<td>
										<textarea name=short_comment maxlength=5000 id="ydcContent"
										style="font:12px '돋움'; width:99%; height:75px; 
										border:1px solid #e5e5e5; -webkit-border-radius:0; 
										-webkit-appearance:none;" ></textarea>
										</td>
										<td style="width:64px; padding-left:5px;">
										<input type="image" src="/ticketfactory/resources/image/memo_add.png" 
										style='width:80px;-webkit-border-radius:0; -webkit-appearance:none;'
										id="send">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<!-- 댓글등록창 끝 -->
					
					<!-- 댓글리스트 -->
					<span id="listData" style="display: none"></span>

					<table cellspacing="0" cellpadding="0" style="width:95%;">
						<tr>
							<td align="center" style="padding-right:10px;">	
							<c:if test="${loginDto.userId == dto.ydId }">
							
								<input type="button" value=" 수정하기 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/yangdoUpdated.action?ydNum=${dto.ydNum}&pageNum=${pageNum}';"/>
								
								<input type="button" value=" 삭제하기 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/yangdoDeleted.action?${params}&ydNum=${dto.ydNum}';"/>
								
								<input type="button" value=" 목록 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/yangdoList.action?${params}';"/>
								
							</c:if>
							<c:if test="${loginDto.userId != dto.ydId }">
								<input type="button" value=" 목록 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/yangdoList.action?${params}';"/>
							</c:if>
	
							</td>
						</tr>

					</table>

			</center>

			</div>
		</div>

	</div>
</div>
<br/><br/>
</body>
</html>