<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">

// 페이징 설정
var pageSize = 5;
var pageBlockSize = 5;

/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSave' :
				fn_save();
				break;
			case 'btnDelete' :
				$("#action").val('D');
				fn_save();
				break;
			case 'btnSavefile' :
				fSaveDtlCod();
				break;
			case 'btnDeletefile' :
				fDeleteDtlCod();
				break;
			case 'btnSearchGrpcod':
				board_search();
				break;
			case 'btnClose' :
			case 'btnClosefile' :
				gfCloseModal();
				break;
		}
	});
}

/** OnLoad event */ 
$(function() {

	searchempTa();
	fRegisterButtonClickEvent();
	$('input[name="dv_radio"]').change(function(){
		console.log("#####################")
	    var value = $(this).val();
		console.log(value);
		$("#can_reason").val($("#reason_backup").val());
	    if(value=='N'){
	    	$("#re_reason").show();
	    }else{
	    	$("#re_reason").hide();
	    }
	    
	});
	
});

function searchempTa(cpage) {
	
	$("#userId").val($("#hnumber").val());
	$("#userNm").val($("#hname").val());
	$("#srcsdate").val($("#hstdate").val());
	$("#srcedate").val($("#heddate").val());
	$("#agree").val($("#hsign").val());
	cpage = cpage || 1;
	 
	// 파라메터,  callback
	var param = {
			loginID : $("#userId").val(),
			userNm : $("#userNm").val(),
			srcsdate : $("#srcsdate").val(),
			srcedate : $("#srcedate").val(),
			signYn : $("#agree").val(),
			pageSize : pageSize,
			cpage : cpage,
	}
	 
	var listcallback = function(returndata) {
		$("#listEmpTa").empty().append(returndata);
		console.log("totcnt : " + $("#counthnoticelist").val());
		$("#hnumber").val($("#userId").val());
		$("#hname").val($("#userNm").val());
		$("#hstdate").val($("#srcsdate").val());
		$("#heddate").val($("#srcedate").val());
		$("#hsign").val($("#agree").val());
		
		var countempTalist = $("#countempTalist").val();
		
		var paginationHtml = getPaginationHtml(cpage, countempTalist, pageSize, pageBlockSize, 'searchempTa');
		
		$("#empTaPagination").empty().append(paginationHtml);
	}
	
	callAjax("/employee/empTalist.do", "post", "text", "false", param, listcallback) ;
	
	
}

function searchTa(cpage){
	cpage  = cpage || 1;
	var param = {
			loginID : $("#userId").val(),
			userNm : $("#userNm").val(),
			srcsdate : $("#srcsdate").val(),
			srcedate : $("#srcedate").val(),
			signYn : $("#agree").val(),
			pageSize : pageSize,
			cpage : cpage,
	}
	
	var listcallback = function(returndata) {
		$("#listEmpTa").empty().append(returndata);

		$("#hnumber").val($("#userId").val());
		$("#hname").val($("#userNm").val());
		$("#hstdate").val($("#srcsdate").val());
		$("#heddate").val($("#srcedate").val());
		$("#hsign").val($("#agree").val());
		console.log("totcnt : " + $("#counthnoticelist").val());
		
		var countempTalist = $("#countempTalist").val();
		
		var paginationHtml = getPaginationHtml(cpage, countempTalist, pageSize, pageBlockSize, 'searchempTa');
		
		$("#empTaPagination").empty().append(paginationHtml);
	}
	
	callAjax("/employee/empTalist.do", "post", "text", "false", param, listcallback) ;
}

