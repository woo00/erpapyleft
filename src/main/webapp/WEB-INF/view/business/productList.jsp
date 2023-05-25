<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	#prdArea {
		height: 30px;
	    padding: 0 5px;
	    line-height: 33px;
	    border: 1px solid #bbc2cd;
	    vertical-align: middle;
	    background: #dce1e6;
	    margin-top: -30px;
}

	#dtnull {
		height : 40px;
		justify-content: center;
    	align-items: center;
    	display: flex;
	}

</style>


<c:if test="${countPrd eq 0 }">
	<div>
		<div id="prdArea"></div>
			<ul class="product_border">
				<li class="prod_item width_change" style="display: flow-root;">
					<p id="dtnull"><span>데이터가 존재하지 않습니다.</span></p>
				</li>
			</ul>
	</div>
</c:if>

<c:if test="${countPrd > 0 }">
	<c:forEach items="${prdList}" var="list">
		<ul class="product_border">
			<li class="prod_item width_change" style="display: flow-root;">
				<div class="prod_main_info">
					<div style="display: inline-flex;">
						<c:choose>
							<c:when
								test="${list.file_code != null and  list.file_code != '' and list.file_code != 0}">
								<img src="${list.rel_path}"
									style='width: 150px; height: 170px; margin-left: 30px;' />
							</c:when>
							<c:otherwise>
								<img src="../images/admin/comm/imgNull.PNG"
									style='width: 150px; height: 170px; margin-left: 30px;' />
							</c:otherwise>
						</c:choose>
						<div style="margin-left: 6%; width: 611px">
							<p class="prod_name">
								<a href="javascript:fPopModalUpdate(${list.prd_code},${list.file_code});"
									class="prod_name"> ${list.prd_name} </a> <span
									class="head_ico_wrap" style=""> </span>
							</p>
							<dl class="prod_spec_set">
								<dt class="screen_out"></dt>
								<dd style="display: flex;">
									&nbsp;
									<p style="font-weight: bold;">품번</p>
									&emsp;
									<p class="prd_code">${list.prd_code}</p>
								</dd>
								<dd style="display: flex; margin-top: 1%">
									&nbsp;
									<p style="font-weight: bold;">재고</p>
									&emsp;
									<p class="addinven">${list.addinven}</p>
								</dd>
								<dd style="display: flex; margin-top: 1%">
									&nbsp;
									<p style="font-weight: bold;">대분류명</p>
									&emsp;
									<p class="pb_name">${list.pb_name}</p>
								</dd>
								<dd style="display: flex; margin-top: 1%">
									&nbsp;
									<p style="font-weight: bold;">소분류명</p>
									&emsp;
									<p class="ps_name">${list.ps_name}</p>
								</dd>
							</dl>
						</div>

						<div class="prod_price"
							style="display: flex; align-items: center; margin-left: 15%; font-size: 17px; font-weight: bold; width: 125px;">
							<p>
								<fmt:formatNumber value="${list.sup_price}" pattern="#,###" />
								&nbsp;원
							</p>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</c:forEach>
</c:if>

<input type="hidden" id="countPrd" name="countPrd" value="${countPrd}" />
