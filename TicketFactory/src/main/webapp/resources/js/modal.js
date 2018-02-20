
/* 아이디찾기 비밀번호찾기 마우스 올라가면 색깔변하도록 하는 함수 */
function color_change_on(obj) {
	if(obj==search_id){
	obj.style.color = "#FF007F";
	obj2 = document.getElementById("search_pwd");
	obj2.style.color = "#337ab7";
	
	}else{
		obj.style.color = "#FF007F";
		obj2 = document.getElementById("search_id");
		obj2.style.color = "#337ab7";
		}
}
/* 아이디찾기 비밀번호찾기 마우스 아웃되면 색깔변하도록 하는 함수 */
function color_change_out(obj){
			
		obj.style.color = "#337ab7";
	
	
}


/*로그인시 아이디,비밀번호 입력여부 확인*/
function send_login() {
	 
	 var userId = $.trim($("#login_id").val());
		var userPwd = $.trim($("#login_pwd").val());
		
		
		if(!userId){
			alert("아이디를 입력하세요");
			$("#login_id").focus();
			return false;
		}
		
		if(!userPwd){
			alert("비밀번호를 입력하세요");
			$("#login_pwd").focus();
			return false;
		}
		
		return true;
		
		
}

/*로그인시 아이디,비밀번호 입력여부 확인*/
function mem_out_login() {
	 
	 var userId = $.trim($("#mem_out_id").val());
		var userPwd = $.trim($("#mem_out_pwd").val());
		
		
		if(!userId){
			alert("아이디를 입력하세요");
			$("#mem_out_id").focus();
			return false;
		}
		
		if(!userPwd){
			alert("비밀번호를 입력하세요");
			$("#mem_out_pwd").focus();
			return false;
		}
		
		return true;
		
		
}


function search_play_page(pageNum) {
	
	var search_word = $("#searchPlayName").val();
	var params = "searchPlayName=" + search_word + "&pageNum="+pageNum;
	
	
	$.ajax({
		
		type:"POST",
		url:"/ticketfactory/search_play.action",
		data:params,
		success:function(args){
			
			$("#show_play_id").html(args);
			
			
		},
		error: function (e) {
			alert(e.responseText);
		}
	
			});	
	
	
}





