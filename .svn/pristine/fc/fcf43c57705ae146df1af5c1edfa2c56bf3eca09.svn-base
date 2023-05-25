<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!--검색날짜 매출 손익통계 -->

<c:forEach items="${listDaySalesSumModel}" var="list">
	<fmt:parseNumber value="${list.salesProfit_rate}" var="salesProfit_rate" />
	<c:set var="salesProfit_rate" value="${salesProfit_rate}" />
		<tr>
			<td rowspan="2" width="9%">매출</td>
			<td width="13%">매출</td>
			<td><fmt:formatNumber value="${list.sum_sales}" pattern="#,###"/></td>
		</tr>
		<tr>
			<td>미수금</td>
			<td><fmt:formatNumber value="${list.sum_ar}" pattern="#,###"/></td>
		</tr>
		<tr>
			<td>비용</td>
			<td>매출원가</td>
			<td><fmt:formatNumber value="${list.sum_cost}" pattern="#,###"/></td>
		</tr>
		<tr>
			<td rowspan="2">순이익</td>
			<td>매출총이익</td>
			<td><fmt:formatNumber value="${list.margin}" pattern="#,###"/></td>
		</tr>
		<tr>
			<td>영업이익률</td>
			<c:choose>
				<c:when test="${list.salesProfit_rate>0}">
					<td><span style="color: red">▲${list.salesProfit_rate}%</span></td>
				</c:when>
				<c:when test="${salesProfit_rate<0}">
					<td><span style="color: blue">▼${-list.salesProfit_rate}%</span></td>
				</c:when>
				<c:otherwise>
					<td>${salesProfit_rate}</td>
				</c:otherwise>
			</c:choose>
		</tr>
</c:forEach>





