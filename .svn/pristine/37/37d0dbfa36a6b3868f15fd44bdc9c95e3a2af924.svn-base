<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<!-- <script src="https://www.gstatic.com/charts/loader.js"></script> -->
<!-- 월별 손익통계 차트 -->
<script type="text/javascript">
	var dateArr = new Array();  //날짜
	var salesArr = new Array();  //매출
	var orderCnt = new Array();  //주문건수
</script>


<c:forEach items="${listMSalesModel}" var="list">
	<script>
	dateArr.push("${list.est_odate}");  //날짜
	salesArr.push("${list.margin}");  //매출
	orderCnt.push("${list.orderCnt}");  //주문건수
	</script>
</c:forEach>

<script>
google.charts.load('current', {packages: ['corechart']});
google.charts.setOnLoadCallback(drawChart);

//평균구하기
// function average(array) {
// 	  var sum = 0.0;

// 	  for (var i = 0; i < array.length; i++)
// 	    sum += parseInt(array[i]);

// 	  return Math.round(sum / array.length*100)/100;
// 	}

//구글차트 
function drawChart() {
	var data = new google.visualization.DataTable();
	data.addColumn('string','Date');
	data.addColumn('number','매출');
	data.addColumn('number','주문건수');
	
	for(var i=0;i<dateArr.length;i++){
		data.addRow([dateArr[i],parseInt(salesArr[i]),parseInt(orderCnt[i])]);
// 		data.addRow(["dd",0,0]);
	}
    
    var options = {
            
            vAxes: {
                0:{
                	title:'단위:원'

            }, 
            	1:{
            		minValue: -100,
                    maxValue: 100,
                    title:'%'
            		}
            },
            chartArea : {
				//height: '90%',
				width : '60%'
			},
			animation : { //차트가 뿌려질때 실행될 애니메이션 효과
				startup : true,
				duration : 1000,
				easing : 'linear'
			},
			seriesType : 'bars',
			series : {1: {type:'line',
						  targetAxisIndex: 2}}
          };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div_main'));

    chart.draw(data, options);
  }
</script>

<div id="chart_div_main"></div>


	
             
      










