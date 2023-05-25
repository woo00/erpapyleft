<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${use_leave eq 0 }">
		<tr>
			<td colspan="7">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${use_leave > 0 }">
		<c:forEach items="${leave_date}" var="list">
			<tr onclick="vadetail('U','${list.va_code}')">
				<td>${list.va_code}</td>
				<td>${list.va_name}</td>
				<td>${list.st_date}</td>
				<td>${list.ed_date}</td>
				<td>${list.use_date}</td>
				<td>${list.use_loginID}</td>
				<td>${list.va_state}</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="vacnt" name="vacnt" value ="${use_leave}"/>