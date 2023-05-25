<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${countempTalist eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							 
							<c:if test="${countempTalist > 0 }">
								<c:forEach items="${empTalist}" var="list">
									<tr>
										<td>${list.va_code}</td>
										<td><a href="javascript:fn_detail('${list.va_code}');">${list.loginID}</a></td>
										<td>${list.name}</td>
										<td>${list.va_name}</td>
										<td>${list.st_date}</td>
										<td>${list.ed_date}</td>
										<td>${list.app_date}</td>
										<td>${list.sign_username}</td>
										<td>${list.sign_ynname}</td>
									</tr>
								</c:forEach>
							</c:if>
							 
							<input type="hidden" id="countempTalist" name="countempTalist" value ="${countempTalist}"/>
							<input type="hidden" name="hstdate" id="hstdate" value="">
							<input type="hidden" name="heddate" id="heddate" value="">
							<input type="hidden" name="hnumber" id="hnumber" value="">
							<input type="hidden" name="hname" id="hname" value="">
							<input type="hidden" name="hsign" id="hsign" value="">