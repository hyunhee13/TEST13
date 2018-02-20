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
<!-- jquery 기간달력 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>이벤트게시판할꾸얌</title>

<!-- CKEditor 렛츠고 -->
<script src="<%=cp%>/resources/editor/ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>

<!-- 기간달력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>

<script>

    $(function() {

        // 기간 설정 타입 1 

        // start Date 설정시 end Date의 min Date 지정

        $( "#startDt" ).datepicker({

            dateFormat: "yy.mm.dd",

            dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],

            monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            defaultDate: "+1w",

            numberOfMonths: 1,

            changeMonth: true,

            showMonthAfterYear: true ,

            changeYear: true,

            onClose: function( selectedDate ) {

                $( "#endDt" ).datepicker( "option", "minDate", selectedDate );

            }

        }); 

         // end Date 설정시 start Date max Date 지정

        $( "#endDt" ).datepicker({

            dateFormat: "yy.mm.dd",

            dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],

            monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            defaultDate: "+1w",

            numberOfMonths: 1,

            changeMonth: true,

            showMonthAfterYear: true ,

            changeYear: true,

            onClose: function( selectedDate ) {

                $( "#startDt" ).datepicker( "option", "maxDate", selectedDate );

            }

        });

        // 기간 설정 타입 2 

        // start Date 설정시 end Date 가 start Date보다 작을 경우 end Date를 start Date와 같게 설정

        $("#startDt").datepicker({

            dateFormat: "yy.mm.dd",

            defaultDate: "+1w",

            numberOfMonths: 1,

            changeMonth: true,

            showMonthAfterYear: true ,

            changeYear: true,

            onClose: function( selectedDate ) {

                if ($( "#endDt" ).val() < selectedDate)

                {

                    $( "#endDt" ).val(selectedDate);

                }

            }

        }); 

        // end Date 설정시 end Date 가 start Date 보다 작을 경우 start Date를  end Date와 같게 설정

        $( "#endDt" ).datepicker({

            dateFormat: "yy.mm.dd",

            defaultDate: "+1w",

            numberOfMonths: 1,

            changeMonth: true,

            showMonthAfterYear: true ,

            changeYear: true,

            onClose: function( selectedDate ) {

                if ($("#startDt" ).val() > selectedDate)

                {

                    $("#startDt" ).val(selectedDate);

                }

            }

        });

        //날짜

        $( "#date" ).datepicker({

            changeMonth: true ,

            changeYear: true ,

            showMonthAfterYear: true ,

            dateFormat: "yy.mm.dd",

            dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],

            monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],

            defaultDate: "+1w",

            numberOfMonths: 1

        }); 

    }); 

</script>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		str = f.ebTitle.value;
		str = str.trim();
		if(!str){
			alert("\n타이틀 입력하세요.");
			f.ebTitle.focus();
			return;
		}
		f.ebTitle.value = str;
		
		str = f.ebSubject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.ebSubject.focus();
			return;
		}
		f.ebSubject.value = str;
		
		str = f.ebTitleContent.value;
		str = str.trim();
		if(!str){
			alert("\n리스트에 보여 줄 내용을 입력하세요.");
			f.ebTitleContent.focus();
			return;
		}
		f.ebTitleContent.value = str;
		
/* 		str = f.upload.value;
		str = str.trim();
		if(!str){
			alert("\n리스트에 보여 줄 그림을 추가하세요.");
			f.upload.focus();
			return;
		}
		f.upload.value = str; */
		
		str = f.ebPeriodFrom.value;
		str = str.trim();
		if(!str){
			alert("\n이벤트 기간을 입력하세요.");
			f.ebPeriodFrom.focus();
			return;
		}
		f.ebPeriodFrom.value = str;
		
		str = f.ebPeriodTo.value;
		str = str.trim();
		if(!str){
			alert("\n이벤트 기간을 입력하세요.");
			f.ebPeriodTo.focus();
			return;
		}
		f.ebPeriodTo.value = str;
		
		var ckeditor = CKEDITOR.instances['ebContent']; //객체가져오기
		 
	    if (ckeditor.getData()=="") {//null값은 안옴 = 빈문자열
	         alert("글 내용을 입력하세요");
	         f.ebContent.focus();
	         return false;
	    }
	
		f.action = "<%=cp%>/eventCreated_ok.action";
		f.submit();
		
	}

</script>



</head>
<body>

