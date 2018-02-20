<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<c:url value="/resources/js/ajax.js"/>"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/util.js"></script>
<script type="text/javascript" src="/ticketfactory/resources/js/sign_checker.js"></script>
	
<link rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"
	type="text/css" />
<style type="text/css">

#choose_play:HOVER {
	/* border: 1px solid #FF007F; */
	background-color: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">

function spread_playName(num) {
	
	f = document.price_Form;
	
	var groupName=f.groupName.value;
	var groupBookEmail=f.groupBookEmail.value;
	var groupBookTel=f.groupBookTel.value;
	var showId = $("#showIdModal"+num).val();
	var showName = $("#showNameModal"+num).val();
	
	f.showId.value = showId;
	f.groupShowName.value = showName;
	f.groupName.value = groupName;
	f.groupBookEmail.value = groupBookEmail;
	f.groupBookTel.value = groupBookTel;
	
	var params = "showId=" +showId;
	
	$.ajax({
	  	  type:"post",
		  url:"setDate.action",
		  dataType:"html",
		  data:params,
		  success:function(time){
	
			  if(time!=null){
				  $("#dateDIV").html(time);              
	           }
			  
			  $("#searchPlayModal").hide();
			  
			  
		  },
		  error:function(e){
				alert(e.responseText);
			}
	  });
	
	
}

function sendItGroup() {
	
	f = document.price_Form;

	str = f.groupName.value;
	str = str.trim();
	if(!str){
		alert("\n담당자이름을 입력하세요.");
		f.groupName.focus();
		return;
	}
	f.groupName.value = str;
	

	str = f.groupShowName.value;
	str = str.trim();
	if(!str){
		alert("\n연극이름을 입력하세요.");
		f.groupShowName.focus();
		return;
	}
	f.groupShowName.value = str;
	
	var dayOption = document.getElementById("selectDate");
	if(dayOption.selectedIndex == 0){
		alert("날짜부터 선택해주세요.");
		dayOption.focus();
		return ;
	}
	
	var price_option = document.getElementById("selectTime");
	
	if(price_option.selectedIndex == 0){
		alert("시간을 선택해주세요");
		return;
	}
	
	str = f.groupBookEmail1.value;
	if(!str){
		alert("\n Email을 입력하세요.");
		f.groupBookEmail1.focus();
		return;
	}
	
	str = f.groupBookEmail2.value;
	if(!str){
		alert("\n Email을 입력하세요.");
		f.groupBookEmail2.focus();
		return;
	}
	
	str = f.groupBookEmail1.value + "@";
	str += f.groupBookEmail2.value;
	str = str.trim();
	
	if(str){
	
	if(!isValidEmail(str)){
		alert("\n정상적인 E-Mail을 입력하세요.");
		f.groupBookEmail1.focus();
		return;
		}
	}
	f.groupBookEmail.value = str;
	
	str = f.groupBookTel.value;
	str = str.trim();
	if(!str){
		alert("\n전화번호를 입력하세요.");
		f.groupBookTel.focus();
		return;
	}	
	f.groupBookTel.value = str;
	
	f.action = "<%=cp%>/mail.action";
	f.submit();
	
}

</script>
<script type="text/javascript">

function check_price() {
	
	f = document.price_Form;
	var price = f.groupBookPrice.value;

	
	if(!price){
		alert("선택되어진 연극이 없습니다.");
		document.getElementById("selectTime").focus();
		return;
	}
	
}

function check_priceAll(discount) {

	var discountOption = document.getElementById("selectDiscount");
	if(discountOption.selectedIndex == 0){
		alert("할인율을 선택해주세요.");
		discountOption.focus();
		return ;
	}
	
	f = document.price_Form;
	var price = f.hiddenTotal_Price.value;
	
	if(discountOption.selectedIndex == 1){
		
		f.groupBookPrice.value = price;
		discountOption.focus();
		return ;
	}
	


	
	var selectDiscount = $("#selectDiscount").find(":selected").val();
	selectDiscount = 1-(selectDiscount*0.01);
	
	price = parseInt(price * selectDiscount);
	
	f.groupBookPrice.value = price;
	
	
	

}


