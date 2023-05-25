<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   <c:set var = "dv_amt_sum" value = "0" />
						   <c:set var = "en_amt_sum" value = "0" />
							<c:if test="${countaccslipflist eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>

							<c:forEach items="${accslipfmodal}" var="list">
									<tr>
										<td>${list.fnl_code}</td>					<!-- 전표번호 --> 
										<td>${list.bacc_name}</td>				<!-- 계정과목  -->
										<td>${list.dv_ep}</td>					<!-- 지출  -->
										<td>${list.dv_fee}</td>				<!-- 수입  -->
									</tr>
								<c:set var= "dv_amt_sum" value="${dv_amt_sum + list.dv_ep}"/>
								<c:set var= "en_amt_sum" value="${en_amt_sum + list.dv_fee}"/>
							</c:forEach>
                           <input type="hidden" id="inamt" name="inamt" value="${dv_amt_sum}"/>
                          <input type="hidden" id="outamt" name="outamt" value="${en_amt_sum}"/>
						<input type="hidden" id="countaccslipflist" name="countaccslipflist" value="${countaccslipflist}"/>
                          