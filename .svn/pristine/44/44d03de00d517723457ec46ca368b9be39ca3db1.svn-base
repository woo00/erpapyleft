<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ymd" value="<%=new java.util.Date()%>" />


     				<!-- tbody 제거 , comnGrpList.jsp 참고  -->
							<c:if test="${counteoemlist eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${counteoemlist > 0 }">
								<c:forEach items="${oemlist}" var="list"  >
									<tr>
										 <!-- 날짜 누르면 readonly  -->
										 <c:if test="${list.est_eo eq 'E' }" >
									 			<td><a  href="javascript:oemdetail('${list.est_code}','E')" ><strong>${list.est_code}-${list.est_edate}-E</strong></a></td>
									 			<td><a class="btnType blue" href="javascript:newModal('${list.est_code}' ,'I');" name="modal"><span>수주서 신규등록</span></a></td>
										 </c:if>
										 <c:if test="${list.est_eo eq 'O' }" >
									 			<c:if test="${list.est_edate ne null}">
										 			<td><a  href="javascript:oemdetail('${list.est_code}','E')" ><strong>${list.est_code}-${list.est_edate}-E</strong></a></td>
										 			<td><a  href="javascript:oemdetail('${list.est_code}', 'O')" ><strong >${list.est_code}-${list.est_odate}-O</strong></a></td>
										 		</c:if>
										 		<c:if test="${list.est_edate eq null}">
										 			<td>-</td>
									 				<td><a  href="javascript:oemdetail('${list.est_code}','O')" ><strong >${list.est_code}-${list.est_odate}-O</strong></a></td>
										 		</c:if>
										 </c:if>
						                  <td> ${list.biz_name}</td>
						                  <td> ${list.prd_name} </td>
			                              <td> <fmt:formatNumber type="number" maxFractionDigits="0" value="${list.price * 1.1}" /> 원</td>
			                              <td> <fmt:formatNumber type="number" maxFractionDigits="0" value="${list.price * 0.1}" /> 원</td>
			                              <td><fmt:formatNumber type="number" maxFractionDigits="0" value="${list.price}" /> 원</td>
			                              
			
			                              
									</tr>
								</c:forEach>
							</c:if>

							<!-- 단건조회시 카운트와 연관 깊음 --> 			
							<input type="hidden"  id="counteoemlist"  name="counteoemlist"  value="${counteoemlist}"/>
							<input type="hidden"  id="est_num"  name="est_num"  value=""/>