function all_check() {
	
	var dayOption = document.getElementById("selectDate");
	if(dayOption.selectedIndex == 0){
		alert("날짜부터 선택해주세요.");
		dayOption.focus();
		return ;
	}
	
	var price_option = document.getElementById("selectTime");
	
	if(price_option.selectedIndex == 0){
		alert("시간을 선택해주세요");
		price_option.focus();
		return;
	}
	
	
	
}

function check_play() {
	f = document.price_Form;
	var showName=f.groupShowName.value;
	
	
	if(!showName){
		alert("연극부터 선택해주세요.");
		f.focus();
		return;
	}
}

function check(){
	
	var dayOption = document.getElementById("selectDate");

	if(dayOption.selectedIndex == 0){
		alert("날짜부터 선택해주세요.");
		dayOption.focus();
		return;
	}
}

function calcPrice(obj){
	
	var price_option = document.getElementById("selectTime");
	
	if(price_option.selectedIndex == 0){
		alert("시간을 선택해주세요");
		return;
	}
	
	
	var count = document.price_Form.count.value;
	
	
	var selectDate = $("#selectDate").find(":selected").val();
	var dateInfo = selectDate.split(",");
	var date = dateInfo[0];
	var day = dateInfo[1];

 	
	var buyInfo = obj.split(",");
	
	var time = buyInfo[0];
	
	var seat = buyInfo[1];

	var price = buyInfo[2];
	
	var capacity_num = buyInfo[3];
	
	var seat_num = buyInfo[4];
	
	for(var i = 0; i<count; i++){
		
	if(time==$("#showTime"+i).val()&&seat==$("#seat"+i).val()&&date==$("#bookDate"+i).val()){
		
		return;
	}
	
	
	}
	
	
	
	var params = "date=" + date +"&day=" + day + "&time=" + time + "&seat=" + seat
	             +"&price=" + price + "&count=" + count + "&capacity_num=" + capacity_num
	             + "&seat_num=" + seat_num;
	
	$.ajax({
			
			type:"POST",
			url:"<%=cp%>/makeDiv.action",
			data:params,
			success:function(args){
				
				var addedFormDiv =document.getElementById("price_options_value");
				
				var input = document.getElementsByTagName("INPUT");
				var option = document.getElementsByTagName("OPTION");
				var i;
				for(i = 0; i<input.length;i++) {
				   input[i].defaultValue = input[i].value;
				   if(input[i].checked != input[i].defaultChecked) {
				       input[i].defaultChecked = input[i].checked;
				   }
				}
				for(i = 0; i<option.length;i++) {
				   option[i].defaultSelected = option[i].selected;
				}
				
				/* addedFormDiv.appendChild(args); */
				
				addedFormDiv.innerHTML = addedFormDiv.innerHTML +args; 
				
				 count++;
		 		
				 document.price_Form.count.value=count;
				
				totalPrice();
				
				
				$("#reservation_num").css("display","table-row");
				
				 
			},
			
			error:function(e){
				alert(e.responseText);
			}
			
			
		});

	 
} 

