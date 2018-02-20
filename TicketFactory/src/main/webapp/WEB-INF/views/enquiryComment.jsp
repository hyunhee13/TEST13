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
<title>eqcComment ajax</title>
</head>
<body>


		<c:if test="${dataCount!=0 }">
			<table cellspacing=0 style='width:100%; border-top:1px solid #e8e8e8;'>
			
		
				<tr>
					<td style='padding:5px 5px 10px 5px;'>
						<table cellspacing=0 style='width:100%;'>
						<tr>
							<td align="left">
								<table cellspacing="0" style="width:100%;">
								
									<c:forEach var="dto" items="${lists }">
								<tr>
									<td style="font-size:13px; height:14px; color:#a3a3a3; padding-top:5px; padding-bottom: 12px; font-weight: 600;" align='left'>
										<span style='color:#1e6ec9;'>아이디</span>
										&nbsp&nbsp|&nbsp&nbsp${dto.eqId }&nbsp&nbsp&nbsp
										<a href="javascript:deleteData('${dto.eqcNum}','${pageNum }','${dto.eqNum }');">
										<img src='/ticketfactory/resources/image/btn_del_reply.png' 
										align='absmiddle' border='0'>
										</a>
									</td>
								</tr>
								<tr>
									<td colspan='2' style='font-size:14px; height:14px; 
									padding-top:5px; color:#4c4c4c; font-weight:500;
									padding-bottom: 12px; 
									line-height:18px;' align="left">${dto.eqcContent }
									</td>
								</tr>
								
								<tr>
									<td colspan="2" bgcolor="#dedede" height="1"></td>
								</tr>

									</c:forEach>
							
									<tr height="30">
										<td align="center" colspan="2">${pageIndexList}
										</td>
									</tr>
								
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
			</c:if>
<br/><br/>
</body>
</html>