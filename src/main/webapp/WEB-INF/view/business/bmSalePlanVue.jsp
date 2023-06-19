<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">



#bmSalePlanHeader li{
	float: left;
	width : 180px;
	margin-right : 20px;
	margin-bottom : 10px;
}


</style>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 그룹코드 페이징 설정
	var pageSizeBmSalePlan = 10;
	var pageBlockSizeBmSalePlan = 5;

	
	/** OnLoad event */ 
	
	$(function() {
		
		// 공통코드 comcombo 사용방법
		// Group Code, Combo Name, Option("all" : 전체 / "sel" : 선택 )
		// l : 대분류, m : 소분류, p: 제품
       
		//-조회 셀렉박스-
        productCombo("l", "plall", "all", "", "",  "");  // 제품 대분류 코드
        
        $("#plall").change(function() {
           productCombo("m", "pmall", "all", $("#plall").val(), "",  "");  // 제품 소분류
           $("#divproducttall").children('option:not(:first)').remove();   // 제품 옵션 전부 삭제
        });
        
        $("#pmall").change(function() {
           productCombo("p", "divproducttall", "all", $("#plall").val(), $("#pmall").val(),  "");  // 제품 목록
        });
        
		
		// 영업실적조회 함수 호출
		fn_bmPlanList();
		

	});
	

	
	/** 영업실적 조회 */
	function fn_bmPlanList(cpage) {
		
		cpage = cpage || 1;
		
		var param = {
					cpage : cpage,
					pageSize    : pageSizeBmSalePlan,
					loginID_search	: $("#loginID_header").val(),			//검색할 로그인아이디
					prolall	: $("#plall").val(),			//대분류명
					promall	: $("#pmall").val(),			//소분류명
					prodall	: $("#divproducttall").val(),	//제품명
					sp_date : $("#sales_reg_date").val()	//계획등록일
		}
		
		console.log(param);
		
		
		var resultCallback = function(data) {
			console.log("data:                  " + data);
			fn_bmPlanListResult(data, cpage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/business/bmPlanList.do", "post", "text", false, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function fn_bmPlanListResult(data, cpage) {
		
		//alert(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listBmSalePlan').empty();
		
		// 신규 목록 생성
		$("#listBmSalePlan").append(data);
		
		// 총 개수 추출
		var totalCntBmSalePlan = $("#bmplanCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(
												cpage, 
												totalCntBmSalePlan, 
												pageSizeBmSalePlan, 
												pageBlockSizeBmSalePlan, 
												'fn_bmPlanList'
												);
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#bmSalePlanPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageBmSalePlan").val(cpage);
	
		console.log("totalCntBmSalePlan : " + totalCntBmSalePlan);
	}
	
	



</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageBmSalePlan" value="1">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="loginId" id="loginId" value="${loginId}">
	<input type="hidden" name="userType" id="userType" value="${userType}">
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">영업</a> <span class="btn_nav bold">영업실적조회</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>


						<p class="conTitle">
							<span>영업실적조회</span> <span class="fr">
							  <a class="btnType blue"
										href="javascript:fn_bmPlanList()" name="search"><span
										id="searchEnter">조회</span></a><br/>
							</span>
						</p>


						<div id = "bmSalePlanHeader">
							<ul>	
							<c:if test="${userType eq 'B'}">
								<li>
									<strong>아이디</strong>
										<input type="text" class="inputTxt p100" 
										name="loginID_header" id="loginID_header"/>	
								</li>
							</c:if>	
								<li>
									<strong>대분류명</strong>
									<select id="plall" name="plall">
									</select>
								</li>	
								<li>
									<strong>소분류명</strong>
									<select id="pmall" name="pmall">
									</select>
								</li>	
								<li>
									<strong>제품명</strong>
									<select id="divproducttall" name="divproducttall">
									</select>
								</li>	
								<li>
									<strong>계획등록일</strong>
									<input type = "date"
									id="sales_reg_date" 
									style="width: 180px; height: 30px;">
								</li>	
							</ul>
						</div>
						
						<div class="divBmSalePlanList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
										<col width="*%">
									<c:if test="${userType eq 'B'}">
										<col width="*%">
									</c:if>
										<col width="*%">
										<col width="*%">
										<col width="*%">
										<col width="*%">
										<col width="*">
									<c:if test="${userType eq 'B'}">	
										<col width="*">
									</c:if>	
										<col width="*%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">계획등록일</th>
									<c:if test="${userType eq 'B'}">
										<th scope="col">아이디</th>
									</c:if>
										<th scope="col">대분류명</th>
										<th scope="col">소분류명</th>
										<th scope="col">제품명</th>
										<th scope="col">목표수량</th>
										<th scope="col">실적수량</th>
									<c:if test="${userType eq 'B'}">	
										<th scope="col">달성률(%)</th>
									</c:if>	
									</tr>
								</thead>
								<tbody id="listBmSalePlan"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="bmSalePlanPagination"> </div>
	
					

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>