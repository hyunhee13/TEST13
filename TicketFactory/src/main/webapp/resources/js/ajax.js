function changeView(url,str,groupNum,boardNum){
		var postString="showId="+str;
		if(groupNum!=null){
			postString += "&groupNum=" + groupNum;
			postString += "&boardNum=" + boardNum;
		}


		$.ajax({
			type:"post",
			url:url,
			data:encodeURI(postString),
			beforeSend:changeBorder(url),
			success:function(msg){
				document.getElementById("layout").innerHTML = msg;
			},
			error:function(e){
				alert(e.responseText);
			}
		});
	}





function changeReview(url,str,num){
	var postString="showId="+str;
	if(num!=null){
		postString += "&num=" + num;
	}


	$.ajax({
		type:"post",
		url:url,
		data:encodeURI(postString),
		beforeSend:changeBorder(url),
		success:function(msg){
			document.getElementById("layout").innerHTML = msg;
		},
		error:function(e){
			alert(e.responseText);
		}
	});	
	
}






function changeTime(date,id){

	var dateInfo =  date.split(",");
	date = dateInfo[0];
	var params = "showDate="+date + "&showId="+id;

	
	$.ajax({
	  	  type:"post",
		  url:"setTime.action",
		  dataType:"html",
		  data:params,
		  success:function(time){
	
			  if(time!=null){
				  $("#timeDIV").html(time);              
	           }	                
		  },
		  error:function(e){
				alert(e.responseText);
			}
	  });
}




function changeBorder(url){
	
	var id=url.split('.');
	if(id[0]=='detail'){
		$('input[name="detail_btn"]').attr('class','pressed-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','submit-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:white'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:#CFCFCF'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}else if(id[0]=='notice'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','pressed-button');
		$('input[name="review_btn"]').attr('class','submit-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:white'});
		$('#review').attr({style:'border-bottom-color:#CFCFCF'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}else if(id[0]=='review'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','pressed-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:white'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}else if(id[0]=='map'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','submit-button');
		$('input[name="map_btn"]').attr('class','pressed-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:#CFCFCF'});
		$('#map').attr({style:'border-bottom-color:white'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}else if(id[0]=='qna'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','submit-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','pressed-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:#CFCFCF'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:white'});
	}else if(id[0]=='created'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','pressed-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:white'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}else if(id[0]=='createdQA'){
		$('input[name="detail_btn"]').attr('class','submit-button');
		$('input[name="notice_btn"]').attr('class','submit-button');
		$('input[name="review_btn"]').attr('class','pressed-button');
		$('input[name="map_btn"]').attr('class','submit-button');
		$('input[name="qna_btn"]').attr('class','submit-button');
		
		$('#detail').attr({style:'border-bottom-color:#CFCFCF'});
		$('#notice').attr({style:'border-bottom-color:#CFCFCF'});
		$('#review').attr({style:'border-bottom-color:white'});
		$('#map').attr({style:'border-bottom-color:#CFCFCF'});
		$('#qna').attr({style:'border-bottom-color:#CFCFCF'});
	}
	
	
}