function delForm(count){
	
	var hiddenCount = document.price_Form.count.value;
	var addedFormDiv =document.getElementById('price_options_value');
	var divide = 0;
	
 	  for(var i = 0; i<hiddenCount; i++){
		
		var price_option =  document.getElementById("price_option_"+i);
		
		var price_option_id = $("#price_option_"+i).attr("id"); 

		
		 if(price_option_id == "price_option_"+count){
			
			addedFormDiv.removeChild(price_option);
			divide++;
			document.price_Form.count.value = hiddenCount-1;
	
			
		} else{
			 if(divide==0){
				$("#price_option_"+i).attr("id","price_option_"+i);
				$("#delete_btn"+i).attr("onclick","delForm(" + i + ")");
				$("#plus"+i).attr("onclick","quantity_plus(" + i + ")");
				$("#minus"+i).attr("onclick","quantity_minus(" + i + ")");
				$("#onblur_quantity"+i).attr("onclick","onblur_quantity(" + i + ")");
				
				$("#fixedPrice"+i).attr("name","fixedPrice"+i);
				$("#fixedCapacity_num"+i).attr("name","fixedCapacity_num"+i);
				$("#bookDate"+i).attr("name","bookDate"+i);
				$("#showTime"+i).attr("name","showTime"+i);
				$("#seat"+i).attr("name","seat"+i);
				$("#bookPrice"+i).attr("name","bookPrice"+i);
				$("#bookSu"+i).attr("name","bookSu"+i);
				$("#bookPrice_show"+i).attr("name","bookPrice_show"+i);
				$("#plus"+i).attr("name","plus"+i);
				$("#minus"+i).attr("name","minus"+i);
				$("#capacity_num"+i).attr("name","capacity_num"+i);
				$("#seat_num"+i).attr("name","seat_num"+i);
				
				$("#delete_btn"+i).attr("id","delete_btn"+i);
				$("#fixedPrice"+i).attr("id","fixedPrice"+i);
				$("#fixedCapacity_num"+i).attr("id","fixedCapacity_num"+i);
				$("#bookDate"+i).attr("id","bookDate"+i);
				$("#showTime"+i).attr("id","showTime"+i);
				$("#seat"+i).attr("id","seat"+i);
				$("#bookPrice"+i).attr("id","bookPrice"+i);
				$("#bookSu"+i).attr("id","bookSu"+i);
				$("#bookPrice_show"+i).attr("id","bookPrice_show"+i);
				$("#plus"+i).attr("id","plus"+i);
				$("#minus"+i).attr("id","minus"+i);
				$("#capacity_num"+i).attr("id","capacity_num"+i);
				$("#seat_num"+i).attr("id","seat_num"+i);
				
				
			
				
				
	
			

			}else{
				$("#price_option_"+i).attr("id","price_option_"+(i-1));
				$("#delete_btn"+i).attr("onclick","delForm(" +(i-1) + ")");
				$("#plus"+i).attr("onclick","quantity_plus(" + (i-1) + ")");
				$("#minus"+i).attr("onclick","quantity_minus(" + (i-1) + ")");
				$("#onblur_quantity"+i).attr("onclick","onblur_quantity(" + (i-1) + ")");
				
				
				$("#fixedPrice"+i).attr("name","fixedPrice"+(i-1));
				$("#fixedCapacity_num"+i).attr("name","fixedCapacity_num"+(i-1));
				$("#bookDate"+i).attr("name","bookDate"+(i-1));
				$("#showTime"+i).attr("name","showTime"+(i-1));
				$("#seat"+i).attr("name","seat"+(i-1));
				$("#bookPrice"+i).attr("name","bookPrice"+(i-1));
				$("#bookSu"+i).attr("name","bookSu"+(i-1));
				$("#bookPrice_show"+i).attr("name","bookPrice_show"+(i-1));
				$("#plus"+i).attr("name","plus"+(i-1));
				$("#minus"+i).attr("name","minus"+(i-1));
				$("#capacity_num"+i).attr("name","capacity_num"+(i-1));
				$("#seat_num"+i).attr("name","seat_num"+(i-1));
				
				$("#delete_btn"+i).attr("id","delete_btn"+(i-1));
				$("#fixedPrice"+i).attr("id","fixedPrice"+(i-1));
				$("#fixedCapacity_num"+i).attr("id","fixedCapacity_num"+(i-1));
				$("#bookDate"+i).attr("id","bookDate"+(i-1));
				$("#showTime"+i).attr("id","showTime"+(i-1));
				$("#seat"+i).attr("id","seat"+(i-1));
				$("#bookPrice"+i).attr("id","bookPrice"+(i-1));
				$("#bookSu"+i).attr("id","bookSu"+(i-1));
				$("#bookPrice_show"+i).attr("id","bookPrice_show"+(i-1));
				$("#plus"+i).attr("id","plus"+(i-1));
				$("#minus"+i).attr("id","minus"+(i-1));
				$("#capacity_num"+i).attr("id","capacity_num"+(i-1));
				$("#seat_num"+i).attr("id","seat_num"+(i-1));
		
				
				
		
			} 
	
		} 
 
	} 
 	  
 		if(document.price_Form.count.value == 0){
 			
	 		  $("#total_price").css("display", "none");
 			$("#reservation_num").css("display", "none");
 			var price_option = document.getElementById("selectTime");
 			price_option.selectedIndex = 0;
	 		  
	 	  }else{
	 		  
	 		 totalPrice();
	 	  }
 	  
 	
}