/* 모달로그인창 띄우는 함수 */
$(document).ready(function(){

	$('#main_bn').ulslide({
		statusbar: true,
		width: 700, 
		height: 500, 
		affect: 'slide', 
		axis: 'x', 
		navigator: '#main_bn_btn a',
		duration: 400, 
		autoslide: 4000 
	});
	
	
  $("#login").click(function(){
    	$("#check").css("display", "none");
    	$("#login_id").val("");
    	$("#login_pwd").val("");
    	$("#check").val("");
    	$("#myModal").show();
        $("#myModal").modal({
        	backdrop: false
        		});
        
        $("#my_modal").css("top", "320px");
        $("#my_modal").css("left", "100px");
        $("#my_modal").css("z-index", "11"); 
   
    }); 
    
    
    $("#search_id").click(function(){
    	$("#show_id").css("display", "none");
    	$("#goto_login_btn").css("display", "none");
    	$("#loginName").val("");
    	$("#loginEmail").val("");
    	$("#show_id").val("");
    	$("#myModal").hide();
    	$("#idModal").show();
    	 $("#idModal").modal({
        	backdrop: true
        		});    	
    	$("#id_modal").css("top", "320px");
        $("#id_modal").css("left", "100px");
        $("#id_modal").css("width", "500px");
        $("#id_modal").css("z-index", "11"); 
    	
    });
    
    
    $("#search_pwd").click(function(){
    	$("#show_pwd").css("display", "none");
    	$("#goto_login_pwd_btn").css("display", "none");
    	$("#loginId").val("");
    	$("#loginEmail").val("");
    	$("#show_pwd").val("");
    	$("#myModal").hide();
    	$("#pwdModal").show();
    	 $("#pwdModal").modal({
        	backdrop: true
        		});    	
    	$("#pwd_modal").css("top", "320px");
        $("#pwd_modal").css("left", "100px");
        $("#pwd_modal").css("width", "500px");
        $("#pwd_modal").css("z-index", "11"); 
    	
    });
    
    $("#custom_rule").click(function(){
    	$("#custom_ruleModal").show();
        $("#custom_ruleModal").modal({
        	backdrop: false
        		});
        
        $("#custom_rule_modal").css("top", "100px");
        $("#custom_rule_modal").css("left", "100px");
        $("#custom_rule_modal").css("height", "555px");
        $("#custom_rule_modal").css("width", "500px");
        $("#custom_rule_modal").css("z-index", "11"); 
   
    }); 
    
    $("#custom_rule_footer").click(function(){
    	$("#custom_ruleModal").show();
        $("#custom_ruleModal").modal({
        	backdrop: false
        		});
        
        $("#custom_rule_modal").css("top", "100px");
        $("#custom_rule_modal").css("left", "100px");
        $("#custom_rule_modal").css("height", "555px");
        $("#custom_rule_modal").css("width", "500px");
        $("#custom_rule_modal").css("z-index", "11"); 
   
    });
    
    $("#custom_info").click(function(){
    	$("#custom_infoModal").show();
        $("#custom_infoModal").modal({
        	backdrop: false
        		});
        
        $("#custom_info_modal").css("top", "100px");
        $("#custom_info_modal").css("left", "100px");
        $("#custom_info_modal").css("height", "555px");
        $("#custom_info_modal").css("width", "500px");
        $("#custom_info_modal").css("z-index", "11"); 
   
    }); 
    
    $("#custom_info_footer").click(function(){
    	$("#custom_infoModal").show();
        $("#custom_infoModal").modal({
        	backdrop: false
        		});
        
        $("#custom_info_modal").css("top", "100px");
        $("#custom_info_modal").css("left", "100px");
        $("#custom_info_modal").css("height", "555px");
        $("#custom_info_modal").css("width", "500px");
        $("#custom_info_modal").css("z-index", "11"); 
   
    }); 
    
    $("#search_play").click(function(){
    	/*$("#check").css("display", "none");
    	$("#login_id").val("");
    	$("#login_pwd").val("");
    	$("#check").val("");*/
    	$("#searchPlayModal").show();
        $("#searchPlayModal").modal({
        	backdrop: false
        		});
        
        $("#search_play_modal").css("top", "220px");
        $("#search_play_modal").css("left", "100px");
        $("#search_play_modal").css("z-index", "11"); 
   
    }); 
    
    
    
    
    
    /* 모달로그인창에서 로그인 버튼을 누른후 로그인 판단하는 함수 */
    /* 실패시 로그인실패 글씨 뿌려줌 */
    /* 성공시 mainPage로 이동 */
    $("#login_btn").click(function(){
    	
    	params = $("#loginForm").serialize();
    	
    	$.ajax({
    		
			type:"POST",
			url:"/ticketfactory/login_checker.action",
			data:params,
			success:function(args){
				
			
				if($.trim(args)=="success") {
					
					if($("input[name=whoRU]:checked").val()=="회원"){
					$("#loginForm").attr("action", "/ticketfactory/main.action");
					$("#loginForm").submit();
					}else{
					//alert("관리자모드");	
					$("#loginForm").attr("action", "/ticketfactory/admin.action");
					$("#loginForm").submit();	
						
					}
				} else {
				
					$("#check").css("display","block");
					$("#check").val(args);
				}
				
			},
			beforeSend : send_login,
			error: function (e) {
				alert(e.responseText);
			}
		
				});	
    	});
    
    /* 회원탈퇴시 로그인창 */
    /* 실패시 로그인실패 글씨 뿌려줌 */
    /* 성공시 mainPage로 이동 */
    $("#mem_out_btn").click(function(){
    	
    	params = $("#memOutForm").serialize();
    	$.ajax({
    		
			type:"POST",
			url:"/ticketfactory/login_checker.action",
			data:params,
			success:function(args){
				
				//var params
				//alert($.trim(args));
				//alert($("#login_id").val());
				if($.trim(args)==$("#mem_out_id").val()) {
					 
					 $("#memOutForm").submit(); 
					 
				} else {
					$("#mem_out_check").css("display","block");			
					$("#mem_out_check").val(args);
				}
				
			},
			beforeSend : mem_out_login,
			error: function (e) {
				alert(e.responseText);
			}
		
				});	
    	});
			
			



//아이디찾기 아작스

$("#search_id_btn").click(function(){

    	var params = "userName=" + $("#loginName").val()
    				+"&userEmail=" +$("#loginEmail").val();
    	
    	
    	$.ajax({
    		
			type:"POST",
			url:"/ticketfactory/search_id_checker.action",
			data:params,
			success:function(args){
				alert($.trim(args));
				if($.trim(args)=="not_exist") {

					$("#show_id").css("display", "block");
					$("#show_id").val("해당하는 회원이 존재하지 않습니다.");
					 
					
				} else {
					$("#show_id").css("display", "block");
					$("#show_id").val("회원님의 아이디는:"+args);
					$("#goto_login_btn").css("display", "inline-block");
				}
				
			},
			error: function (e) {
				alert(e.responseText);
			}
		
				});	
    	});
    	
    	
$("#search_pwd_btn").click(function(){

	var params = "userId=" + $("#loginId").val()
				+"&userEmail=" +$("#login_pwd_Email").val();
	
	
	$.ajax({
		
		type:"POST",
		url:"/ticketfactory/search_pwd_checker.action",
		data:params,
		success:function(args){
			alert($.trim(args));
			if($.trim(args)=="not_exist") {

				$("#show_pwd").css("display", "block");
				$("#show_pwd").val("해당하는 회원이 존재하지 않습니다.");
				 
				
			} else {
				$("#show_pwd").css("display", "block");
				$("#show_pwd").val("회원님의 비밀번호는:"+args);
				$("#goto_login_pwd_btn").css("display", "inline-block");
			}
			
		},
		error: function (e) {
			alert(e.responseText);
		}
	
			});	
	});   


//연극찾기 아작스

$("#search_play_btn").click(function(){

    	var params = "searchPlayName=" + $("#searchPlayName").val();
    	
    	
    	$.ajax({
    		
			type:"POST",
			url:"/ticketfactory/search_play.action",
			data:params,
			success:function(args){
				
				$("#show_play_id").html(args);
				
				
			},
			error: function (e) {
				alert(e.responseText);
			}
		
				});	
    	});
    	
    	
$("#goto_login_btn").click(function(){
	$("#idModal").hide();
	$("#myModal").show();
	$("#loginName").val("");
	$("#loginEmail").val("");
	$("#show_id").val("");

});	

$("#goto_login_pwd_btn").click(function(){
	$("#pwdModal").hide();
	$("#myModal").show();
	$("#loginId").val("");
	$("#login_pwd_Email").val("");
	$("#show_pwd").val("");

});	



});	

