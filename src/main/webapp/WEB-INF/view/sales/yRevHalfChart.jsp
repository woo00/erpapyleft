<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>

<!-- 집계기간:상.하반기
분기별 손익계산서 콤보차트 -->
<script>
	var dateArr = new Array();  //년도
	var salesArr = new Array();   //매출
	var sproArr = new Array();  //영업이익
	var sproRateArr = new Array();  //영업이익률
</script>

<c:forEach items="${listYSalesModel}" var="list">
	<script>
	dateArr.push("${list.est_odate}");
	salesArr.push("${list.sum_sales}");
	sproArr.push("${list.sum_cost}");
	sproRateArr.push("${list.salesProfit_rate}");	
	</script>
</c:forEach>

<script type="text/javascript">
google.charts.load('current', {packages: ['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

	var data = new google.visualization.DataTable();
		data.addColumn('string', 'Date');
		data.addColumn('number', '매출');
		data.addColumn('number', '영업이익');
		data.addColumn('number', '영업이익률');

		for (var i = 0; i < dateArr.length; i++) {
			data.addRow([dateArr[i],parseInt(salesArr[i]), parseInt(sproArr[i]),parseFloat(sproRateArr[i])]);
		}

		var options = {
			vAxes : {
				0:{
				title : '금액(단위:원)'
			}, 
			1:{
				title : '%',
				baseline:100
				
			} },
			colors : [ 'blue', 'red', 'green' ],
			seriesType : 'bars',
			legend : {
				position : 'top'
			},
			series : {
				0 : {
					targetAxisIndex : 0
				},
				3 : {
					targetAxisIndex : 1,
					type : 'line',
					color : 'purple'
				}
			},
			animation : { //차트가 뿌려질때 실행될 애니메이션 효과
				startup : true,
				duration : 1000,
				easing : 'linear'
			}
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById("chart_div_main"));
		chart.draw(data, options);
	}
</script> 

<div id="chart_div_main"></div>     
      


				
							
						
							
							