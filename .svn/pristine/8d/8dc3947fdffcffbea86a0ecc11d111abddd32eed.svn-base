<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">


.btnType{
	float:right;
}

.app_date_apply{
	 height : 25px;
	 margin-bottom:5px;
}

.selectEmpDv{
	margin-bottom:10px;
	overflow : hidden;
}

.selectEmpDv li{
	float:left;
	margin-right: 30px;	
}

#empDvReg{
	border : 1px solid #000;
}

#dv_form{
	display : none;
}

</style>

<title>지출결의서 신청</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

//페이징 설정 
var pageSize = 5; // 행 다섯개 
var pageBlock = 5;  // 블록 갯수 일단 출력

//함수 시작
$(document).ready(function(){
	
	//셀렉트박스 이닛
	fn_init();
	//초기화면 설정
	searchList();
	//버튼이벤트 설정
	oRegisterButtonClickEvent();
	//모달 셀렉박스
	fn_init_modal();
});

function fn_init(){
    // 공통코드 comcombo 사용방법 ->
    // Group Code, Combo Name, Option("all" : 전체 / "sel" : 선택 )
    // acc : 대분류, accd : 소분류
      selectComCombo("acc","account_cd","all","",""); 
      selectComCombo("accd","detail_account_cd","all","","");
      comcombo("dv_sign","dv_app_yn","all","");
      
      $("#account_cd").change(function() {
			selectComCombo("accd", "detail_account_cd", "all", $("#account_cd").val(), "");  // 계정 상세 분류
		});
      
}

function fn_init_modal(){
	
    // 공통코드 comcombo 사용방법 ->
    // Group Code, Combo Name, Option("all" : 전체 / "sel" : 선택 )
    // acc : 대분류, accd : 소분류
      selectComCombo("acc","account_cd_modal","all","",""); 
      selectComCombo("accd","detail_account_cd_modal","all","","");
      comcombo("dv_sign","detail_yn_modal","all","");
      
      $("#account_cd_modal").change(function() {
			selectComCombo("accd", "detail_account_cd_modal", "all", $("#account_cd_modal").val(), "");  // 계정 상세 분류
		});
      
      $('#detail_yn_modal').change(function() {
    	  var value = $(this).val();
    	  $("#detail_yn_modal").val(value);
    	  
  		if(value == 2 ){
			$("#dvrsh").show(); 
		}else{
			$("#dvrsh").hide();
		} 
      });
      
} 

/** 버튼 이벤트 등록 */
function oRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

		switch (btnIdEst) {

			case 'btnSaveEmpDv' : // 신규등록 , 저장 
				dvSave();
				break;
			case 'btnUpdateOem2' : // 수정 , 저장 
				oeUpdate();
				break;
			case 'btnDeleteOem' : // 삭제 
				oDeleteOem();
				break;
			case 'btnSearchOem': // 검색 
				 oemList();
				break;
			case 'btnCloseEmpDv' : // 모달 닫기 함수 [나는 하나로 썼음 ]
				gfCloseModal();
				break;
		}
	});
}

function searchList(cpage){
	$("#account_cd").val($("#hbacc_code").val());
	$("#detail_account_cd").val($("#hdacc_code").val());
	$("#dv_app_yn").val($("#hdv_sign").val());
	$("#from_date").val($("#hsdv_date").val());
	$("#to_date").val($("#hsdv_udate").val());
	cpage = cpage || 1;
	$("#cpage").val(cpage);
	var param = {
			cpage : cpage,
			pageSize : pageSize,
			bacc_code : $("#account_cd").val(),
			dacc_code : $("#detail_account_cd").val(),
			dv_sign : $("#dv_app_yn").val(),
			sdv_date : $("#from_date").val(),
			sdv_udate : $("#to_date").val(),
	}
	var listCallback = function(returndata){
		console.log(returndata);
		$("#listEmpDv").empty().append(returndata);
		var dvtotalcnt = $("#dvtotalcnt").val();
		
		console.log("dvtotalcnt : " + dvtotalcnt);
		var paginationHtml = getPaginationHtml(cpage, dvtotalcnt, pageSize, pageBlock, 'searchList');
		
		$("#bmDvPagination").empty();
		$("#bmDvPagination").append(paginationHtml);
		$("#hbacc_code").val($("#account_cd").val());
		$("#hdacc_code").val($("#detail_account_cd").val());
		$("#hdv_sign").val($("#dv_app_yn").val());
		$("#hsdv_date").val($("#from_date").val());
		$("#hsdv_udate").val($("#to_date").val());
	}
	callAjax("/accounting/bmDvlist.do", "post", "text", "false", param, listCallback);
}


