<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
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
<!-- 지도------------------------------------------------------------------------------------------------------------------ -->
 <style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 55px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
<!-- 지도------------------------------------------------------------------------------------------------------------------ -->


<%-- <script type="text/javascript"
	src="<c:url value="/resources/js/jquery-3.1.1.min.js"/>"></script> --%>
<script type="text/javascript"
	src="<c:url value="/resources/js/ajax.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/detail2.css"/>"
	type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"
	type="text/css" />
<link rel="stylesheet" href="<c:url value="/resources/css/top.css"/>"
type="text/css" />



<script type="text/javascript">

	function sendItQnaReply(){
		
		
		f = document.qnaForm;
		
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n작성자를 입력하세요.");
			f.name.focus();
			return;
		}			
			
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		

		f.action = "created_okQnaReply.action";
		
		f.submit();
	
	}
</script>


<script type="text/javascript">

	function sendItQa(){
		
		f = document.qnaForm;
					
		str = f.userIdQna.value;
		str = str.trim();
		if(!str){
			alert("\n로그인을 먼저 해주세요.");
			f.userIdQna.focus();
			return;
		}			
			
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		f.action = "created_okQA.action";
		f.submit();
	
	}
</script>


<script type="text/javascript">
	function sendIt(){
		
		f = document.myForm;
			
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.name.focus();
			return;
		}		
		
		f.name.value = str;
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		
		f.action = "created_ok.action";
		f.submit();
		
	}
</script>


<script type="text/javascript">
	function sendReview(){
		
		f = document.myForm;
			
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.name.focus();
			return;
		}		
		
		f.name.value = str;
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
	
		
		f.action = "updated_ok.action";
		f.submit();
		
	}
</script>


<script type="text/javascript">

function all_check() {
	
	
	var userId = document.price_Form.userId.value;
	if(!userId){
		alert("로그인해주세요");
		document.price_Form.userId.focus();
		return;
	}
	
	var dayOption = document.getElementById("selectDate");
	if(dayOption.selectedIndex == 0){
		alert("날짜부터 선택해주세요.");
		dayOption.focus();
		return;
	}
	
	var price_option = document.getElementById("selectTime");
	var count = document.price_Form.count.value;
	if(price_option.selectedIndex == 0){
		alert("시간을 선택해주세요");
		return;
	}
	
	
	document.price_Form.action = "book.action?showId="+'${showId}';
	document.price_Form.submit();
	
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
	var count = document.price_Form.count.value;
	if(price_option.selectedIndex == 0){
		alert("시간을 선택해주세요");
		return;
	}
	
	
	
	
	
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
	             +"&price=" + price + "&count=" + count + "&capacity_num=" + capacity_num  + "&seat_num=" + seat_num;
	
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
	 		  
	 	  }else{
	 		  
	 		 totalPrice();
	 	  }
 	  
 	
}




function onblur_quantity(count) {
	
	
	var bookSu = $("#bookSu"+count).val();
	//alert(bookSu);
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
	
	document.getElementById("show_total_price").innerHTML=total_price + "원";
	$("#total_priceWon").val(total_price);
	$("#total_price").css("display", "block");
	
}
	

</script>





</head>
 
<body onload="changeView('${url }','${sessionScope.showId}');">
<!-- <div id="map" style="width:400px;height:400px;"></div>
<script>
  var map = new naver.maps.Map('map', {center: new naver.maps.LatLng(37.3595704, 127.105399)});
</script> -->
<!-- -----------------------------------------------상단부----------------------------------------------------- -->


<!-- -------------------------------------------------------------------------------------------------------- -->



<!-- --------------------------------------------요약 예약 정보-------------------------------------------- -->

<%-- 	<div class="mL40"
		style="margin: 4px 0px 0px 0px; font-size: 12px; font-family: 굴림; LETTER-SPACING: -1px;">
		<h1>[뮤지컬] ${show.showName }</h1>
	</div>
	<div class="sub_img_text">
		<div class="detile_place">
			<em class="pR15"><strong>장소</strong> : <a href="#map_tab"><strong>북촌아트홀</strong>
					- 약도</a></em> <strong>문의</strong> : 티켓팩토리 <strong>☎ 031-123-4567</strong>
		</div>
		<div class="detile_time">
			<strong>시간</strong> :
			<time itemprop="startDate" datetime="2017-02-10 00:00:00"></time>
			<time itemprop="endDate" datetime="2017-02-28 23:59:59"></time>
		</div>
	</div>--%>


<%-- 	<br />
	<br /> --%>
<%-- 	<div> 
	<a href="<%=cp %>"><input type="button" value="메인"></a>
	</div>  --%>

<!-- ------------------------------------------------------------------------------------------------------- -->


