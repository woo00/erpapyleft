<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${bizPartnerCnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${bizPartnerCnt > 0 }">
								<c:forEach items="${bizPartnerlist}" var="list">
									<tr>
										<td>${list.biz_code}</td>
										<td><a href="javascript:fn_detailone('${list.biz_code}' ,1)">${list.biz_name}</a></td>
										<td>${list.biz_addr}</td>
										<td>${list.biz_hp}</td>
										<td>${list.biz_iname}</td>
										<td>${list.biz_phone}</td>
										<td>${list.biz_email}</td>
										<td>${list.biz_memo}</td>
									</tr>
								</c:forEach>
							</c:if>
							<input type="hidden" id="bizPartnerCnt" name="bizPartnerCnt" value ="${bizPartnerCnt}"/>