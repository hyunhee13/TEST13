/* 비밀번호 확인란의 입력시 누를시 일치여부 뿌려줌 */   
 function pwdChecker() {
	 
	 f = document.myForm;
	 pwd1 = f.userPwd.value;
	 pwd2 = f.userPwd2.value;
	 
	 if(pwd2.length == 0 || pwd2 == null){
		 /* 비밀번호 먼저입력 */
		f.pass_ok.value = "비밀번호를 입력하세요";
		f.pwdch.style.color = "#FF007F";
	 }else if(pwd1!=pwd2){
		 /* 비밀번호가 일치하지 않습니다. */
		f.pass_ok.value = "비밀번호가 일치하지 않습니다."
		f.pwdch.style.color = "#FF007F";
	 }else{
		f.pass_ok.value ="비밀번호가 동일합니다."
		f.pwdch.style.color = "green";
	 }
	 return;
 }
 
 /* 고객센터 탭에 마우스 올리고 내릴시 동작 */
 function change(obj,a) {
 	if (a==1) {
 		obj.style.visibility = "visible";
 	}
 	
 	if (a==2) {
 		obj.style.visibility = "hidden";
 	}
 	 
 }
 
//숫자만 입력.
 function isNumberKey(evt){
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode( key );
    var regex = /[0-9]|\./;
    if( !regex.test(key) ) {
      theEvent.returnValue = false;
      if(theEvent.preventDefault) theEvent.preventDefault();
    }else{
     theEvent.returnValue = true;  
    }
 }

 


 /* 이메일 select박스로 input박스 값 넣기 */
 function email_input() {
	 
	 f = document.myForm;
	 
	 if(f.emailchk.options[f.emailchk.selectedIndex].value == '0'){
		 f.user_email2.disabled = true;
		 f.user_email2.value = "";
		 return;
	 }
	 if(f.emailchk.options[f.emailchk.selectedIndex].value == '9'){
		 f.user_email2.disabled = false;
		 f.user_email2.value = "";
		 f.user_email2.focus();
	 }else{
		 f.user_email2.disabled =true;
		 f.user_email2.value =
		f.emailchk.options[f.emailchk.selectedIndex].value;
		 
	 }
	
}
 
