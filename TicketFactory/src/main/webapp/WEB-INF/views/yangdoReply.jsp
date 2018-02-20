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

$("#sendButton"+${dto.ydcNum}).click(function(){

	var ydcNum = ${dto.ydcNum };

	var ydcc = $("#ydcContent" + ydcNum).val();
	var ydn = $("#ydNum").val();

	
	if(!ydcc){
		alert("내용을 입력해주세요.")
		$("#ydcContent"+ ydcNum).focus();
		return false;
	}
	
	if(ydcc.length>200){
		alert("내용은 200자 까지만 가능합니다!")
		$("#ydcContent" + ydcNum).focus();
		return false;
	}
	
 	/*  alert(ydcc + "ydcContent" ); */
/* 	alert(ydn + "ydNum");
	alert(ydcNum + "ydcNum"); */
	
	var params = "ydcContent=" + ydcc + 
				"&ydNum=" +  ydn +
				"&ydcNum=" +  ydcNum;


	$.ajax({
		
		type:"POST",
		url:"<%=cp%>/ydcReply_ok.action",
		data:params,
		success:function(args){
			
			//listData에 args 뿌리기
			$("#listData").html(args);
			//Ajax는 새로고침을 하지않으므로 썼던 내용 지워버리기!
			$("#ydcContent" + ydcNum).val("");
			
		},
	 	/* beforeSend:showRequest2, */
		error:function(e){
			alert(e.responseText);
		}
		
	});
	
});


/* function showRequest2(){
	
	var ydcNum = ${dto.ydcNum };
	var ydcContent = $("#ydcContent" + ydcNum).val();
	var name = $.trim($("#name").val());

	alert(ydcNum);
	alert(ydcContent);
	
	if(!ydcContent){
		alert("내용을 입력해주세요.")
		$("#ydcContent"+ ydcNum).focus();
		return false;
	}
	
	if(ydcContent.length>200){
		alert("내용은 200자 까지만 가능합니다!")
		$("#ydcContent" + ydcNum).focus();
		return false;
	}
	
	//반드시 적어줘야 한다 true 짱!
	return true;	
}
 */


</script>


</head>
<body>

<%-- 				<table border=0 width=100% cellpadding='0' cellspacing='0'>
						<tr>
							<td style="border:1px solid #e4e4e4; padding:10px;" bgcolor="#f8f8f8">
								<table cellpadding=0 cellspacing=0 width='80%'>
									<tr>
										<td>
										<textarea name=short_comment maxlength="5000"; id="ydcContent${dto.ydcNum }"
										style="font:12px; width:99%; height:75px; 
										border:1px solid #e5e5e5; -webkit-border-radius:0; 
										-webkit-appearance:none;" ></textarea>
										</td>
										<td style="width:64px; padding-left:5px;">
										<input type="image" src="/ticketfactory/resources/image/memo_add.png" 
										style='width:80px;-webkit-border-radius:0; -webkit-appearance:none;'
										id="sendButton${dto.ydcNum }">
										
										
										<input type="hidden" id="ydcNum" value="${dto.ydcNum }">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table> --%>
					
					<table border=0 width=100% cellpadding='0' cellspacing='0'>
						<tr>
							<td style="border:1px solid #e4e4e4; padding:10px;" bgcolor="#f8f8f8">
								<table cellpadding=0 cellspacing=0 width='95%'>
									<tr>
									<td style="padding-bottom: 50px; width: 35px; color: #000000; font-size: 15px;">
									 &nbsp;&nbsp;&nbsp;└
									</td>
										<td>
										<textarea name=short_comment maxlength="5000"; id="ydcContent${dto.ydcNum }"
										style="font:12px; width:99%; height:75px; 
										border:1px solid #e5e5e5; -webkit-border-radius:0; 
										-webkit-appearance:none;" ></textarea>
										</td>
										<td style="width:64px; padding-left:5px;">
										<input type="image" src="/ticketfactory/resources/image/memo_add.png" 
										style='width:80px;-webkit-border-radius:0; -webkit-appearance:none;'
										id="sendButton${dto.ydcNum }">

										<input type="hidden" id="ydcNum" value="${dto.ydcNum }">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>


</body>
</html>