function onblur_quantity(count) {
	
	
	var bookSu = $("#bookSu"+count).val();
	
	if( bookSu <=1)
		return;
	
	var fixedCapacity_num =  $("#fixedCapacity_num"+count).val();

	if( Number(bookSu) >= Number(fixedCapacity_num) )
		return;
	
	var price = $("#fixedPrice"+count).val() *bookSu;
	
	$("#bookSu"+count).val(bookSu);
	$("#bookPrice"+count).val(price);
	document.getElementById("bookPrice_show"+count).innerHTML = price + "원";
	
	totalPrice();
	
}

function quantity_minus(count) {
	
	var minusBookSu = $("#bookSu"+count).val();
	
	if( minusBookSu <=1)
		return;
	
	
	
	
	minusBookSu = minusBookSu - 1;
	var price = $("#fixedPrice"+count).val() * minusBookSu;
	
	$("#bookSu"+count).val(minusBookSu);
	$("#bookPrice"+count).val(price);
	document.getElementById("bookPrice_show"+count).innerHTML = price + "원";
	
	totalPrice();
	
}

function quantity_plus(count) {
	
	var plusBookSu = $("#bookSu"+count).val();
	var fixedCapacity_num =  $("#fixedCapacity_num"+count).val();

	if( Number(plusBookSu) >= Number(fixedCapacity_num) )
		return;

	plusBookSu =  Number(plusBookSu) + 1;
	
	var price = $("#fixedPrice"+count).val() *  plusBookSu;
	
	$("#bookSu"+count).val(plusBookSu);
	$("#bookPrice"+count).val(price);
	document.getElementById("bookPrice_show"+count).innerHTML= price + "원";

	totalPrice();
	
	
}

function totalPrice() {
	
	var count = document.price_Form.count.value ;
	
	var total_price = Number(0);
	for(var i = 0; i<count; i++){
		
		
		  total_price += Number($("#bookPrice"+i).val()); 
		
		
	}
	
	$("#groupBookPrice").val(total_price);
	$("#hiddenTotal_Price").val(total_price);
	
	$("#total_price").css("display", "block");
	
}
	

</script>
</head>
<body>

<form action="" name="price_Form" method="post">
<div id="session" style="height: auto; ">
	
	<div style="margin-left: 21px; margin-top: 10px; 
	float: left; color: #313131; 
	font-size:16px; font-weight:bold;">단체예약처리</div>
	<div style="margin-left:165px; margin-top: 12px; margin-bottom:15px;
	float: left; font-size: 12px; text-align: left; color: #313131;">
	* 필수 입력항목 (연극을 먼저 골라야 시간/날짜가 나옵니다.)</div>

<!-- 입력창  -->

<table cellpadding="0" cellspacing="0">

<tr>
	<td>담당자이름* </td>
	<td><input type="text" name="groupName" id="groupName" ><br/>
	<!-- 아작스부분(아이디 중복확인) -->
	
	</td>
