<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>급여조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">	
	
	function fn_getSalDate() {
		const d = new Date();
		const date = d.getDate();
		if(date < 10) {
			return new Date(d.getFullYear(), d.getMonth() - 1, 1).toJSON().slice(0, 7);
		}
		else {
			return new Date(d.getFullYear(), d.getMonth(), 1).toJSON().slice(0, 7);
		}
	}
	
	$(function() {
		$('#from_date').change(function() {
			getPayHistInfo(this.value);
		});
		
		var sal_date = fn_getSalDate();
		$('#from_date').val(sal_date);
		
		getPayHistInfo();
	});
	
	function getPayHistInfo(sal_date) {
		sal_date = sal_date || fn_getSalDate();
		function callback(data) {
			
			if(data.info) {
				const info = data.info;
				$('#userNm').html(info.name);
				$('#posnm').html(info.grade_name);
				$('#workyear').html(info.workyear);
				$('#year_salary').html(info.an_salary);
				$('#salary').html(info.salary);
				$('#nat_ps').html(info.ip);
				$('#h_insure').html(info.hi);
				$('#e_insure').html(info.ii);
				$('#ohs_insure').html(info.ei);
				$('#income_tax').html(info.it);
				$('#net_pay').html(info.act_salary);
			}
			else {
			   swal("해당년월에 받은 급여가 없습니다.",{
				   icon: "error",
				   buttons: "확인"
			   });
			}
			
		}
		var params = {
			sal_date : sal_date
		}
		callAjax("/employee/empPayHistInfo.do", "post", "json", "false", params, callback);
	}
</script>
</head>
<body>
<form id="myForm">
	<div id="mask"></div>
	<div id="wrap_area">
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<div id="container">
		<ul>
			<li class="lnb"><jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
			<li class="contents">
				<h3 class="hidden">contents 영역</h3>
				<div class="content">
					<p class="Location">
						<a href="" class="btn_set home">메인으로</a> 
						<a href="" class="btn_nav">인사•급여</a> <span class="btn_nav bold">급여내역서</span>
						<a href="" class="btn_set refresh">새로고침</a>
					</p>
				
				<!-- 관리자 공지사항 리스트 조회  -->
				<div class="EmpPayHistList">
					<p class="conTitle" >               
					  <span>급여내역서</span>
								<span class="fr" >
									<Strong>기  준  년  월 </Strong> <input type="month" id="from_date" name="from_date" value="yyyy-mm" max >
								</span>
				    </p> 
					<table class="col" style="margin-top:20px;">
					<caption>caption</caption>
						<colgroup>
							<col width="33%">
							<col width="33%">
							<col width="33%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">사원명</th>
								<th scope="col">직    급</th>
								<th scope="col">근속연수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id="userNm">${userNm}</td>
								<td id="posnm">${posnm}</td>
								<td id="workyear">${workyear}</td>
							</tr>
						</tbody>
					</table>
					<a tabindex="0" class="btn btn-lg btn-danger fr cen" data-placement="left" role="button" data-toggle="popover" data-trigger="focus" title="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보험료율" data-content=" 국민연금 : 4.5%    건강보험 : 3.43%   고용보험 : 0.8%    산재보험 : 1.56%  &nbsp;&nbsp;소득세 &nbsp;: &nbsp;10%">
						<button type="button" class="btn btn-default fr" style="width:20px; margin-top:5px; margin-bottom:2px;" data-toggle="tooltip" data-placement="left" title="보험료율">?</button>
					</a>
					<table class="col" style="margin-top:20px;">
					<caption>caption</caption>
						<colgroup>
							<col width="33%">
							<col width="33%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">항목</th>
								<th scope="col">금액(원)</th>
							</tr>
						</thead>
			
							<tr>
								<th>연봉</th>
								<td><div id="year_salary"></div></td>
							</tr>
							<tr>
								<th>기본급</th>
								<td><div id="salary"></div></td>
							</tr>
							<tr>
								<th>국민연금</th>
								<td><div id="nat_ps"></div></td>
							</tr>
							<tr>
								<th>건강보험료</th>
								<td><div id="h_insure"></div></td>
							</tr>
							<tr>
								<th>고용보험료</th>
								<td><div id="e_insure"></div></td>
							</tr>
							<tr>
								<th>산재보험료</th>
								<td><div id="ohs_insure"></div></td>
							</tr>
							<tr>
								<th>소득세</th>
								<td><div id="income_tax"></div></td>
							</tr>
							<tr>
								<td>실수령액</td>
								<td><div id="net_pay"></div></td>
							</tr>
		
					
					</table>
				</div>
				<div class="paging_area" id="admPagination"></div>
								
				<div class="btn_areaC mt20">
					                      
                     </div>
               
				<h3 class="hidden">풋터 영역</h3> 
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul> 
	</div>
	</div>
	

	<div id="layer1" class="layerPop layerType2" style="width: 650px; overflow:auto;">
	</div>
	</form>
	
	<form id="myForm">
     <div id="layer2" class="layerPop layerType2" style="width: 650px;">
      <dl>
         <dt>
            <strong>공지사항 등록하기</strong>
         </dt>
         <dd class="content">
            <table class="row">
               
               <colgroup>
                  <col width="12%">
                  <col width="*">
                  <col width="12%">
                  <col width="*">
               </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">제목</th>
                     <td><input type="text" class="inputTxt p100" name="notice_tit" id="notice_tit" placeholder="제목을 입력하세요."/></td>
                  </tr>
                  <tr>
                     <th scope="row">내용</th>
                     <td><textarea class="inputTxt p100" name="notice_con" id="notice_con" style= "min-height:250px; resize:none;"></textarea></td>
                  </tr>
               </tbody>
            </table>
            
            <div class="btn_areaC mt20">
               <a href="javascript:fWrite();" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
               <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
            </div>
         </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
   </div>
  </form>
</body>
</html>