<!-- --------------------------------------------상세 예약 정보-------------------------------------------- -->
	<!-- 상품기본정보 박스 -->
	
		<div class="item_view">

			<!-- 할인률 표시 -->
			<!--<div class="discount">                      
				<span class="lineup"><b>63</b><em>%</em></span>
			</div> -->
		
			<!-- ////////////////////////////상품사진/////////////////////// -->
			<div class="photo_box">
				
				<!-- 아이콘 -->
				
				
				<!-- 제품사진 -->
				<div class="large">
				<c:if test="${!empty show.event }">
													<div style="position:relative; z-index:0; width:100%;" align="right">
													<div style="position:absolute; width:100%; top:3px; right:4px;;">
													<div class="circle1">1+1</div>
													</div>
													</div></c:if>
				<img src="${show.showPoster }" alt=""/ width="450px;" height="500px;"></div><br/>
				
				
				<div class="map-preview">지도에서 미리 확인하세요</div>
				<div>---------------------------------------------------------------</div>
			


			<!-- ---------------------------------------------다음 지도 시작------------------------------------------ -->
				<div id="daum" style="width: 530px; height: 250px; float: none; padding-left: 10px;"></div>
				
				
					<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3dd48a93570f06a3824c36a46e7be97f"></script>
					
					<script type="text/javascript">
					var mapContainer = document.getElementById('daum'), 
				    mapOption = { 
				        center: new daum.maps.LatLng(${place.placeLa}, ${place.placeLo}),
				        level: 5
				    }; 

				var map = new daum.maps.Map(mapContainer, mapOption); 

		
				var marker = new daum.maps.Marker({
				    map: map, 
				    position: new daum.maps.LatLng(${place.placeLa}, ${place.placeLo})
				});


				var content = '<div class="wrap">' + 
				            '    <div class="info">' + 
				            '        <div class="title">' + 
				            '            ${show.showName}' + 
				            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
				            '        </div>' + 
				            '        <div class="body">' + 
				            '            <div class="img">' +
				            '                <img src="resources/image/ticket.JPG" width="73" height="50">' +
				            '           </div>' + 
				            '            <div class="desc">' + 
				            '                <div class="ellipsis">${place.placeAddr}</div>' + 
				            '				 <div>${place.placeTel}</div>' +
				            '                <div><a href="${place.placeUrl}">홈페이지</a></div>' + 
				            '            </div>' + 
				            '        </div>' + 
				            '    </div>' +    
				            '</div>';


				var overlay = new daum.maps.CustomOverlay({
				    content: content,
				    map: map,
				    position: marker.getPosition()       
				});


				daum.maps.event.addListener(marker, 'click', function() {
				    overlay.setMap(map);
				});
				
				
				var mapTypeControl = new daum.maps.MapTypeControl();


				map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);


				var zoomControl = new daum.maps.ZoomControl();
				map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);


				function closeOverlay() {
				    overlay.setMap(null);     
				}
					</script>

				<div><a href="http://map.daum.net/link/map/${place.placeLa},${place.placeLo}">&nbsp;</a></div>
			    </div>
			    <!-- ---------------------------------------------다음 지도 끝------------------------------------------ -->
			    
			    


			<!-- 상품기본.가격정보 -->
			<div class="info_box">

				<!-- --------------------------현재구매갯수/남은시간---------------------------- -->
				<div class="buyinfo" id="stopwatch">
					<div class="timer">
					<script type="text/javascript">		
					
					    var date;

					    date = new Date();
					    date.setHours(0);
					    date.setMinutes(0);
					    date.setSeconds(0);

					    date.setDate(date.getDate() + 2); //이 부분에서 날짜 가져오기
					    
					    var time1 = date.getTime(); // 내일 0시 0분 으로 설정
					 
					     
					    // 남은 시간 카운터
					    function remain(){
					        var now = new Date();
					        var gap = Math.round((time1 - now.getTime()) / 1000);
					 
					        var D = Math.floor(gap / 86400);
					        var H = Math.floor((gap - D * 86400) / 3600 % 3600);
					        var M = Math.floor((gap - H * 3600) / 60 % 60);
					        var S = Math.floor((gap - M * 60) % 60);
					 
					        document.getElementById('stopwatch').innerHTML = '마감까지  ' + D + '일 ' + H + '시간 ' + M + '분 ' + S + '초';
					    }
					 
					    remain();

					    setInterval(remain, 1000);
					 
					</script>
					</div>
					<!-- ---------------------------------------------------------------------------- -->
				</div><br/>
				
				<!-- 상품명 -->
				<div class="name">
					<dl>
						<dd>[${show.showGenre}] ${show.showName }</dd>
						<dt><b>티켓팩토리</b>에서 강력추천하는 <${show.showName }> 공연</dt>
					</dl>
				</div>

				<!-- 가격정보 -->
				<div class="price_box">
					<div class="price">
						<dl><br/><br/>
							<!-- 할인 가격 -->
							<dd class=""><b><c:forEach var="i" begin="0" end="${length }" step="1">
									${seat[i] } - <fmt:formatNumber type="number"  pattern="0" value="${price[i] - price[i]*0.3 }" />원<br/>
											</c:forEach></b></dd>
							<!-- 원래 가격 -->		
							<dt><del><c:forEach var="i" begin="0" end="${length }" step="1">
									${seat[i] } - ${price[i]} 원<br/>
									</c:forEach><br/></del></dt>	
							
						</dl>
					</div>
				</div>

				<!-- 옵션선택 -->
				<div class="option">
				<div class="guide_text">상세옵션을 선택해주세요.(배송비 : 무료배송)</div>
					<!-- <select name='_option_select1' ID='option_select1_id' onchange="option_select(1,'S7192320');">
						<option value=''>회차 선택</option>
						<option value=''>03월09일 목 19시30분</option>
					</select> -->

				<!-- 날짜 시간 선택 -->
				<select id="selectDate"
					onchange="changeTime(this.value,'${sessionScope.showId }')">
					<option value="">날짜선택</option>
					<c:forEach var="date" items="${date }">
						<option value="${date.showDate },${date.showDay}">${date.showDate }[${date.showDay }]</option>
					</c:forEach>
				</select><br />
				
				<div id="timeDIV">
					<select onclick="check()">
						<option>시간선택</option>
					</select>
				</div>

			</div>
				<!-- //end 옵션선택 -->


				<!-- 최종금액/구매하기 버튼 -->
				<form action="" name="price_Form" method="post">
				<div class="price_sum">
					<div id="price_options_value"></div>
					<div id="total_price" style="display: none;">
					<span style="font-size: 14pt; font-family: 맑은 고딕;">총 결제금액 : </span><span id="show_total_price"></span>
					<input type="hidden" name="total_priceWon" id="total_priceWon">
					</div>
					<div class="btn_area">
					<div class="lineup" style="float: right;">
						<a href="javascript:all_check();">
						<img src="resources/image/btn_buy.png" alt="바로구매" />
						</a><br/><br/>
						<input type="hidden" value="${loginDto.userId }" name="userId">
						<!-- <a><img src="resources/image/btn_cart.png" alt="장바구니" /></a> -->
					</div>
				</div>
				</div>

				<input type="hidden" name="count" value="0">
				</form>

			</div>
			
				
		</div>
		<!-- //상품기본정보 박스 -->

				
