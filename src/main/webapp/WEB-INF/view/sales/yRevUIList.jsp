<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>


<!-- 집계기간:직접입력 
년도별 재정정보 테이블 -->
<table class="col">
	<colgroup>
		<col width="6%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"></th>
			<c:forEach items="${listYSalesModel}" var="list">
				<th scope="col">${list.est_odate}년</th>
<!--  				<script> -->
<%-- //  					dateArr.push("${list.est_odate}"); --%>
<!--  				</script>   -->
			</c:forEach>
		</tr>
	</thead>
	<tbody id="listyyRevenue">
		<tr>
			<th scope="col">주문건수</th>
			<c:forEach items="${listYSalesModel}" var="list">
				<td><fmt:formatNumber value="${list.orderCnt}" pattern="#,###"/></td>
			</c:forEach>
		</tr>
		<tr>
			<th scope="col">당기순이익</th>
			<c:forEach items="${listYSalesModel}" var="list">
				<td><fmt:formatNumber value="${list.net_profit}" pattern="#,###"/></td>
			</c:forEach>
		</tr>
		<tr>
			<th scope="col">매출</th>
			<c:forEach items="${listYSalesModel}" var="list">
				<td><fmt:formatNumber value="${list.sum_sales}" pattern="#,###"/></td>
			</c:forEach>
		</tr>
		<tr>
			<th scope="col">전년대비매출성장률</th>
			<c:forEach items="${listYSalesModel}" var="list">
				<c:choose>
					<c:when test="${list.sales_growth gt 0}">
						<td><span style="color: blue">▲${list.sales_growth}%</span></td>
					</c:when>
					<c:when test="${list.sales_growth le 0}">
						<td><span style="color: red">▼${-list.sales_growth}%</span></td>
					</c:when>
				</c:choose>
			</c:forEach>
		</tr>
		<tr>
			<th scope="col">전년대비순이익성장률</th>
			<c:forEach items="${listYSalesModel}" var="list">
				<c:choose>
					<c:when test="${list.profit_growth gt 0}">
						<td><span style="color: blue">▲${list.profit_growth}%</span></td>
					</c:when>
					<c:when test="${list.profit_growth le 0}">
						<td><span style="color: red">▼${-list.profit_growth}%</span></td>
					</c:when>
				</c:choose>
			</c:forEach>
		</tr>
	</tbody>
</table>
