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
<title>양도게시판글쓰기</title>

<!-- CKEditor 렛츠고 -->
<script src="<%=cp%>/resources/editor/ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="/ticketfactory/resources/css/eventlistbody.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/styles.css" type="text/css"/>
<link rel="stylesheet" href="/ticketfactory/resources/css/eventlist.css" type="text/css"/>


<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
	
		str = f.ydSubject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.ydSubject.focus();
			return;
		}
		f.ydSubject.value = str;
	
		var ckeditor = CKEDITOR.instances['ydContent']; //객체가져오기
		 
	    if (ckeditor.getData()=="") {//null값은 안옴 = 빈문자열
	         alert("글 내용을 입력하세요");
	         f.ydContent.focus();
	         return false;
	    }
	
		f.action = "<%=cp%>/yangdoCreated_ok.action";
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
				<p><a href="<%=cp%>/eventList.action"><span class="talk_menu_on">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">이벤트/기획전</span></a>
				</p>
				
				<p><a href="<%=cp%>/reviewBoard.action"><span class="talk_menu_on">
					<img class="icon_dot" src="/ticketfactory/resources/image/icon_dot.png">실시간 별점</span></a>
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
					양도 & 판매
					</div>
				
					<div class="talk_subtitle">
					※ 모든 양도과정은 티켓팩토리의 관리하에 <b>안전하게</b> 이루어지고 있습니다.<br/>
					티켓 팩토리의 승인이 있어야 양도가 가능하며, 승인 시에 <b>모바일 티켓이 자동으로 전송됩니다.</b>
					</div>
					
					<hr class="talk_title_underline">
					
					<!-- 헤헤 글쓰자능 -->
					
					<center>
			
						<div style="margin-top:20px; width:100%;">
						
							<form action="" name="myForm" method="post">
							
								<table width="100%"  bgcolor="#f9f9f9" cellpadding="0" cellspacing="0" style="margin-top:10px;">
									<tr>
									  <td>
										<table width="100%" cellpadding="0" cellspacing="0">
										
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">니가원하는거
												</td>				
												<td style="padding:5px 0 5px 10px;">
													<input type="radio" name="ydType"  value="양도" checked="checked">양도
													<input type="radio" name="ydType" value="판매">판매
													<input type="radio" name="ydType" value="구함">구함 
												</td>
											</tr>
										
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">제목</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name='ydSubject' type='text' class="input_New" 
												maxlength="100" style="width:580px;"></td>
											</tr>
											
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">아이디</td>				
												<td style="padding:5px 0 5px 10px;">
												<input name='ydId' type='text' class="input_New" value="${sessionScope.loginDto.userId }"
												 style="width:580px; border: 0;" readonly="readonly"></td>
											</tr>
						
											<tr style="border:1px solid #dedede; height:40px;">
												<td style="width:100px; background-color:#f1f1f1; 
												padding-left:10px; color:#5e5e5e;" class="smfont4">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>				
												<td style="padding:5px 0 5px 10px;">
													<textarea rows="200" cols="80" id="ydContent" name="ydContent" class="ckeditor"></textarea>
														<script>
														CKEDITOR.replace('ydContent',
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
								onclick="document.myForm.ydSubject.focus();"/>
								<input type="button" value=" 작성취소 " class="btn2" 
								onclick="javascript:location.href='<%=cp%>/yangdoList.action';"/>	
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