<div id="Wrap">
	
	<div id="section_wrap">

		<div id="talk_menu">

			<div class="talk_menu_home">
				<p><a href="bbs_list.php?tb=talk_main"><span class="talk_menu_off">티켓톡 홈</span></a></p>
			</div>
			
			<div class="talk_menu_title_bar"></div>

			<div class="talk_menu_sub">
				
				<p>
					<a href="<%=cp%>/eventList.action"><span class="talk_menu_on">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span>
					</a>
				</p>
				
				<p>
					<a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">실시간 별점</span>
					</a>
				</p>
				
				<p>
					<a href="<%=cp%>/yangdoList.action"><span class="talk_menu_on">
						<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">티켓양도</span>
					</a>
				</p>
				
			</div>

			<div class="talk_menu_title_bar2"></div>

		</div>
		
		<div id="right_content">
		
			<div style="padding-bottom:30px;">
				
				<div style="padding:23px 23px 0 23px;">
					<div class="talk_title">
					이벤트/기획전
					</div>
				
					<div class="talk_subtitle">
					타임티켓이 준비한 다양한 이벤트 / 특별한 기획전을 만나보세요!
					</div>
					
					<hr class="talk_title_underline">
					
					<!-- 아오복잡해 게시판 -->
					
					<center>
			
						<div style="margin-top:20px; width:100%;">
						
							<form action="" name="myForm" method="post" enctype="multipart/form-data">
							
								<table width="100%"  bgcolor="#f9f9f9" cellpadding="0" cellspacing="0" style="margin-top:10px;">
									<tr>
									  <td>
										<table width="100%" cellpadding="0" cellspacing="0">
										
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">타이틀</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name='ebTitle' type='text' class="input_New" 
												maxlength="100" style="width:580px;"></td>
											</tr>
										
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">제목</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name='ebSubject' type='text' class="input_New" 
												maxlength="100" style="width:580px;"></td>
											</tr>
											
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">리스트내용</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name='ebTitleContent' type='text' class="input_New" 
												maxlength="100" style="width:580px;"></td>
											</tr>
											
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">리스트그림</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name="upload" type="file" class="input_New">
												</td>
											</tr>
											
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">이벤트 기간</td>				
												<td style="padding:5px 0 5px 10px;">
						
													<div>													
													    <input type="text" id="startDt" name="ebPeriodFrom" /> ~ <input type="text" id="endDt" name="ebPeriodTo"/>							
													</div>

												</td>	
											</tr>
									
											
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>				
												<td style="padding:5px 0 5px 10px;">
													<textarea rows="200" cols="80" id="ebContent" name="ebContent" class="ckeditor"></textarea>
														<script>
														CKEDITOR.replace('ebContent',
														{
																resize_enabled : false, //에디터 크기를 조절하지 않음.
																enterMode : CKEDITOR.ENTER_BR, //엔터키를 <br>로 적용
																shiftEnterMode : CKEDITOR.ENTER_P, //쉬프트 + 엔터를 <p>로 적용
																toolbarCanCollapse : true,
																removePlugins : "elementspath", //DOM 출력하지 않음
																filebrowserImageUploadUrl : '<%=cp%>/fileUpload.action',
																height : 300,
													
																/* //에디터에 사용 할 기능 정의
																toolbar : [ 
																	[ 'Source', '-' , 'NewPage', 'Preview' ], 
																	[ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ],
																	[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'], 
																	[ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ], 
																	'/', 
																	[ 'Styles', 'Format', 'Font', 'FontSize' ], 
																	[ 'TextColor', 'BGColor' ], 
																	[ 'Image', 'Flash', 'Table' , 'SpecialChar' , 'Link', 'Unlink']
																	
																	]  */
														});
														
														CKEDITOR.config.font_names = '굴림;Nanum Gothic Coding;궁서;돋움;맑은 고딕;바탕;' + CKEDITOR.config.font_names;
													
														//전송을 위한 체크함수
														function form_save(form){
															editor.updateElement();
															
														}
														</script>
													</td>
												</tr>
										</table>
									  </td>
									</tr>
								</table>
							</form>
							
							<div align="center" style="margin-top: 30px;">
								<input type="button" value="등록하기 " class="btn2" 
								onclick="sendIt();"/>
								<input type="reset" value=" 다시입력 " class="btn2" 
								onclick="document.myForm.ebSubject.focus();"/>
								<input type="button" value=" 작성취소 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/eventList.action';"/>	
							</div>
							
						</div>
					</center>
				</div>
			</div>	
		</div>		
	</div>		
</div>
			

	<br/><br/>
 
</body>
</html>