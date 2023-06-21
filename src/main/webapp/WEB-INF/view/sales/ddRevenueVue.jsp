<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 일별매출현황</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>
.divddRevenueSumList {
	postion:'absolute';
	padding:20px;
	float:'left';
}
</style>
<script>
	/*그래프 데이터 변수 선언*/
	var dateArr = new Array();  //일별날짜
	var salesArr = new Array();  //매출
	var cumsalesArr = new Array(); //매출총이익
</script>
<c:forEach items="${listDaySalesChartModel}" var="list">
	<script>
		dateArr.push("${list.order_date}");
		salesArr.push("${list.sum_sales}");
		cumsalesArr.push("${list.cumsum_sales}");
	</script>
</c:forEach>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript">
google.charts.load('current', {packages: ['corechart']});
google.charts.setOnLoadCallback(drawChart);

	// 일별매출 페이징 설정
	var pageSize = 5;
	var pageBlock = 5;
	
	var container;
	var divddRevenueList;
	
	$(function(){
		document.getElementById('searchDate').valueAsDate = new Date();
		init();
		//거래처 콤보박스
		selectComCombo("cli", "deptall", "all", "","");  
		// 버튼 이벤트 등록 (조회)
		fButtonClickEvent();
		board_search()
// 		board_search_sum()
		viewddChart()
	});
	
	function init(){
		container = new Vue({
			el : "#container",
			data :{
				grouplist : [],
				searchKey : $("#deptall option:selected").val(),
				searchDate : $("#searchDate").val(),
				pageSize :pageSize,
				totalCount :0,
				pageNavi: ""
			},
			methods : {
				setGrid : function(test){
					board_search(test);
				}
			}
		});
	}
	
	/** 1일 전 날짜 출력 */
	function beforeday() {
		var searchDate = $("#searchDate").val();
		var newday = "";

		var datearr = searchDate.split("-");

		var currdate = new Date(datearr[0], datearr[1], datearr[2]);
		currdate.setDate(currdate.getDate() - 1);

		var y = currdate.getFullYear();
		var m = currdate.getMonth();
		var d = currdate.getDate();

		if (m < 10) {
			m = "0" + m;
		}//if
		if (d < 10) {
			d = "0" + d;
		}//if
		newday = y + "-" + m + "-" + d;

		$("#searchDate").val(newday);
	}

	/** 1일 후 날짜 출력 */
	function nextday() {
		var searchDate = $("#searchDate").val();
		var newday = "";

		var datearr = searchDate.split("-");

		var currdate = new Date(datearr[0], datearr[1], datearr[2]);
		currdate.setDate(currdate.getDate() + 1);

		var y = currdate.getFullYear();
		var m = currdate.getMonth();
		var d = currdate.getDate();

		if (m < 10) {
			m = "0" + m;
		}//if
		if (d < 10) {
			d = "0" + d;
		}//if
		newday = y + "-" + m + "-" + d;

		$("#searchDate").val(newday);
	}
	
	/* 날짜포맷 yyyy-MM-dd 변환  */
    function getFormatDate(date){
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        month = month >= 10 ? month : '0' + month;
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;
        return year + '-' + month + '-' + day;
    }

	/* 버튼 이벤트 등록 - 조회  */
	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
					
			var btnId = $(this).attr('id');
			
			//alert("btnId : " + btnId);
			
			switch(btnId){
			case 'btnSearch' :
				board_search();  // 매출목록
// 				board_search_sum();  //손익통계 테이블
				viewddChart();  //손익통계 차트
				break;
			}
		});
	}
	
	// 일별매출목록 검색기능
	function board_search(currentPage){
		currentPage = currentPage || 1;
		console.log("날짜를 대라 : " + container.searchDate);
		var param = {
				searchKey : container.searchKey,
				searchDate : container.searchDate,
				pageSize : pageSize,
				currentPage : currentPage
		}
		
		var listCallback = function(returndata){
			
			fnSetGrid(returndata, currentPage);
			
		}
		callAjax("/sales/listDaySalesVue.do", "post", "json", true, param, listCallback);
	}
	
	function fnSetGrid(data, currentPage){
		console.log("returndata: " + JSON.stringify(data));
		
		container.grouplist = data.listDSalesModel;
//			console.log(returndata.listDSalesModel);
//			console.log(container.grouplist);
		container.totalCount = data.totalCount;
		
		
		var paginationHtml = getPaginationHtml(currentPage, container.totalCount, pageSize, pageBlock, 'board_search');
		
		container.pageNavi = paginationHtml;
	}
	
	// 일별매출 합계 조회기능
	
	// 차트
		function viewddChart() {
		var searchDate = $('#searchDate').val();
		var strArr = searchDate.split('-');
		var oneMonthAgo_ = new Date(strArr[0], strArr[1]-1, strArr[2]);
		oneMonthAgo_ = new Date(oneMonthAgo_.setMonth(oneMonthAgo_.getMonth() - 1));	// 한달 전
		var oneMonthAgo = getFormatDate(oneMonthAgo_);

		var param = {
				searchDate : searchDate,  //검색 날짜
				oneMonthAgo: oneMonthAgo  //한달전 날짜
		}/**끝*/

		var resultCallback = function(data) {
			showChart(data);
			console.log(data);
		}

		callAjax("/sales/viewDaySalesChart.do", "post", "text", true, param,
				resultCallback);

	}
	
	function showChart(data) {
		// 기존 목록 삭제
		$('#chart_div').empty();

		// 신규 목록 생성
		$('#chart_div').append(data);
	}
