<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
			<!-- 갯수가 0인 경우  -->
			<c:if test="${counthnoticelist eq 0}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		
			<!-- 갯수가 있는 경우  -->
			<c:if test="${counthnoticelist > 0}">
			
				<c:forEach items="${listARM}" var="list">			
					<tr>
						    <td><a href="javascript:fn_selectArm('${list.est_code}','${list.est_yn}')">${list.est_code}-${list.est_odate}-O</a> </td>
							<td>${list.biz_name}</td>
							<td>${list.psd}</td>
							<td>${list.est_odate}</td>
							<td>${list.detail_name}</td>
							<td>${list.sign_user}</td>
					</tr>
				</c:forEach>
			</c:if>
			
			
			   <input type="hidden" id="counthnoticelist" name="counthnoticelist" value="${counthnoticelist}"/>