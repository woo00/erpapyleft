<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empGradeTotalCnt eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${empGradeTotalCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(cpage-1)}" />
	<c:forEach items="${listEmployeeModel}" var="list">
		<tr>
			<td><a href="javascript:detailGrade(1, '${list.loginID}')">${list.loginID}</a></td>
			<td>${list.name}</td>
			<td>${list.dep_code}</td>
			<td>${list.POScd}</td>
			<td>${list.prm_date}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="empGradeTotalCnt" name="empGradeTotalCnt" value ="${empGradeTotalCnt}"/>