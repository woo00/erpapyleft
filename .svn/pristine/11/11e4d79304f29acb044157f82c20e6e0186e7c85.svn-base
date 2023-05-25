<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${countaccslipflist eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${countaccslipflist > 0 }">
								<c:set var="nRow" value="${requestScope.pageSize*(requestScope.cpage-1)}" /> 
								<c:forEach items="${accslipflist}" var="list">
									<tr>
										<td>${accSlipCnt +nRow +1}</td>  
										<td>${list.bacc_code}</td>
										<td>${list.bacc_name}</td>
										<td>${list.dv_ep}</td>
										<td>${list.dv_fee}</td>

									</tr>
									 	<c:set var="nRow" value="${nRow + 1}" /> 
								</c:forEach>
							</c:if>
						<input type="hidden" id="countaccslipflist" name="countaccslipflist" value="${countaccslipflist}"/>
							