</tr>	
<tr>
	<td>연극이름* </td>
	<td>
	<input type="text" name="groupShowName" id="groupShowName" 
	style="padding: 4px; width: 300px">
	<input type="hidden" name="showId" id="showId">
	<input type="button" id="search_play" 
	value="검색" style="width: 40px; height: 26px;">
	</td>
</tr>
<tr>
	<td>날짜* </td>
	<td>
	<div id="dateDIV">
	<select id="selectDate"
		onchange="changeTime(this.value,'${showId }')"
		onclick="check_play()">
		<option value="">날짜선택</option>
		<c:forEach var="date" items="${date }">
			<option value="${date.showDate },${date.showDay}">${date.showDate }[${date.showDay }]</option>
		</c:forEach>
	</select>
	</div>
	</td>
</tr>
<tr>
	<td>좌석 및 시간* </td>
	<td>
		<div id="timeDIV">
			<select onclick="check()">
				<option>시간선택</option>
			</select>
		</div>
	</td>
</tr>	
<tr style="display: none;" id="reservation_num">
	<td>예매 수* </td>
	<td>
	
	<div class="price_sum" style="border-top: 0px;">
		<div id="price_options_value" ></div>
		
		<div class="btn_area">
		<div class="lineup" style="float: right;">
			<!-- <a><img src="resources/image/btn_cart.png" alt="장바구니" /></a> -->
		</div>
	</div>
	</div>
	<input type="hidden" name="count" value="0">
	
	</td>
</tr>
<tr>
	<td>총 금액* </td>
	<td>
	<input type="text" name="groupBookPrice" id="groupBookPrice" readonly="readonly">
	<input type="hidden" name="hiddenTotal_Price" id="hiddenTotal_Price">
	<select id="selectDiscount"
		onchange="check_priceAll(this.value)"
		onclick="check_price(this.value)">
		<option value="">할인율</option>
		<option value="">할인전</option>
			<option value="40">40</option>
			<option value="45">45</option>
			<option value="50">50</option>
			<option value="55">55</option>
			<option value="60">60</option>	
	</select>
	</td>
</tr>

<tr>
	<td>이메일* </td>
	<td><input type="text" name="groupBookEmail1" >
	<label style="font-size: 10pt; color : #5D5D5D;
	font-family: 맑은 고딕; ">@</label>
	<input type="text" name="groupBookEmail2" disabled="disabled" >
	<select name="emailchk" onchange="email_input_group()" class="selectbox" style="height: 20px;" >
		<option value="0">선택하세요</option>
		<option value="9">직접입력</option>
		<option value="hanmail.net">hanmail.net</option>
		<option value="naver.com">naver.com</option>
		<option value="daum.net">daum.net</option>
		<option value="nate.com">nate.com</option>
		<option value="gmail.com">gmail.com</option>	
	</select>
	<input type="hidden" name="groupBookEmail" ><!-- 넘길때 받을 진짜 값  -->
	</td>
</tr>

<tr>
	<td>전화번호* </td>
	<td><input type="text" name="groupBookTel"
	onkeypress="return isNumberKey(event)" style="ime-mode:disabled;">
	<span style="width: 150pt; color: #FF007F; font-size: 9pt;">
	숫자만 입력해주세요.
	</span>
	</td>
</tr>

</table><!-- 회원가입창끝 -->

<!-- 약관동의와 가입버튼 -->
	<div alt="약관동의" align="center" style="width:85%; margin:40px auto; padding-bottom: 125px;"">
	
		<div alt="가입버튼" style="text-align:center; margin:30px 0 50px 0;">
			<a href="javascript:sendItGroup();" >
			<input type="hidden" name="mode" value="sign">
			<img src="/ticketfactory/resources/image/btn_join_ok.png">
		</a>
		</div>
		
	</div>
</div>
</form><!-- 폼의 마지막 --><!-- 약관동의와 가입버튼끝 -->



</body>
</html>