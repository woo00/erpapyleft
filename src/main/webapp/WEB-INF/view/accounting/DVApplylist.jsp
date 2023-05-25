<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${dvListcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${dvListcnt > 0 }">
								<c:forEach items="${dvList}" var="list">
									<tr>
										<td><a href="javascript:fPopModalEmpDv('${list.dv_code}')">B-${list.dv_code}-${list.dv_date}</a></td>
										<td>${list.bacc_name}</td>
										<td>${list.dacc_name}</td>
										<td>${list.biz_name}</td>
										<td>${list.dv_date}</td>
										<td>${list.dv_udate}</td>
										<td><fmt:formatNumber value="${list.dv_fee}" pattern="#,###"/></td>
										<c:if test="${list.dv_sign eq 3}">
											<td>승인대기중</td>
											</c:if>
											<c:if test="${list.dv_sign eq 1}">
											<td>승인</td>
											</c:if>
											<c:if test="${list.dv_sign eq 2}">
											<td>반려</td>
										</c:if>
										<td>${list.signName}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="dvListcnt" name="dvListcnt" value ="${dvListcnt}"/>
							<input type="hidden" id="hdvListcnt" name="hdvListcnt" value ="${dvListcnt}"/>