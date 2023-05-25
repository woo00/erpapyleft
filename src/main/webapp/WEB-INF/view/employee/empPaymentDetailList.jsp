<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${totalcnt eq 0 }">
	<tr>
		<td colspan="10">검색 결과가 존재하지 않습니다.</td>
	</tr> 
</c:if>
<c:if test="${totalcnt gt 0 }">
	<c:forEach items="${lists }" var="item">
		<tr>	
			<td>${item.psal_date }</td>
			<td>${item.sal_date }</td>
			<td>${item.an_salary }</td>
			<td>${item.salary }</td>
			<td>${item.ip }</td>
			<td>${item.hi }</td>
			<td>${item.ii }</td>
			<td>${item.ei }</td>
			<td>${item.it }</td>
			<td>${item.act_salary }</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="dtotalcnt" value="${totalcnt }"/>

<input type="hidden" id="_loginID" value="${emp.loginID }"/>
<input type="hidden" id="_name" value="${emp.name }"/>
<input type="hidden" id="_department" value="${emp.department }"/>
<input type="hidden" id="_rank" value="${emp.rank }"/>