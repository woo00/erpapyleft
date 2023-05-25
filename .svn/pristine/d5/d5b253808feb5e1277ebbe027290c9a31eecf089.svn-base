<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>erpapyleft</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery=ui.css" type="text/css"/>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>

</style>
<script type="text/javascript">
	var d = new Date();
	
	var pageSize = 10;
	var pageBlock = 5;
	var year = d.getFullYear();  // 년
	var month = d.getMonth() + 1;  // 월
	var day = d.getDate();  // 일

	$(function() {
		init();
		
		valist();
	});
	
	function init(){
		comcombo("va_div","va_div","sel","");
		
		$("#sDate").datepicker({
		});
		$("#eDate").datepicker({
		});
	}
	
	function valist(page){
		page = page || 1;
		
		var param = {
				page : page,
				pageSize : pageSize,
		}
		
		var callback = function(result) {
			
			console.log(result);
			
			$("#valist").empty().append(result);
			
			var vacnt = $("#vacnt").val();
			
			var paginationHtml = getPaginationHtml(page, vacnt, pageSize, pageBlock, 'valist');
			
			$("#taPagination").empty().append(paginationHtml);
			
		}
		
		callAjax("/employee/valist.do", "post", "text", "false", param, callback) ;
	}
	
	function vadetail(action,va_code){
		$("#action").val(action);
		$("#va_code").val(va_code);
		
		console.log("" + year + "-" + month + "-" + day + "");
		
		$("#td_regdate").html("" + year + " - " + month + " - " + day + "");
		$("#td_user_num").html($("#loginID").val());
		$("#td_user_dept").html($("#dept_name").val());
		$("#td_user_name").html($("#user_name").val());
		
		if(action == 'I')
		{
			$("#tb_title").html("휴가 신청서");
			$("#btnI").show();
			$("#btnU").hide();
			
			$("#va_div").val("");
			$("#sDate").val("");
			$("#eDate").val("");
			$("#va_reason").val("");
		}
		else if(action == 'U')
		{
			$("#tb_title").html("휴가 신청 결과 조회");
			$("#btnI").hide();
			$("#btnU").show();
			
			var param={
					va_code : va_code,
			}
			
			var detailcallback = function(result) {
				
				console.log(result);
				
				$("#va_div").val("");
				$("#sDate").val("");
				$("#eDate").val("");
				$("#va_reason").val("");
			}
			
			//callAjax("/employee/vadetail.do", "post", "json", "false", param, detailcallback) ;
			
		}
		else if(action == 'D')
		{
			
		}
		
		gfModalPop("#layer1");
	}
	
	function save(){
		var param = {
			action : $("#action").val(),
			st_date : $("#sDate").val(),
			ed_date : $("#eDate").val(),
			va_div : $("#va_div").val(), 
			va_code : $("#va_code").val(),
			vcn_reason : $("#va_reason").val(),
			em_hp : $("#va_reason").val()
		}
		
		var savecallback = function(result) {
			
			console.log(result);
		}
		
		callAjax("/employee/vasave.do", "post", "json", "false", param, savecallback) ;
	}
	
	function close(){
		gfCloseModal("#layer1");
	}
</script>
</head>
<body>
<form id="myForm" action=""  method="">	
	<input type="hidden" name="user_type" id="user_type" value="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" id="va_code" name="va_code" value ="">
	<input type="hidden" id="dept_name" name="dept_name" value ="${dept_name}"/>
	<input type="hidden" id="user_name" name="user_name" value ="${user_name}"/>
	<input type="hidden" id="loginID" name="loginID" value ="${loginID}"/>
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">인사/급여</span> <span class="btn_nav bold">휴가 관리</span> 
						</p>
						
						<p class="conTitle">
							<span>휴가 관리</span> <span class="fr"> 
							</span>
						</p>
						
						<div class="bootstrap-table">
							<table class="col">
								<colgroup>
									<col width="35%">
									<col width="35%">
									<col width="30%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">춍 연차</th>
										<th scope="col">사용 연차</th>
										<th scope="col">남은 연차</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${leave_date}</td>
										<td>${use_leave} <c:if test="${use_leave eq null }">-</c:if></td>
										<td>${leave_date - use_leave}</td>
									</tr>
								</tbody>
							</table>
						</div><br>
						
						<span class="fr">
							<a class="btnType blue" href ="javascript:vadetail('I','')"><span>휴가 신청</span></a>
						</span><br><br>
						
						<div id="talist">
								<div class="bootstrap-table">
									<div class="fixed-table-container" style="padding-bottom: 0px;">
										<div class="fixed-table-body">		
											<table class="col">
													<colgroup>
														<col width="12%">
														<col width="8%">
														<col width="13%">
														<col width="18%">
														<col width="18%">
														<col width="23%">
														<col width="8%">
													</colgroup>
													<thead>
														<tr>
														      <th scope="col">번호</th>
														      <th scope="col">구분</th>
														      <th scope="col">시작일</th>
												              <th scope="col">종료일</th>
												              <th scope="col">사용연차</th>
												              <th scope="col">결재자</th>
												              <th scope="col">결재상태</th>
														</tr>
													</thead>
													<tbody id="valist">
													</tbody>
												</table>
										</div>
	                                    <div>
												<div>
													<div class="clearfix" />
												</div>
										</div>
									 </div>		
								   </div>
								</div>			   

					        	<div class="paging_area"  id="taPagination"> </div>
						</div>
					</div> 
					<!--// content -->
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong id="tb_title"></strong>
			</dt>
			<dd class="content">
				<table class="row">
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">사번 </th>
							<td id="td_user_num"></td>
							<th scope="row">신청일자 </th>
							<td id="td_reg_date"></td>
						</tr>
						<tr>
							<th scope="row">소속 부서 </th>
							<td id="td_user_dept"></td>
							<th scope="row">성명 </th>
							<td id="td_user_name"></td>
						</tr>
						<tr>
							<th scope="row">휴가 구분 </th>
							<td>
								<select id="va_div"  style="width:125px">
								</select>
							</td>
							<th scope="row">비상 연락처 </th>
							<td><input type="text" id="em_hp" placeholder="010-1234-5678"></td>
						</tr>
						<tr>
							<th scope="row">시작일 </th>
							<td><input type="text" id="sDate" style="width:125px"></td>
							<th scope="row">종료일 </th>
							<td><input type="text" id="eDate"></td>
						</tr>
						<tr>
						
							<th scope="row">휴가 사유</th>
							<td colspan="3">
								<p>
									<textarea id="va_reason">
									</textarea>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30"> 
					<a href="javascript:save()" class="btnType blue" id="btnI"><span>신청</span></a>
					<a href="javascript:close()" class="btnType blue" id="btnU"><span>수정</span></a>
					<a href="javascript:close()" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>
		</dl>
	</div>
</form>
</body>
</html>