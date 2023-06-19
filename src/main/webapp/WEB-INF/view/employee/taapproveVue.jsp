<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>erpapyleft</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
	var month = ('0'+(d.getMonth() + 1)).slice(-2);  // 월
	var day = d.getDate();  // 일
	
	$(function() {
		init();
		valist();
	});
	
	function init(){
		comcombo("va_div","va_div","sel","");
		
		 var days=0;
		 var lastday=0;
		  
		 
		 
		 $("#sDate").change(function(){
		 		var sd = $("#sDate").val();
		 		var sdarr =  sd.split('-');
		 		var ed = $("#eDate").val();
		 		var edarr =  ed.split('-');
		 		
		 		var sdate = new Date(sdarr[0] ,sdarr[1],sdarr[2]);
		 		var edate = new Date(edarr[0] ,edarr[1],edarr[2]);
				if(sdate > edate)
				{
					swal("최대일자보다 클 수 없습니다!");
					$("#sDate").val("");
				}
				
				if($("#action").val() == 'I')
				{
				 	vali(sdate,edate);
				}
		 })
		 
		 $("#eDate").change(function(){
			 	var sd = $("#sDate").val();
		 		var sdarr =  sd.split('-');
		 		var ed = $("#eDate").val();
		 		var edarr =  ed.split('-');
		 		
		 		var sdate = new Date(sdarr[0] ,sdarr[1],sdarr[2]);
		 		var edate = new Date(edarr[0] ,edarr[1],edarr[2]); 
		 		
			 if(sdate > edate)
			{
				swal("최소일자보다 작을 수 없습니다!");
				$("#eDate").val("");
			}
			 
			 if($("#action").val() == 'I')
			{
			 	vali(sdate,edate);
			}
		 })
		 
		for(var i=12;i>month-1;i--)
		{
			lastday = new Date(d.getYear(),i,0);
			
			days += lastday.getDate();
		}

		days -= day;
		
		var option={
				dateFormat:'yy-mm-dd',
				minDate : +2,
				maxDate: days,
				dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
				dayNamesMin : ['월','화','수','목','금','토','일'],
				monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		}
		
		$("#sDate").datepicker(option);
		$("#eDate").datepicker(option);
	}
	
	function vali(sdate,edate)
	{
		var ava = (edate - sdate) / (1000*60*60*24) + 1;
		
		console.log("sdate : " + sdate);
		console.log("edate : " + edate);
		console.log("ava : " + ava);
		
		if(($("#leave_date").val() - $("#use_leave").val()) < ava)
		{
			swal("남은 연차가 부족합니다.");
			$("#sDate").val('') ;
			$("#eDate").val('') ;
		}
	}
	
	function valist(page){
		page = page || 1;
		
		$("#cpage").val(page);
		
		var param = {
				page : page,
				pageSize : pageSize,
		}
		
		var callback = function(result) {
			
			//console.log(result);
			
			$("#valist").empty().append(result);
			
			var vacnt = $("#vacnt").val();
			
			var paginationHtml = getPaginationHtml(page, vacnt, pageSize, pageBlock, 'valist');
			
			$("#taPagination").empty().append(paginationHtml);
			
		}
		
		callAjax("/employee/valist.do", "post", "text", "false", param, callback) ;
	}
	
	function vadetail(action,va_code,sign_yn){
		$("#action").val(action);
		$("#va_code").val(va_code);
		$("#sign").val(sign_yn);
		
		$("#td_reg_date").html("" + year + " - " + month + " - " + day + "");
		$("#td_user_num").html($("#loginID").val());
		$("#td_user_dept").html($("#dept_name").val());
		$("#td_user_name").html($("#user_name").val());
		
		if(action == 'I')
		{
			if(($("#leave_date").val() - $("#use_leave").val()) <= 0)
			{
				swal("사용할 수 있는 연차가 없습니다...");
				return;
			}
			$("#tb_title").html("휴가 신청서");
			$("#btnI").show();
			$("#btnU").hide();
			$("#btnD").hide();
			$("#va_div").prop("disabled",false);
			$("#sDate").prop("readonly",false);
			$("#eDate").prop("readonly",false);
			$("#va_reason").prop("readonly",false);
			$("#em_hp").prop("readonly",false);
			
			$("#va_div").val("");
			$("#sDate").val("");
			$("#eDate").val("");
			$("#va_reason").val("");
			$("#em_hp").val("");
		}
		else if(action == 'U')
		{
			$("#tb_title").html("휴가 신청 결과 조회");
			$("#btnI").hide();
			$("#btnU").show();
			$("#btnD").show();
			
			var param={
					va_code : va_code,
			}
			
			var detailcallback = function(result) {
				
				$("#va_div").val(result.va_div);
				$("#sDate").val(result.st_date);
				$("#eDate").val(result.ed_date);
				$("#va_reason").val(result.vcn_reason);
				$("#em_hp").val(result.em_hp);
				
				if(sign_yn == 'Y'||sign_yn == 'N')
				{
					$("#btnU").hide();
					$("#btnD").hide();
					$("#va_div").prop("disabled",true);
					$("#sDate").prop("disabled",true);
					$("#eDate").prop("disabled",true);
					$("#va_reason").prop("readonly",true);
					$("#em_hp").prop("readonly",true);
				}
				else
				{
					$("#btnU").show();
					$("#btnD").show();
					$("#va_div").prop("disabled",false);
					$("#sDate").prop("disabled",false);
					$("#eDate").prop("disabled",false);
					$("#va_reason").prop("readonly",false);
					$("#em_hp").prop("readonly",false);
				}
				// console.log(result.va_div);
				
			}
			
			callAjax("/employee/vadetail.do", "post", "json", "false", param, detailcallback) ;
			
		}
		
		gfModalPop("#layer1");
	}
	function validate(){
		
                 var chk = checkNotEmpty(
         				[
							["va_div","신청하실 휴가를 선택해주세요!"],
							["em_hp","비상 연락처를 입력해주세요!"],
							["sDate","시작일자를 입력해주세요!"],
							["eDate","종료일자를 입력해주세요!"],
							["va_reason","휴가사유를 입력해주세요!"]
         				]
         		);

         		if (!chk) {
         			return;
         		}

         		return true;
	}
	
	function save(){
		if(!validate())
		{
			return;
		}
		
		var param = {
			action : $("#action").val(),
			st_date : $("#sDate").val(),
			ed_date : $("#eDate").val(),
			va_div : $("#va_div").val(), 
			va_code : $("#va_code").val(),
			vcn_reason : $("#va_reason").val(),
			em_hp : $("#em_hp").val()
		}
		
		var callback = function(result) {
			var msg;
			// console.log(result);
			if(result >= 1)
			{
				if($("#action").val() == 'I')
				{
					msg = "신청 성공!";
				}
				else if($("#action").val() == 'U')
				{
					msg = "수정 성공!";
				}
				else if($("#action").val() == 'D')
				{
					msg = "취소 성공!";
				}
			}
			swal(msg);
			
			gfCloseModal("#layer1");
			valist();
		}
		
		callAjax("/employee/vasave.do", "post", "json", "false", param, callback) ;
	}
	
	// 휴가 결과 조회
	function result(sign_yn){
	
		var param={
				va_code : $("#va_code").val(),
		}
		
		var callback = function(callback) {
			
			// console.log(JSON.stringify(callback));
			
			var result;
			
			switch(callback.sign_yn){
				case 'Y':
					$(".ban_re").hide();
					result = '승인'
					break;
				case 'W':
					$(".ban_re").hide();
					result = '심사 중'
					break;
				case 'N':
					$(".ban_re").show();
					$("#ban_re").html(callback.re_reason);
					result = '반려'
					break;
			}
			
			$("#td2_code").html($("#va_code").val());
			$("#td2_loginID").html(callback.name);
			$("#td2_email").html(callback.email);
			$("#td2_result").html(result);
			
			gfModalPop("#layer2");
			valist($("#cpage").val());
		}
		
		callAjax("/employee/resultdetail.do", "post", "json", "false", param, callback) ;
		
	}
	
	// 신청 취소
	function cancle(){
		$("#action").val('D');
		
		save();
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
	<input type="hidden" id="cpage" name="cpage" value ="">
	<input type="hidden" id="sign" name="sign" value ="">
	<input type="hidden" id="loginID" name="loginID" value ="${loginID}"/>
	<input type="hidden" id="user_name" name="user_name" value ="${user_name}"/>
	<input type="hidden" id="dept_name" name="dept_name" value ="${dept_name}"/>
	<input type="hidden" id="use_leave" name="use_leave" value ="${use_leave}"/>
	<input type="hidden" id="leave_date" name="leave_date" value ="${leave_date}"/>
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
														<col width="10%">
														<col width="10%">
														<col width="8%">
														<col width="11%">
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
												              <th scope="col">비고</th>
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
					<a href="javascript:save()" class="btnType blue" id="btnU"><span>수정</span></a>
					<a href="javascript:cancle()" class="btnType blue" id="btnD"><span>신청 취소</span></a>
					<a href="javascript:close()" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>결과 조회</strong>
			</dt>
			<dd class="content">
				<table class="row">
					<colgroup>
						<col width="10px">
						<col width="10px">
						<col width="10px">
						<col width="10px">
						<col width="40px" class="ban_re">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row" >휴가번호</th>
							<th scope="row">담당자</th>
							<th scope="row">email</th>
							<th scope="row">결과</th>
							<th scope="row" class="ban_re">반려 사유</th>
						</tr>
						<tr>
							<td id="td2_code" style="text-align:center;"></td>
							<td id="td2_loginID" style="text-align:center;"></td>
							<td id="td2_email" style="text-align:center;"></td>
							<td id="td2_result" style="text-align:center;"></td>
							<td class="ban_re" id="ban_re" style="text-align:center;"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30"> 
					<a href="javascript:close()" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
</form>
</body>
</html>