function drawChart() {
	
	var data = new google.visualization.DataTable();
	data.addColumn('string','Date');
	data.addColumn('number','매출');
	data.addColumn('number','누적매출');
	
	for(var i=0;i<dateArr.length;i++){
		data.addRow([dateArr[i].substring(2),parseInt(salesArr[i]),parseInt(cumsalesArr[i])]);
	}
	var options = {
			legend: {'position':'top','alignment':'center'},
            height:400,
            label:'top',
            hAxis: {showTextEvery: 1,
            	fontSize:'5',
            	slantedText: true,
            	slantedTextAngle:45}, 
            vAxes: {0: {
            	title:'단위:십만원'
            }, 
            1: {
            	title:'단위:십만원'
            }},
            chartArea : {
				height: '70%',
				width : '60%'
			},
			animation : { //차트가 뿌려질때 실행될 애니메이션 효과
				startup : true,
				duration : 1000,
				easing : 'linear'
			},
			seriesType : 'bars',
			color:'red',
			series : {1: {type:'line',
						  targetAxisIndex: 1,
						  color:'red'}}
          };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));

    chart.draw(data, options);
	}
</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageddRevenue" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="tmpGrpCod" value="">
	<input type="hidden" id="tmpGrpCodNm" value="">
	<input type="hidden" name="action" id="action" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"/> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
					
						<!-- 최상단 집/매출/일별매출현황 -->
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">매출</span> 
							<span class="btn_nav bold">일별매출현황</span> 
							<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<!-- 일별매출현황 제목 -->
						<p class="conTitle">
							<span>일별매출현황</span> <span class="fr"></span>
						</p>
						
						<!-- 검색창 --> 
							
						 <td width="40" height="25" style="font-size: 100%">거래처명&nbsp;</td>
						 <td>
						 	<select id="deptall" name="deptall">	</select>
			 			 </td>          
			             <td width="30" height="25" style="font-size: 100%"></td>
						
					    <!-- 날짜(일 단위) 선택 -->
     	                 <input type="date" style="width: 300px; height: 25px;" id="searchDate" name="searchDate" v-model="searchDate">                    
<!-- 	                     <a href="javascript:beforeday();" class="btnType blue" id="btnPrevious" name="btnPrevious"> -->
<!-- 	                   		<span>≪</span> -->
<!-- 	                     </a> -->
                         <a href="" class="btnType blue" id="bgnToday" name="btnToday">
                         	<span>오 늘</span>
                         </a>
<!--                          <a href="javascript:nextday();" class="btnType blue" id="btnNext" name="btnNext"> -->
<!--                          	<span>≫</span> -->
<!--                          </a> -->
                         <a href="" class="btnType blue" id="btnSearch" name="btn">
	                     	<span>검  색</span>
	                     </a>
						<!-- 검색창 끝 -->
						
						<!--손익통계 표&차트 -->
						<div class="divddRevenueSumList"> 
						  <table class="col" width="1000" height="300" style="border-right: hidden;">
						  	 <!--차트영역 -->
						     <tr>
						     	<td rowspan="6" width="70%">
						     		<div id="chart_div"></div>
						     	</td>
						     	<td>
							     	<!--합계영역 -->
							     	<table class="col">
							     		<thead>
									     	<td></td>
									     	<td></td>
									     	<td width="10%">합계</td>
								     	</thead>
							    	 	<tbody id="listddRevenueSum">
							     		</tbody>
							     		<caption>단위:원</caption>
							     	</table>
						     	</td>
						     </tr>
						   </table>
						</div>
						
						<!-- 일별매출조회 테이블 -->
						<div class="divddRevenueList">
							<span>총 <span id="totalCntdRevList" style="color:red;font-weight:bold"></span>건</span>
							<table class="col">
								<caption>단위:원</caption>
								<colgroup>
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">주문일자</th>
										<th scope="col">거래처코드</th>
										<th scope="col">거래처명</th>
										<th scope="col">항목명</th>
										<th scope="col">수량</th>
										<th scope="col">단가</th>
										<th scope="col">공급가액</th>
										<th scope="col">부가세</th>
										<th scope="col">합계</th>
									</tr>
								</thead>
								<template v-if="totalCount == 0">
									<tbody>
										<td colspan="9">데이터가 존재하지 않습니다.</td>
									</tbody>
								</template>
								<template v-else>
									<tbody v-for="list, item in grouplist">
										<tr>
											<td>{{list.est_odate}}</td>
											<td>{{list.biz_code}}</td>
											<td>{{list.biz_name}}</td>
											<td>{{list.prd_name}}</td>
											<td>{{list.est_ocnt}}</td>
											<td>{{list.sup_price}}</td>
											<td>{{list.sppl}}</td>
											<td>{{list.tax}}</td>
											<td>{{list.pay_price}}</td>
										</tr>
									</tbody>
								</template>
								
							</table>
						</div>
	
						<!-- 페이징에리어 -->
						<div class="paging_area"  id="ddRevenuePagination" v-html="pageNavi"> </div>
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="collapse; border: 1px #50bcdf;">
								<tr style="border: 0px; border-color: blue">
									<td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
									<td width="50" height="25" style="font-size: 100%; text-align: left; padding-right: 25px;"> </td>
								</tr>
							</table>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
    </body>
</html>