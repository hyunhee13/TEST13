<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/ticketfactory/resources/css/admin.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/adminOneplus.css" type="text/css"/>

<script type="text/javascript" src="/ticketfactory/resources/js/modal.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>

<script type="text/javascript">

	function manage() {
	
		
		var num = $("select[name=manage]").val();
		
		
		var post = "";
		var url = "admin0" + num + ".action";
		var params = "pageNum=" + '${pageNum}';
		
		
		$.ajax({
			type: "post",
			url : url,
			data : params,
			success:function(page) {
				document.getElementById("selectBoxInfo").innerHTML = page;
			}
		});
		
		if(num==5){
			//alert("1+1 온로드!!");

		}
	}
	
	function oneplusReload(state,genre){
		var url="admin05.action";
		var params = "genre=" + genre;
		params += "&state=" + state;
		
		$.ajax({
			type: "post",
			url : url,
			data : params,
			success:function(page) {
				document.getElementById("selectBoxInfo").innerHTML = page;
			}
		});
	}
</script>


<script type="text/javascript">

	function popUp(state,genre){
		var check = document.f.oneplusCheck;
		
		var param = "selected=";
		for(var i=0;i<check.length;i++){
			if(check[i].checked){
				param += check[i].value+" ";
			}
		}
		param += "&state=" + state;
		param += "&genre=" + genre;

		window.open("oneplusPopUp.action?"+param, "1+1이벤트티켓 추가", 
				"width=450, height=450, toolbar=no, location=no, menubar=no, scrollbars=no, resizable=no, status=no, copyhistory=no, left=1, top=275" );  
	}
	
	function kind(genre,state,page){

		
		var params = "";
		if(page==null){
			params += "genre="+genre+"&state="+state;
		}else{
			params += "genre="+genre+"&state="+state +"&pageNum=" + page;
		}
		
		var url = "admin05.action";
		
		$.ajax({
			type: "post",
			url : url,
			data : params,
			success:function(page) {
				document.getElementById("selectBoxInfo").innerHTML = page;
			}
		});
		
	}

</script>


</head>
<body bgcolor="#eeeeee" onload="manage()">

<div id="AdminBg">

	<p class="title01">관리자 화면</p>
	
		<select class="manageSelectBox" name="manage" onchange="manage()">
			<option value="1">많이예매한연극순</option>
			<option value="2">많이예매한회원순</option>
			<option value="3">회원등급순</option>
			<option value="4">회원관리</option>
			<option value="5">1+1이벤트</option>
		</select>
	
	
	<div class="line01"></div>
	
	<div id="selectBoxInfo">
		
	</div>

</div> <!-- AdminBg DIV... end -->



</body>
</html>