function fn_detail(num){
		$("#va_code").val(num);
	var param = {
			va_code : num
			
	}
	
	var detailcallback = function(returndata){
		console.log(JSON.stringify(returndata));
		$("#dept_name").val(returndata.detail.dept_name);
		$("#kind_hol").val(returndata.detail.va_name);
		$("#name2").val(returndata.detail.name);
		$("#loginID2").val(returndata.detail.loginID);
		$("#tel").val(returndata.detail.em_hp);
		$("#start_date2").val(returndata.detail.st_date);
		$("#end_date2").val(returndata.detail.ed_date);
		$("#reason_hol").val(returndata.detail.vcn_reason);
		$("#ta_reg_date").val(returndata.detail.app_date);
		$("input[name='dv_radio']:radio[value= '" + returndata.detail.sign_yn + "']").prop('checked', true);
		$("#can_reason").val(returndata.detail.re_reason);
		$("#reason_backup").val(returndata.detail.re_reason);
		if(returndata.detail.sign_yn == 'N'){
	    	$("#re_reason").show();
	    	
	    }else{
	    	$("#re_reason").hide();
	    }
	}
	
	callAjax("/employee/empdetail.do", "post", "JSON", "false", param, detailcallback) ;
	
	gfModalPop("#layer2");
}

function fn_saves(){
	var re_reason= '';
	var signyn = $("input[type=radio][name=dv_radio]:checked").val();
	 
	if(signyn == 'N'){
		// 반려일 때
		 re_reason =  $("#can_reason").val();
	}
	else{
		// 승인, 승인대기일 때
		re_reason = '';
	}
	if(re_reason == null || re_reason == undefined || re_reason == "" && signyn == 'N'){
		alert("반려 사유를 적어주세요");
		
		return false;
	}
	var param = {
			va_code : $("#va_code").val(),
			sign_yn : $("input[type=radio][name=dv_radio]:checked").val(),
			re_reason : re_reason,
	}
	
	var savecallback = function(returndata){
		console.log(returndata);
		if(returndata.result >= 0){
			alert("저장되었습니다.");
		}
		gfCloseModal();
		searchempTa();
		
	}
	
	callAjax("/employee/detailsave.do", "post", "JSON", "false", param, savecallback) ;
}

