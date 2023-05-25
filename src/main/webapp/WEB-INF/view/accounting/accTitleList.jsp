<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		
		
		
		<!-- 갯수가 0인 경우  -->
		<c:if test="${counthnoticelist eq 0}">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<!-- 갯수가 있는 경우  -->
		<c:if test="${counthnoticelist > 0}">
		
			<c:forEach items="${listAccTitle}" var="list">			
					<tr>
						<td>${list.bacc_code}</td>
						<td>${list.bacc_name}</td>
						<td>${list.dacc_code}</td>
						<td><a href="javascript:fn_selectAccTitle('${list.dacc_code}','${list.bacc_code}')">${list.dacc_name}</a></td>
						<td>${list.detail_name}</td>
						<td>${list.dacc_detail}</td>
						<td>${list.use_yn}</td>
				</tr>
			</c:forEach>
		</c:if>
		

        <input type="hidden" id="counthnoticelist" name="counthnoticelist" value="${counthnoticelist}"/>
		<input type="hidden" name="Saccall" id="Saccall" value="">
		<input type="hidden" name="Saccdall" id="Saccdall" value="">
		<input type="hidden" name="SR_F" id="SR_F" value="">
		<input type="hidden" name="S_daccT" id="S_daccT" value="">










