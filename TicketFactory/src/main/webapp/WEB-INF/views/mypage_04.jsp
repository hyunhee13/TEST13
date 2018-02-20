<%@ page contentType="text/html; charset=UTF-8"%>
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

<img src="/ticketfactory/resources/image/title_my_qna.png" style="padding:0 0 0 2px; margin-left: 18px;" alt="구매내역">	
	<div style="float:right; padding-right:18px; padding-top: 3px;
		line-height:25px; font-size: 10pt; ">
	</div>
	<div class="mypage_main_bar"></div>
	
<!-- 구매내역 하단  -->	
<div style="width:100%; padding:0 23px 0 23px;">

<table cellpadding="0" cellspacing="0" width="750" bgcolor="#FFFFFF"  ">
	<tbody>
		<tr>
			<td>
				<table cellspacing="0" style="width:100%; margin: 0;">
				<tbody>
					<tr>
						<td >
							<table cellspacing="0" style="width:100%;">
								<tbody>
									<tr>
										<td style="width:3px;">
											<img src="/ticketfactory/resources/image/icon_table_left.gif">
										</td>
										<td style="background:url('/ticketfactory/resources/image/icon_table_center.gif') repeat-x;">
											<table cellspacing="0" style="width:100%;">
												<tbody>
													<tr>
														<td class="myTable" align="center">문의 목록</td>
														<td class="myTable" align="center" style="widows: 50px;">작성일</td>
														<td class="myTable" align="center" style="widows: 50px;">처리상태</td>
													</tr>
												</tbody>
											</table>
										</td>
										<td style="width:3px;">
											<img src="/ticketfactory/resources/image/icon_table_right.gif">
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center">
							<p style="width:100%; text-align:center; font-size:14px; padding-top:100px;">등록된 의견이 없습니다.</p> 
						</td>
					</tr>
					<tr>
						<td style="padding:30px 0 20px 0;" align="center">
							<div id="page"></div>
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