<%-- 				<select id="selectDate"
					onchange="change(this.value,'${sessionScope.showId }')">
					<option value="">날짜선택</option>
					<c:forEach var="date" items="${date }">
						<option value="${date.showDate }">${date.showDate }[${date.showDay }]</option>
					</c:forEach>
				</select><br />
				
				<div id="timeDIV">
					<select onclick="check()">
						<option>시간선택</option>
					</select>
				</div>
			
				
				<div>
					<select id="selectPrice" onclick="check()" onchange="calcPrice(this.value)">
					<option>좌석선택</option>
						<c:set var="i" value="0"/>
						<c:forEach var="dto" items="${priceSeat }">
							<c:if test="${i<=length }">
							<option value="${dto }">${dto }</option>
							<c:set var="i" value="${r+1 }"/>
							</c:if>
						</c:forEach>
					</select>
				</div>



			</div>
				<!-- //end 옵션선택 -->


				<!-- 최종금액/구매하기 버튼 -->
				<div class="price_sum"><br/>
				<span style="font-size: 20px;">총 결제금액:</span><span  id="show_total_price"><p style="font-size: 30px;">3000</p></span>
				</div>

				<div class="btn_area">
					<div class="lineup" style="float: right;">
						<a><img src="resources/image/btn_buy.png" alt="바로구매" /></a>
						<!-- <a><img src="resources/image/btn_cart.png" alt="장바구니" /></a> -->
					</div>
				</div>

			</div>
				
		</div>
		<!-- //상품기본정보 박스 --> --%>



<!-- ----------------------------------------------------------------------------------------------------------- -->




	<%--<img alt="" src="${show.showPoster }" width="170" height="220"><br/>
${show.showName }(${show.showId })<br/>
${show.showPrice }<br/>
판매기간:${show.showFrom }~${show.showTo }<br/>
<c:forEach var="dto" items="${time }">
	${dto.showDay } - ${dto.showTime } - ${dto.seat }
</c:forEach><br/> 
<input type="text"/> 
<br/><hr> --%>

	<div class="container">
	<div class="menubar" id="notice">
		<p class="content"><input type="button" value="안내" class="submit-button" style="width: 211px;"
		onclick="changeView('notice.action','${sessionScope.showId}');" id="notice_btn" name="notice_btn" ></p></div>
	<div class="menubar" id="review">
		<p class="content"><input type="button" value="리뷰" class="submit-button" style="width: 211px;"
		onclick="changeView('review.action','${sessionScope.showId}');" id="review_btn" name="review_btn"></p></div>
	<div class="menubar" id="detail">
		<p class="content"><input type="button" value="상세" class="submit-button" style="width: 210px;"
		onclick="changeView('detail.action','${sessionScope.showId}');" id="detail_btn" name="detail_btn"></p></div>
	<%-- <div class="menubar" id="map">
		<p class="content"><input type="button" value="장소" class="submit-button"
		onclick="changeView('map.action','${sessionScope.showId}');" id="map_btn" name="map_btn"></p></div> --%>
	<div class="menubar" id="qna">
		<p class="content"><input type="button" value="Q&A" class="submit-button" style="width: 210px;"
		onclick="changeView('qna.action','${sessionScope.showId}');" id="qna_btn" name="qna_btn"></p></div>		
	<div id="layout" class="view"></div>
	</div>





</body>
</html>