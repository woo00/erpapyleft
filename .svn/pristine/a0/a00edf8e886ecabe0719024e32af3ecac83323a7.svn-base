<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<!-- 월별 손익통계 테이블 -->
			<colgroup>
				<col width="10%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col"></th>
						<c:forEach items="${listMSalesModel}" var="list">
					<th scope="col">${list.est_odate}</th>
						</c:forEach>
				</tr>
			</thead>
			<tbody>
			<tr>
					<th scope="row">주문건수</th>
						<c:forEach items="${listMSalesModel}" var="list">
							<td><fmt:formatNumber value="${list.orderCnt}" pattern="#,###"/></td>
						</c:forEach>
				</tr>
				<tr>
					<th scope="row">매출</th>
						<c:forEach items="${listMSalesModel}" var="list">
							<td><fmt:formatNumber value="${list.sum_cost}" pattern="#,###"/></td>
						</c:forEach>
				</tr>
				<tr>
					<th scope="row">매출원가</th>
						<c:forEach items="${listMSalesModel}" var="list">
							<td><fmt:formatNumber value="${list.tax}" pattern="#,###"/></td>
						</c:forEach>
				</tr>
				<tr>
					<th scope="row">매출총이익</th>
						<c:forEach items="${listMSalesModel}" var="list">
							<td><fmt:formatNumber value="${list.margin}" pattern="#,###"/></td>
						</c:forEach>
				</tr>
			</tbody>
