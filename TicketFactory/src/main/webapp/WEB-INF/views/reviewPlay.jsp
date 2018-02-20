<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>



</head>
<body>




					<c:forEach var="dto" items="${review}">
						<hr style="border: 2px dotted #FFB2D9;">
						<div style="padding:15px; width: 750px; height: 135px; float: left;" class="effect">
						<a href="layout.action?showId=${dto.showId }">

						<div style="text-align:left;">
							<!--왼쪽 이미지-->
							<div style="float:left;">
								
								<img src='${dto.showPoster }' alt="test" style="width:160px; height: 130px;">
								
							</div>
				
							<!--오른쪽 티켓정보-->

							<div style="margin-left:170px;padding-top:8px;">
								
								<div class="ellipsis" style="width:530px; height:30px; vertical-align:bottom;">
									<span style="font-size:15px; font-weight:600; color:#313131;">제목 : ${dto.showName }</span>
									
								</div>
				
								<div>
									<span style="font-size:12px; color:#e81b19; padding-bottom:10px; vertical-align:bottom;">관객평점 : <img alt="test" src="${dto.star2 }"></span>
								</div><br/>
				
								<%-- <div style="height:25px; padding-top:5px; vertical-align:bottom;">
									<div style="float:left; vertical-align:bottom;">${dto.name }</div>
									<div style="float:left; text-align:right; vertical-align:bottom;"><span style="color:#aaa; padding:0 10px;">|</span>${dto.created }</div>	 --%>	
									<div style="vertical-align:bottom;"><span style="color:#aaa; padding:0 10px;">|</span>장&nbsp;소 : ${dto.showPlace } </div>
								</div>
							
								<div style="margin-bottom:10px;; line-height:1.9em;">
								<%-- <span style="padding-left:7px; font-size: 15px; color: #F361A6;"><b>${dto.content }</b></span> --%>
								</div>
				
							</div>
							

						</div>
					
						</a>
					</div>
					
					</c:forEach>					






</body>
</html>