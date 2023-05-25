<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

					
					
							<c:if test="${dvtotalcnt eq 0 }">
								<tr>
									<td colspan="12">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${dvtotalcnt > 0 }">
								<c:forEach items="${bmDvlist}" var="list">
									<tr>
										<td><a href="javascript:fn_dvModal('${list.dv_code}')">B-${list.dv_code}-${list.dv_date}</a></td>				<!-- 결의번호 -->
										
										<td>${list.bacc_name}</td>
										<td>${list.dacc_name}</td>			
										<td>${list.biz_name}</td>	
										<td>${list.dv_date}</td>			
										<td>${list.dv_udate}</td>		
										<td>${list.dv_fee}</td>		
										<td>${list.detail_name}</td>				
										<td>${list.signName}</td>				
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="dvtotalcnt" name="dvtotalcnt"  value="${dvtotalcnt}"/>
							<input type="hidden" id="dvcode" name="dvcode"  value=""/>