function hsearchList(cpage){
	cpage = cpage || 1;
	$("#cpage").val(cpage);
	var param = {
			cpage : cpage,
			pageSize : pageSize,
			bacc_code : $("#account_cd").val(),
			dacc_code : $("#detail_account_cd").val(),
			dv_sign : $("#dv_app_yn").val(),
			sdv_date : $("#from_date").val(),
			sdv_udate : $("#to_date").val(),
	}
	var listCallback = function(returndata){
		console.log(returndata);
		$("#listEmpDv").empty().append(returndata);
		var dvtotalcnt = $("#dvtotalcnt").val();
		
		console.log("dvtotalcnt : " + dvtotalcnt);
		var paginationHtml = getPaginationHtml(cpage, dvtotalcnt, pageSize, pageBlock, 'searchList');
		
		$("#bmDvPagination").empty();
		$("#bmDvPagination").append(paginationHtml);
		$("#hbacc_code").val($("#account_cd").val());
		$("#hdacc_code").val($("#detail_account_cd").val());
		$("#hdv_sign").val($("#dv_app_yn").val());
		$("#hsdv_date").val($("#from_date").val());
		$("#hsdv_udate").val($("#to_date").val());
	}
	callAjax("/accounting/bmDvlist.do", "post", "text", "false", param, listCallback);
}






function fn_dvModal(num){
	 
	$("#dvcode").val(num);
	var param = {
			num : num,
	}
	var detailcallback = function(returndata){
		console.log(returndata);
		$("dv_no").val(returndata.result.dv_code);
		$("#loginID").val(returndata.result.loginID);
		$("#name").val(returndata.result.name);
		$("#account_cd_modals").val(returndata.result.bacc_name);
		$("#detail_account_cd_modal").val(returndata.result.dacc_name);
		$("#detail_yn_modal").val(returndata.result.dv_sign);
		$("#acc_name").val(returndata.result.biz_name);
		$("#dv_reg_date").val(returndata.result.dv_date);
		$("#dv_use_date").val(returndata.result.dv_udate);
		$("#dv_amt").val(returndata.result.dv_fee);
		$("#dv_memo").val(returndata.result.dv_memo);
		$("#dv_return").val(returndata.result.dv_reres);
		 $("#att_file_download").val(returndata.result.file_code);
		 $("#account_cd").val(returndata.result.bacc_code);
		 $("#detail_codes").val(returndata.result.dacc_code);
		 
		 var fileName = returndata.result.file_name;
			console.log(returndata.result.file_name);
			var fileArr = [];
			var previewHtml = "";
			
			if (fileName == "" || fileName == null || fileName == undefined) {
				previewHtml = "";
			}else {
				fileArr = fileName.split(".");
				
				if (fileArr[1] == "jpg" || fileArr[1] == "png") {
					previewHtml = "<a href = 'javascript:fDownloadAttFile()'> <img src='" + returndata.result.file_nadd + "' style='width : 150px; height :200px;'/></a>"
					console.log(returndata.result.file_nadd);
				}else{
					previewHtml = "<a href = 'javascript:fDownloadAttFile()'>" +returndata.result.file_nadd + "</a>";
					console.log(returndata.result.file_nadd);
				}
			}
			
			$("#filePreview").empty().append(previewHtml);
		 
		 
		 
		if(returndata.result.dv_sign != '2' ){
			$("#dvrsh").hide();
		}else{
			$("#dvrsh").show(); 
		}
		if( returndata.result.file_name == "" || returndata.result.file_name == null || returndata.result.file_name == undefined)
		{
			$("#att_file_form").hide();
		}
		else{
			$("#att_file_form").show();
		}
		
		if( returndata.result.dv_sign ==1 || returndata.result.dv_sign ==2){
			$("#signUser").val(returndata.dv_signUser);
			$("#btnSaveEmpDv").hide();
			$("select[name=detail_yn_modal]").attr("disabled", true);
			$("#dv_return").attr("readonly", true);
			   
		}else{
			$("#btnSaveEmpDv").show();
			$("#detail_yn_modal").removeAttr("disabled");
			if(returndata.dv_signUser == null || returndata.dv_signUser == "" || returndata.dv_signUser == undefined){
				console.log("리드온리 추가")
				$("#dv_return").attr("readonly", true);
			}else{
				console.log("리드온리 삭제")
				$("#dv_return").attr("readonly", false);
			}  
		} 
		gfModalPop("#layer1");
	}
	callAjax("/accounting/detail.do", 'post', 'json', false, param, detailcallback)
}