function email_input_group() {
	 
	 f = document.price_Form;
	 
	 if(f.emailchk.options[f.emailchk.selectedIndex].value == '0'){
		 f.groupBookEmail2.disabled = true;
		 f.groupBookEmail2.value = "";
		 return;
	 }
	 if(f.emailchk.options[f.emailchk.selectedIndex].value == '9'){
		 f.groupBookEmail2.disabled = false;
		 f.groupBookEmail2.value = "";
		 f.groupBookEmail2.focus();
	 }else{
		 f.groupBookEmail2.disabled =true;
		 f.groupBookEmail2.value =
		f.emailchk.options[f.emailchk.selectedIndex].value;
		 
	 }
	
}
 /*회원가입시 영문자 숫자입력과 글자수 제한하는 함수*/
 function id_check() {
	
	
	 var userId = $.trim($("#userId").val());

	 var deny_char = /^[A-Za-z0-9]+$/;
	
	 
	 if(!deny_char.test(userId) ){
		 
		 $("#userId").focus();
		 $("#userId").val("");
		 $("#id_check").val("영문자와 숫자조합으로 입력해주세요.");
		 $("#id_check").css("display", "block");
		 return false;
	 }
	
	 if(userId.length<8 || userId.length>15){
		 $("#userId").focus();
		 $("#id_check").val("8자이상 16자이하로 입력해주세요.");
		 $("#id_check").css("display", "block");
		 return false;
	 }
	 
	 return true;
}
 
 
 /*회원가입시 최종점검하는 함수*/
 function sendIt(){
		
		f = document.myForm;

		str = f.userId.value;
		str = str.trim();
		if(!str){
			alert("\n아이디를 입력하세요.");
			f.userId.focus();
			return;
		}
		str = f.userId.value;
		str = str.trim();
		if(str.length<8 || str.length>15){
			alert("\n아이디를 8자이상 16자이하로 입력하세요.");
			f.userId.focus();
			return;
		}
		f.userId.value = str;
		
		if(f.mode.value == "sign"){
		str = f.id_check.value;
		str = str.trim();
		if(str=='사용중인 아이디입니다.'){
			alert("\n중복된 아이디 입니다.");
			f.userId.focus();
			return;
		}
		}
		
		str = f.userPwd.value;
		str = str.trim();
		if(!str){
			alert("\n패스워드를 입력하세요.");
			f.userPwd.focus();
			return;
		}
		
		
		str2 = f.userPwd2.value;
		str2 = str2.trim();
		if(!str2){
			alert("\n패스워드확인을 입력하세요.");
			f.userPwd2.focus();
			return;
		}
		
		
		if(str!=str2){
			
			alert("\n패스워드가 일치하지 않습니다.");
			f.userPwd2.focus();
			return;
			
		}
		f.userPwd.value = str;
		f.userPwd2.value = str2;
		
		str = f.userName.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.userName.focus();
			return;
		}		
		f.userName.value = str;
		
		if(!isValidKorean(str)){			
			alert("\n이름을 정확히 입력하세요.");
			f.userName.focus();
			return;
		}
		f.userName.value = str;
		
		if(f.userGender[0].checked==false&&f.userGender[1].checked==false){
			   alert('성별을 체크하세요.');
			    return;
			  }
		
		str = f.user_email1.value;
		if(!str){
			alert("\n Email을 입력하세요.");
			f.user_email1.focus();
			return;
		}
		
		str = f.user_email2.value;
		if(!str){
			alert("\n Email을 입력하세요.");
			f.user_email2.focus();
			return;
		}
		
		str = f.user_email1.value + "@";
		str += f.user_email2.value;
		str = str.trim();
		
		if(str){
		
		if(!isValidEmail(str)){
			alert("\n정상적인 E-Mail을 입력하세요.");
			f.user_email1.focus();
			return;
			}
		}
		f.userEmail.value = str;
		
		str = f.userTel.value;
		str = str.trim();
		if(!str){
			alert("\n전화번호를 입력하세요.");
			f.userTel.focus();
			return;
		}	
		f.userTel.value = str;
		
		str = f.userAddr_num.value;
		str = str.trim();
		if(!str){
			alert("\n우편번호를 입력하세요.");
			f.userAddr_num.focus();
			return;
		}	
		f.userAddr_num.value = str;
		
		str = f.userAddr_detail.value;
		str = str.trim();
		if(!str){
			alert("\n상세주소를 입력하세요.");
			f.userAddr_detail.focus();
			return;
		}	
		f.userAddr_detail.value = str;
		
		if(f.mode.value == "sign"){
		if(f.agreement.checked==false){
			alert("\n동의를 하셔야 가입이 완료됩니다.");
			f.agreement.focus();
			return;
		}	
		}
		if(f.mode.value == "sign"){
			f.action = "/ticketfactory/sign_ok.action";
			f.submit();
			return true;	
			
		}
		
		if(f.mode.value == "mypage"){
			
			f.action = "/ticketfactory/update.action";
			f.submit();
			return true;
			
		}
		
		
	}

 
 /* 회원가입창에서 ID중복확인후 글씨 뿌려주는 함수 */
 function id_checker() {
 	
 	var params = "userId=" +$("#userId").val();
 	
 	$.ajax({
 	
 			type:"POST",
 			url:"login_id_checker.action",
 			data:params,
 			success:function(args){
 				
 				//$("#check").html(args);
 				$("#id_check").val(args);

 				$("#id_check").css("display", "block");
 				
 				
 				//Ajax는 새로고침을 하지 않기 때문에
 				//입력데이터를 삭제해야함
 				/* $("#user_id").val(""); */
 				
 			},
 			
 			beforeSend : id_check, 
 			error: function (e) {
 				alert(e.responseText);
 			}
 			
 				});
 	
 	
 	
 }

 /*"검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 */
  $(function() { $("#postcodify_search_button").postcodifyPopUp({
  	insertEnglishAddress :"#postcodify_extra_info"
  }); }); 
  
  
  

