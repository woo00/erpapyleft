<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

					
					
							<c:if test="${bmplanCnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${bmplanCnt > 0 }">
								<c:forEach items="${bmlistPlan}" var="list">
									<tr>					
										<td>${list.sp_date}</td>		
									<c:if test="${userType eq 'B'}">	
										<td>${list.loginID}</td>
									</c:if>						
										<td>${list.pb_name}</td>
										<td>${list.ps_name}</td>	
										<td>${list.prd_name}</td>																						
										<td>${list.sp_gcnt}</td>		
										<td>${list.sp_rcnt}</td>		
									<c:if test="${userType eq 'B'}">		
										<td>${list.sp_rate}</td>						
									</c:if>	
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="bmplanCnt" name="bmplanCnt" value="${bmplanCnt}"/>