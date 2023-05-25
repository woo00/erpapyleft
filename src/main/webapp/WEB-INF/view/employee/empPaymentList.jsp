<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${totalcnt eq 0 }">
	<tr>
		<td colspan="14">검색 결과가 존재하지 않습니다.</td>
	</tr> 
</c:if>
<c:if test="${totalcnt gt 0 }">
	<c:forEach items="${lists }" var="item">
		<tr onclick="fn_showPayDetailInfo('${item.loginID }')">	
			<td>${item.psal_date }</td>
			<td>${item.dep_name }</td>
			<td>${item.grade_name }</td>
			<td>${item.loginID }</td>
			<td>${item.name }</td>
			<td>${item.an_salary }</td>
			<td>${item.salary }</td>
			<td style="color: red;">${item.ip }</td>
			<td style="color: red;">${item.hi }</td>
			<td style="color: red;">${item.ii }</td>
			<td style="color: red;">${item.ei }</td>
			<td style="color: red;">${item.it }</td>
			<td style="color: green;">${item.act_salary }</td>
			<c:if test="${item.pay_yn eq 'Y'}">
				<td><a style="cursor: pointer" id="lump_sum_Payment" class="btnType3 color1"><span>지급완료</span></a></td>
			</c:if>
			<c:if test="${item.pay_yn eq 'N'}">
				<td><a id="lump_sum_Payment" class="btnType3 color2" href="" onclick="selEmpPayment('${item.loginID }', event)"><span>지급하기</span></a></td>
			</c:if>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalcnt" value="${totalcnt }"/>



<!-- 	
	<tr>
		<td colspan="10">조회할 사원을 선택해 주세요.</td>
	</tr> 
-->