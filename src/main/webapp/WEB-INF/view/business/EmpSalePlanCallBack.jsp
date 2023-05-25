<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


     				<!-- tbody 제거 , comnGrpList.jsp 참고  -->
							<c:if test="${planCnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
				
							<c:if test="${planCnt > 0 }">
								<c:forEach items="${listPlan123}" var="list"  >
									<tr>
										  <td> ${list.sp_date} </td>
						                  <td> 
						                  	<a href="javascript:fn_PlanModal('${list.sp_code}')" >
						                  		<strong >${list.biz_name}</strong>
						                  	</a> 
						                  </td>
						                  <td> ${list.pb_name} </td>
			                              <td> ${list.ps_name} </td>
										  <td> ${list.prd_name} </td>
			                              <td> ${list.sp_gcnt} </td>  
			                              <td> ${list.sp_rcnt} </td>
										  <td> ${list.sp_goal} </td>
									</tr>
								</c:forEach>
							</c:if>

							<!-- 단건조회시 카운트와 연관 깊음 --> 			
							<input type="hidden"  id="planCnt"  name="planCnt"  value="${planCnt}"/> 