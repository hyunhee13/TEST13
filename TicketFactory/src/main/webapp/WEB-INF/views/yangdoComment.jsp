<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int i = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ydcComment</title>


</head>
<body>

<%-- 		<c:if test="${dataCount!=0 }">
			<table cellspacing=0 style='width:100%; border-top:1px solid #e8e8e8;'>
				
				<tr>
					<td style="padding:5px 5px 10px 5px;">
						<table cellspacing=0 style="width:100%;">
						
							<tr>
								<td align="left">
									<table cellspacing="0" style="width:100%;">
										
										
										<c:forEach var="dto" items="${lists }">
										
										<tr>
											<td style="font-size:12px; height:14px; color:#a3a3a3; padding-top:10px; padding-bottom: 12px;" align='left'>
																					
												<c:if test="${dto.ydcDepth!=0}">
													<c:forEach var="n" begin="1" end="${dto.ydcDepth}" step="1">
														&nbsp;
													</c:forEach>
													&nbsp;&nbsp;&nbsp;└
												</c:if>

												<span style='color:#1e6ec9;'>아이디</span>
												<font color="#000000";>&nbsp;&nbsp;&nbsp;${dto.ydcId }&nbsp;&nbsp;&nbsp;</font>
												<a href="javascript:deleteData('${dto.ydcNum}','${pageNum }','${dto.ydNum }');">
													<img src='/ticketfactory/resources/image/btn_del_reply.png' 
													align='absmiddle' border='0'>
												</a>
												<a href="javascript:reply('${dto.ydcNum}');">
													&nbsp;&nbsp;&nbsp;답글
													<input type="hidden" value="${dto.ydcNum}" name="reNum" id="reNum${dto.ydcNum}">
												</a>
												
											</td>
											
											
											
											<td style="font-size:12px; height:14px; color:red; padding-top:5px; padding-bottom: 12px;" align="right">
											작성일 : ${dto.ydcCreated }
											</td>
											
										</tr>
										
										<tr>
											<td colspan='3' style='font-size:12px; height:14px; 
											padding-top:5px; color:#4c4c4c; font-weight:normal;
											padding-bottom: 12px; 
											line-height:18px;' align="left">${dto.ydcContent }
											</td>
										</tr>
										
										<tr>
											<td colspan="3" bgcolor="#dedede" height="1"></td>
										</tr>
										
										<tr>
											<td colspan="3">
												<div style="display: none;" id="replymode${dto.ydcNum}">
												<%@ include file="yangdoReply.jsp" %></div>
												
											</td>
										</tr>
										
										<input type="hidden" value="${dto.ydcNum}" name="ydcNum" id="ydcNum">
								
										</c:forEach>

								
										<tr height="30">
											<td align="center" colspan="3">${pageIndexList}
											</td>
										</tr>
										

									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</c:if> --%>
		
		
		<c:if test="${dataCount!=0 }">
			<table cellspacing=0 style='width:100%; border-top:1px solid #e8e8e8;'>
				
				<tr>
					<td style="padding:5px 5px 10px 5px;">
						<table cellspacing=0 style="width:100%;">
						
							<tr>
								<td align="left">
									<table cellspacing="0" style="width:100%;">
										
										
										<c:forEach var="dto" items="${lists }">
										
										<tr>
											<td style="font-size:12px; height:14px; color:#a3a3a3; 
											padding-top:10px; padding-bottom: 12px; padding-left: 5px;" align='left'>
																					
												<c:if test="${dto.ydcDepth!=0}">
													<c:forEach var="n" begin="1" end="${dto.ydcDepth}" step="1">
														&nbsp;
													</c:forEach>
													<font size="2px;" color="#000000">&nbsp;&nbsp;&nbsp;└&nbsp;&nbsp;</font>
												</c:if>

												<span style='color:#1e6ec9;'>아이디</span>
												<font color="#000000";>&nbsp;&nbsp;&nbsp;${dto.ydcId }&nbsp;&nbsp;&nbsp;</font>
												<a href="javascript:deleteData('${dto.ydcNum}','${dto.ydcId }','${dto.ydNum }');">
													<img src='/ticketfactory/resources/image/btn_del_reply.png' 
													align='absmiddle' border='0'>
												</a>
												<a href="javascript:reply('${dto.ydcNum}');">
													&nbsp;&nbsp;&nbsp;답글
													<input type="hidden" value="${dto.ydcNum}" name="reNum" id="reNum${dto.ydcNum}">
												</a>

												
											</td>
											
											
											
											<td style="font-size:12px; height:14px; color:red; padding-top:5px; padding-bottom: 12px;" align="right">
											작성일 : ${dto.ydcCreated }
											</td>
											
										</tr>
										
										<tr>
											<td colspan='3' style='font-size:12px; height:14px; 
											padding-top:5px; color:#4c4c4c; font-weight:normal;
											padding-bottom: 12px; 
											line-height:18px;' align="left">&nbsp;&nbsp;&nbsp;${dto.ydcContent }
											</td>
										</tr>
										
										<tr>
											<td colspan="3" bgcolor="#dedede" height="1"></td>
										</tr>
										
										<tr>
											<td colspan="3">
												<div style="display: none;" id="replymode${dto.ydcNum}">
												<%@ include file="yangdoReply.jsp" %></div>
												
											</td>
										</tr>
										
										<input type="hidden" value="${dto.ydcNum}" name="ydcNum" id="ydcNum">
										<input type="hidden" value="${dto.ydcId}" name="ydcId" id="ydcId">
										</c:forEach>

								
										<tr height="30">
											<td align="center" colspan="3">${pageIndexList}
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


</body>
</html>