</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="loginID" id="loginID" value="${loginID}">
	<input type="hidden" name="va_code" id="va_code" value="">
	<input type="hidden" name="reason_backup" id="reason_backup" value="">
	<input type="hidden" name="signyn" id="signyn" value="">
	
	
	
	
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
								class="btn_nav bold">인사/급여</span> <span class="btn_nav bold">근태관리
								</span> <a href="../employee/empTaCalendar.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>근태 관리</span> <span class="fr"> 
							</span>
						</p>
						<p class="conTitle">
								등록일자
								<input type="date" id="srcsdate" name="srcsdate" /> ~ 
								<input type="date" id="srcedate" name="srcedate" /> 
								사번
								<input type="text" id="userId" name="userId" size=16.5 />
								사원명
								<input type="text" id="userNm" name="userNm" size=16.5 />
								승인여부
								<select id = "agree" >
										<option value="">선택</option>
										<option value="Y">승인</option>
										<option value="N">반려</option>
										<option value="W">승인대기중</option>
								</select>
								<a	class="btnType blue" href="javascript:searchTa();" name="modal" ><span>검색</span></a>
							
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="10%">
									<col width="7%">
									<col width="8%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="8%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">사번</th>
										<th scope="col">사원명</th>
										<th scope="col">신청구분</th>
										<th scope="col">시작일자</th>
										<th scope="col">종료일자</th>
										<th scope="col">신청일자</th>
										<th scope="col">승인자</th>
										<th scope="col">승인여부</th>
									</tr>
								</thead>
								<tbody id="listEmpTa"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="empTaPagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>
	
	<form id="myForm2" action=""  method="">	
     <div id="layer2" class="layerPop layerType2" style="width: 800px; height:800px;">
      <dl>
         <dt>
            <strong>근태신청</strong>
         </dt>
         <dd class="content" style=" width: 740px; height: 500px; padding-bottom: 0px;">
         
            <table class="col" style="background-color:rgb(220,225,230);">
               <colgroup>
                  <col width="20%">
                  <col width="30%">
                  <col width="20%">
                  <col width="30%">
               </colgroup>
				<h1 class="center title">휴가 신청서</h1>
				<thead class="middle">
					<tr>
						<th scope="col">근무부서</th>
							<td  scope="col" style="padding:0px; width:200px;">
								<input style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;" type="text" id="dept_name" name="dept_name" readonly>
							</td>
						<th scope="col">근태종류</th>
						<td scope="col" class="center" style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;">
							<input style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;" type="text" id="kind_hol" name="kind_hol" readonly>
					</tr>
					<tr class="left">
						<th scope="col">성명</th>
							<td  scope="col" style="padding:0px; width:200px;">
								<input style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;" type="text" id="name2" name="name2" readonly>
							</td>
					</tr>
					<tr style="margin-bottom:20px;">
						<th scope="col">사번</th>
							<td  scope="col" style="padding:0px; width:200px;">
								<input style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;" type="text" id="loginID2" name="loginID2" readonly>
							</td>
					</tr>
					<tr style="margin-bottom:20px;">
						<th scope="col">비상연락처</th>
							<td  scope="col" style="padding:0px; width:200px;">
								<input style="width:200px; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;" type="text" id="tel" name="tel" readonly>
							</td>
					</tr>
				</thead>
				
            </table>
            
            <table class="col" style="background-color:rgb(220,225,230);">
            <colgroup>
                  <col width="20%">
                  <col width="80%">
               </colgroup>
            	<thead>
            		<tr scope="col">
						<th scope="col">기간</th>
						<td scope="col" >
							<span  style="position: relative;width:100%; height:30px; padding:0px; text-align:center; display:block; margin: 0 auto;">
								<input type="text" id="start_date2" name="start_date2" class="hei" readonly>~<input type="text" id="end_date2" name="end_date2" class="hei" readonly>
							</span>
						</td>
					</tr>
					<tr scope="col" style="height:100px;">
						<th scope="col">휴가사유</th>
						<td style="" class="center">
							<input type="text" style="height:100px; margin:6px 9.5px 6px 9.5px; width:90%" id="reason_hol" name="reason_hol" readonly>
						</td>
					</tr>
					<tr>
						<th scope="col"></th>
						<td class="center">
							<span style="font-size:15px; padding-top:10px">상기와 같은 사유로 휴가를 신청합니다.</span>
						</td>
					</tr>
					<tr>
						<th scope="col"></th>
						<td class="center">
							<span style="padding-top:13px; font-size: 13px;">신청일</span><input type="text" style="height:30px; margin:6px 9.5px 6px 9.5px; width:50%" id="ta_reg_date" name="ta_reg_date" readonly>
						</td>
					</tr>
            	</thead>
            </table>
            
             <table class="col" style="background-color:rgb(220,225,230);">
            <colgroup>
                  <col width="20%">
                  <col width="80%">
               </colgroup>
            	<thead>
            		<tr>
						<th scope="row">승인구분 <span class="font_red">*</span></th>
						<td colspan="3" style="padding-left: 10px; font-size: 13px;">
								<input type="radio" id="radioyn" name="dv_radio" value="Y"> 승인</input>
								<input type="radio" id="radioyn" name="dv_radio" value="N"> 반려</input>
								<input type="radio" id="radioyn" name="dv_radio" value="W">승인대기</input></td>
					</tr>
					<tr scope="col" style="height:100px;" id="re_reason">
						<th scope="col">반려사유</th>
						<td style="" class="center">
							<input type="text" style="height:100px; margin:6px 9.5px 6px 9.5px; width:90%" name = "can_reason" id="can_reason">
						</td>
					</tr>
					
            	</thead>
            </table>
            
         </dd>
      </dl>
      
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
      
            <div class="btn_areaC mt20" style="position:absolute; bottom:20px;">
               <a href="javascript:fn_saves();" class="btnType blue"><span id="">확인</span></a>
               <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
            </div>
   </div>
  </form>
	
	

	</body>
	</html>