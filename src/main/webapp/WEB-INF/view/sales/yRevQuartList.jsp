<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!-- 집계기간:1-4분기 / 상하반기 
분기별 손익계산서 테이블 -->
<table class="col">
		<thead>
			<tr>
				<th scope="col" width="8%"></th>
				<c:forEach items="${listYSalesModel}" var="list">
					<th scope="col" colspan="2">${list.est_odate}</th>
				</c:forEach>
			</tr>
		</thead>
	
		<tbody id="listmmRevenue">
				<tr>
					<td>주문건수</td>
					<c:forEach items="${listYSalesModel}" var="list">
						<td>${list.orderCnt}</td>
					</c:forEach>
				</tr>
				<tr>
					<td>매출</td>
					<c:forEach items="${listYSalesModel}" var="list">
						<td><fmt:formatNumber value="${list.sum_sales}" pattern="#,###"/></td>
					</c:forEach>
				</tr>
				<tr>
					<td>영업이익</td>
				<c:forEach items="${listYSalesModel}" var="list">
						<td><fmt:formatNumber value="${list.sum_cost}" pattern="#,###"/></td>
				</c:forEach>
				</tr>
				<tr>
					<td>영업이익률</td>
				<c:forEach items="${listYSalesModel}" var="list">
					<c:choose>
					<c:when test="${list.salesProfit_rate gt 0}">
						<td colspan="2"><span style="color: blue">▲${list.salesProfit_rate}%</span></td>
					</c:when>
					<c:when test="${list.salesProfit_rate le 0}">
						<td colspan="2"><span style="color: red">▼${-list.salesProfit_rate}%</span></td>
					</c:when>
				</c:choose>
				</c:forEach>
				</tr>
		</tbody>
	</table>	
	
             
      