function dvSave(){
	var param = {
			dv_code : $("#dvcode").val(),
			action : 'I',
			dv_sign : $("select[name=detail_yn_modal]").val(),
			dv_return : $("#dv_return").val(),
			bacc_code : $("#account_cd").val(),
			dacc_code : $("#detail_codes").val(),
			dv_fee : $("#dv_amt").val()
			
	}
	console.log(param);
	
	var saveCallBack = function(result){
		if(result.result != 0){
			alert("저장되었습니다.");
		}else {
// 			alert("fail");
		}
		gfCloseModal();
		searchList($("#cpage").val());
	}
	callAjax("/accounting/bmdvSave.do", 'post', 'json', false, param, saveCallBack);
}

//	파일다운로드
function fDownloadAttFile(){
	
	
	var params = "<input type='hidden' name='dv_code' value='" + $("#dvcode").val() + "'/>";
	
	jQuery("<form action='/accounting/bmDvFileDownload.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();
	
}


</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action" name="action"  value=""/>
	<input type="hidden" id="signUser" name="signUser"  value=""/>
	<input type="hidden" id="cpage" name="cpage"  value=""/>
	<input type="hidden" id="detail_codes" name="detail_codes"  value=""/>
	<input type="hidden" id="hbacc_code" name="hbacc_code"  value=""/>
	<input type="hidden" id="hdacc_code" name="hdacc_code"  value=""/>
	<input type="hidden" id="hdv_sign" name="hdv_sign"  value=""/>
	<input type="hidden" id="hsdv_date" name="hsdv_date"  value=""/>
	<input type="hidden" id="hsdv_udate" name="hsdv_udate"  value=""/>
	
	
	
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
								class="btn_nav">회계</a> <span class="btn_nav bold">
								지출결의서 조회 및 승인</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>지출결의서 조회</span> <span class="fr">
							  <a class="btnType blue"
										href="javascript:hsearchList()" name="search"><span
										id="searchEnter">조회</span></a><br/>
							</span>
						</p>
						
			<!-- 지출결의서 조회 조건 -->
						
						<div class = "app_date_apply">
							<Strong>신청일자</Strong> <input type = "date" id="from_date">~<input
										type="date" id="to_date">
						</div>	
						
						
						<div class = "selectEmpDv">
							<ul>
								<li>
								<strong>계정대분류명</strong>
									<select id ="account_cd" name ="account_cd">
									</select>	
								</li>
								<li>
								<strong>상세분류명</strong>
									<select id ="detail_account_cd" name ="detail_account_cd">
									</select>
								</li>
								<li>
								<strong>승인여부</strong>
								<select id = "dv_app_yn" name= "dv_app_yn">
								</select>
								</li>	
							</ul>
					</div>
			
			<!-- 페이지에 출력할 컬럼명 -->			
						
					<div class="divDvList">
						<table class="col">
							<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="7%">
									<col width="7%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">결의번호</th>
										<th scope="col">계정대분류명</th>
										<th scope="col">상세분류명</th>
										<th scope="col">거래처명</th>
										<th scope="col">신청일자</th>
										<th scope="col">사용일자</th>
										<th scope="col">지출금액</th>
										<th scope="col">승인여부</th>
										<th scope="col">승인자</th>
									</tr>
								</thead>
							<tbody id="listEmpDv"></tbody>
						</table>
						<div class="paging_area"  id="bmDvPagination"></div>
					</div>
				</div>
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
		
		
	<!-- 지출결의서 상세 조회 및 승인(단건 조회) -->	
	<form id="empDvReg">
		<input type ="hidden" name = "action" id = "action" value = "">
		<div id = "layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
			<dt>
				<strong>지출결의서 상세조회 및 승인</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>
						<tbody>
						<tr id = "dv_form">
								<th scope="row">결의번호</th>
								<td><input type="text" class="inputTxt p100" name="dv_no" id="dv_no"/></td>
							</tr>
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="loginID" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사원명</th>
								<td><input type="text" class="inputTxt p100" name="name" id="name" readonly/></td>
							</tr>
							<tr>
								<th scope="row">계정대분류명<span class="font_red" readonly>*</span></th>
								<td colspan="3">
								<input type="text" id ="account_cd_modals" name = "account_cd_modals"   class="inputTxt p100"  readonly/>
								</td>
							</tr>
							<tr>
								<th scope="row">상세과목명<span class="font_red" readonly>*</span></th>
								<td colspan="3">
								<input type="text" id ="detail_account_cd_modal" name = "detail_account_cd_modal" class="inputTxt p100" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row">승인여부<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="detail_yn_modal" name = "detail_yn_modal">
								</select></td>
							</tr>
							<tr> 
								<th scope="row">거래처명<span class="font_red" >*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="acc_name" id="acc_name" readonly/></td>
							</tr>
							<tr>
								<th scope="row">신청일자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_reg_date" id="dv_reg_date" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" 
									name="dv_use_date" id="dv_use_date" class ="inputTxt p100" style ="font-size : 92%" readonly/></td>
							</tr>
							<tr>
								<th scope="row">지출금액<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_amt" id="dv_amt"  readonly/></td>
							</tr>
							<tr id = "att_file_form">
								<th scope="row">증빙서류</th>
								<td colspan="3">
								<span id="filePreview"></span>
								 <a class="btnType gray att_file_open"
										href="javascript:fDownloadAttFile()" name="att_file_download"><span
										id="att_file_download">다운로드</span></a><br/>
								</td>
							</tr>
							<tr style = "height: 100px">
								<th scope="row">비고</th>
								<td colspan="3"><textarea cols="20" rows="10" name = "dv_memo" id="dv_memo"  class = "p100" style = "height: 100px" readonly/></textarea></td>
							</tr>
							<tr id="dvrsh" >
								<th scope ="row" >반려사유</th>
								<td colspan ="3"><textarea cols="20" rows="10" name = "dv_return" id="dv_return" /></textarea></td>
							</tr>	
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div  style=" text-align: center;">
						<a href="" class="btnType blue" id="btnSaveEmpDv" name="btn"><span>저장</span></a>  
						<a href=""	class="btnType gray"  id="btnCloseEmpDv" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href=""  class="closePop"><span class="hidden">닫기</span></a>
		</div>				
	</form> <!--// content -->

</body>
</html>