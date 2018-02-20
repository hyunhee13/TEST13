<%@ page contentType="text/html; charset=UTF-8"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title> -->
</head>
<body>
	<div id="price_option_${count }">
		<table width="450px" id="vertual_cart_table" border="0" cellpadding="0"
			cellspacing="0" style="clear: both; ">
			<tbody>
				<tr>
					<td style="height: 10px;"></td>
				</tr>
				<tr>
					<td style="padding-left: 10px; border: 1px solid #ddd;"
						bgcolor="#ffffff">

						<table  border="0" cellpadding="0" cellspacing="0" >
							<tbody>
								<tr style="padding-bottom: 3;">
									<td width="220"
										style="padding: 10px 5px 10px 0; font-size: 11px; letter-spacing: -0.5px; line-height: 150%; color: #555; border-right: 0px;">
										
										<input type="hidden" value="${price}" name="fixedPrice${count}" id="fixedPrice${count}">
										<input type="hidden" value="${capacity_num}" name="fixedCapacity_num${count}" id="fixedCapacity_num${count}">
										
										<input type="hidden" value="${date }" name="bookDate${count}" id="bookDate${count}">
										<input type="hidden" value="${time}" name="showTime${count}" id="showTime${count}">
										<input type="hidden" value="${seat }" name="seat${count}" id="seat${count}">
										<input type="hidden" value="${seat_num }" name="seat_num${count }" id="seat_num${count }">
										
											<%-- <fmt:parseNumber var="hiddenPrice" value="${price/100*70 }"/> --%>
										<input type="hidden" value="${price}" name="bookPrice${count}" id="bookPrice${count}">
										<input type="hidden" value="${capacity_num }" name="capacity_num${count}" id="capacity_num${count}">
										
										<font style="font-family: 맑은 고딕; font-size: 11pt;">${date}[${day}] &nbsp;${time}[${seat}]</font>
									</td>
									<td width="85" style="padding: 9px 0 9px 0; border-bottom: 0px;">
										<table cellspacing="0">
											<tbody>
												<tr>
													<td style="border-right: 0px; border-bottom: 0px;"><a href="javascript:void(0);"
														onclick="quantity_minus(${count});" id="minus${count}">
															<img src="resources/image/btn_cart_minus.gif" border="0"
															align="absmiddle" alt="-">
													</a></td>
													<td style="padding: 0 4px 0 4px; border-bottom: 0px;"><input type="text"
														id="bookSu${count}" name="bookSu${count}" value="1" onblur="onblur_quantity(${count})"
														class="inputstyle"
														style="width: 26px; height: 15px; text-align: center;"></td>
													<td style="border-bottom: 0px; padding-left: 0px;"><a href="javascript:void(0);"
														onclick="quantity_plus(${count});" id="plus${count}">
															<img src="resources/image/btn_cart_plus.gif" border="0"
															align="absmiddle" alt="+">
													</a></td>
													<td style="padding-left: 3px; border-bottom: 0px;">매</td>
												</tr>
											</tbody>
										</table>
									</td>
									<td align="right"
										style="padding-right: 3px; letter-spacing: -0.5px; color: #555; border-bottom: 0px;"
										width="120">
										<span id="bookPrice_show${count }" >
				
												${price }원
										</span>
									</td>
										
										
										
									<td width="17" style="border-bottom: 0px;"><a href="javascript:void(0);"
										onclick="delForm(${count});" id="delete_btn${count }">
										<img src="resources/image/btn_cart_del.gif" border="0"
											align="absmiddle" alt="삭제" style="padding-left: 3px;">
									</a></td>
									<td width="7" style="border-bottom: 0px;">&nbsp;</td>
								</tr>
								<tr>
									<td style="background-color: #ddd; height: 1px;" colspan="8">
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>