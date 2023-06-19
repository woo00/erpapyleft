<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${use_leave eq 0 }">
		<tr>
			<td colspan="8">신청하신 휴가가 없습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${use_leave > 0 }">
		<c:forEach items="${leave_date}" var="list">
			<tr onclick="vadetail('U','${list.va_code}' ,'${list.sign_yn}')">
				<td>${list.va_code}</td>
				<td>${list.va_name}</td>
				<td>${list.st_date}</td>
				<td>${list.ed_date}</td>
				<td>${list.use_date}</td>
				<c:if test="${ list.sign_yn eq 'W'}">
					<td> - </td>
				</c:if>
				<c:if test="${ list.sign_yn eq 'Y' or list.sign_yn eq 'N'}" >
					<td>${list.use_loginID}</td>
				</c:if>
				<td>${list.va_state}</td>
				<c:if test="${ list.sign_yn eq 'W'}">
					<td> - </td>
				</c:if>
				<c:if test="${ list.sign_yn eq 'Y' or list.sign_yn eq 'N'}" >
					<td><a href="javascript:result('${list.sign_yn}')"  ><span>결과보기</span></td>
				</c:if>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="vacnt" name="vacnt" value ="${use_leave}"/>