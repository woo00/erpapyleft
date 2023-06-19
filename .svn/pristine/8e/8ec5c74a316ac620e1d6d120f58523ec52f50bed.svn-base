<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${countListEmp eq 0 }">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${countListEmp > 0 }">
	<c:forEach items="${empList}" var="list">
		<tr>
			<td><a href="javascript:fn_detailone(${list.loginID},${list.file_code})">${list.loginID}</a></td>
			<td>${list.name}</td>
			<td>${list.department}</td>
			<td>${list.rank}</td>
			<td>${list.regdate}</td>
			<!-- 재직구분 -->
			<c:choose>
				<c:when test="${list.leave_state == 'N'}">
					<td>재직</td>
				</c:when>
				<c:when test="${list.leave_state== 'Y'}">
					<td>퇴직</td>
				</c:when>
			</c:choose>
			<!-- 조건에 따른 퇴직처리 & 퇴사일자 출력 -->
			<c:choose>
				<c:when test="${list.leave_date == null || list.leave_date == ''}">
					<td><a href="javascript:fn_outEmp('${list.loginID}','${list.regdate}','${list.name}')" id="outEmp" class="btnType3 color1"><span>퇴사처리</span></a></td>
				</c:when>
				<c:when test="${list.leave_date != null || list.leave_date != ''}">
					<td>${list.leave_date}</td>
				</c:when>
			</c:choose>
			<td><a href="javascript:deleteEmp('${list.loginID}',${list.file_code})" id="deleteEmp" class="btnType3 color1"><span>삭제</span></a></td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="countListEmp" name="countListEmp" value="${countListEmp}" />
<input type="hidden" id="maxNum" name="maxNum" value="${maxNum}" />