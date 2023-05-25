<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 검색날짜의 매출목록 불러오기  -->

<c:set var="nRow" value="${pageSize*(currentPageddRevenue-1)}" />
<c:if test="${totalCntddRevenue eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:forEach items="${listDSalesModel}" var="list">
	<tr>
		<td>${list.est_odate}</td>
		<td>${list.biz_code}</td>
		<td>${list.biz_name}</td>
		<td>${list.prd_name}</td>
		<td>${list.est_ocnt}</td>
		<td><fmt:formatNumber value="${list.sup_price}" pattern="#,###" /></td>
		<td><fmt:formatNumber value="${list.sppl}" pattern="#,###" /></td>
		<td><fmt:formatNumber value="${list.tax}" pattern="#,###" /></td>
		<td><fmt:formatNumber value="${list.pay_price}" pattern="#,###" /></td>
	</tr>
	<c:set var="nRow" value="${nRow + 1}" />
</c:forEach>

<input type="hidden" id="totalCntddRevenue" name="totalCntddRevenue"
	value="${totalCntddRevenue}" />






