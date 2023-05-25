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
     var pageSize = 5;
     var pageBlockSize = 5;

     /* OnLoad event */ 
     $(function() {

         fRegisterButtonClickEvent();

         fListEmpDv();
         
         fn_init();
    });
     
     
     function fn_init(){
    	 selectComCombo("cli","acc_name","all","","");
    	 
    	 selectComCombo("acc","account_cd","all","","");
         $("#account_cd").change(function() {
    			selectComCombo("accd", "detail_account_cd", "all", $("#account_cd").val(), "");  // 계정 상세 분류
    		});
         
         
    	 selectComCombo("acc","account_cd_modal","all","","");
         $("#account_cd_modal").change(function() {
//         	 $("#detail_account_cd_modal").show();
//         	 $("#detail_account_cd_modal2").hide();
    			selectComCombo("accd", "detail_account_cd_modal", "all", $("#account_cd_modal").val(), "");  // 계정 상세 분류
    		});
         
     } 
 	/** 버튼 이벤트 등록 */
 	function fRegisterButtonClickEvent() {
 		$('a[name=btn]').click(function(e) {
 			e.preventDefault();

 			var btnId = $(this).attr('id');
 			
 			switch (btnId) {
 			    case 'btnSaveEmpDv' :
 					fn_savefile();
 					break;	
 			    case 'btnDeleteEmpDv' :
 			    	$("#action").val("D");
 			    	fn_savefile();
 					break;
 			    case 'searchEnter' :
 			    	fListEmpDv();
 					break;
 				case 'btnCloseEmpDv' :
 					gfCloseModal();
 					break;
 			}
 		});
 		
 		var upfile = document.getElementById('att_file');
		upfile.addEventListener('change',
						function(event) {
							$("#filePreview").empty();
							var image = event.target;
							var imgpath = "";
							if (image.files[0]) {								
								imgpath = window.URL.createObjectURL(image.files[0]);
								
								console.log(imgpath);
								
								var filearr = $("#att_file").val().split(".");

								var previewhtml = "";

								if (filearr[1] == "jpg" || filearr[1] == "png") {
									previewhtml = "<img src='" + imgpath + "' style='width: 150px; height: 200px;' />";
								} else {
									previewhtml = "";
								}

								$("#filePreview").empty().append(previewhtml);
							}
						});
 	}
     
    function  fListEmpDv(cpage) {    	
       cpage = cpage || 1;
       $("currentPageEmpDv").val(cpage);
		$("#account_cd").val($("#hbacc_code").val());	
		$("#detail_account_cd").val($("#hdacc_code").val());
		$("#dv_sign").val($("#hdv_sign").val());
		$("#from_date").val($("#hsdv_date").val());
		$("#to_date").val($("#hsdv_udate").val());
		// 파라메터,  callback
		var param = {
				to_date : $("#to_date").val(),
				from_date : $("#from_date").val(),
				account_cd : $("#account_cd").val(),
				detail_account_cd : $("#detail_account_cd").val(),
				dv_sign : $("#dv_sign").val(),
				pageSize : pageSize,
				cpage : cpage,
		}
		
		var listcallback = function(returndata) {
						
			console.log(returndata);
			
			$("#listEmpDv").empty().append(returndata);
			
			var dvListcnt = $("#dvListcnt").val();
			
			var paginationHtml = getPaginationHtml(cpage, dvListcnt, pageSize, pageBlockSize, 'fListEmpDv');
			
			$("#empDvPagination").empty().append(paginationHtml);
			$("#currentPageEmpDv").val(cpage);
			$("#hbacc_code").val($("#account_cd").val());
			$("#hdacc_code").val($("#detail_account_cd").val());
			$("#hdv_sign").val($("#dv_app_yn").val());
			$("#hsdv_date").val($("#from_date").val());
			$("#hsdv_udate").val($("#to_date").val());
			
		}
		
		callAjax("/accounting/Dvlist.do", "post", "text", "false", param, listcallback) ;
    	
    }
    function  hListEmpDv(cpage) {    	
       cpage = cpage || 1;
		
		// 파라메터,  callback
		var param = {
				to_date : $("#to_date").val(),
				from_date : $("#from_date").val(),
				account_cd : $("#account_cd").val(),
				detail_account_cd : $("#detail_account_cd").val(),
				dv_sign : $("#dv_sign").val(),
				pageSize : pageSize,
				cpage : cpage,
		}
		
		var listcallback = function(returndata) {
						
			console.log(returndata);
			
			$("#listEmpDv").empty().append(returndata);
			
			var hdvListcnt = $("#hdvListcnt").val();
			
			var paginationHtml = getPaginationHtml(cpage, hdvListcnt, pageSize, pageBlockSize, 'hListEmpDv');
			
			$("#empDvPagination").empty().append(paginationHtml);
			$("#currentPageEmpDv").val(cpage);
			$("#hbacc_code").val($("#account_cd").val());
			$("#hdacc_code").val($("#detail_account_cd").val());
			$("#hdv_sign").val($("#dv_app_yn").val());
			$("#hsdv_date").val($("#from_date").val());
			$("#hsdv_udate").val($("#to_date").val());
			 
		}
		
		callAjax("/accounting/Dvlist.do", "post", "text", "false", param, listcallback) ;
    	
    }
     
	function fPopModalEmpDv(dv_code,file_code) {
		//인서트
		if (dv_code== null || dv_code == ""){
			
			$("#action").val("I");
			
	    	initpopupfile();
			
	    	gfModalPop("#layer1");
		
	    //수정	
		}else{
			//단건 조회
			fDvDetail(dv_code,file_code);
		}
	}
	
	function fDvDetail(dv_code,file_code){
		
		var param = {
				dv_code : dv_code,
				file_code : file_code
		}
		
		var resultCallback = function(returndata){
			
    		console.log(JSON.stringify(returndata)  );
    		
    		console.log(returndata.dvDetail.dv_code);
    		
			initpopupfile(returndata.dvDetail);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/accounting/dvDetail.do", "post", "json", "false", param, resultCallback);
	}
	
	function initpopupfile(object) {	
		
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth()+1;
		var date = now.getDate();
		
		if((month + "").length < 2 ){
			month = "0" + month;
		}
		
		if((date+"").length < 2){
			date = "0" + date;
		}
		
		var getToday = year + "-" + month + "-" + date;
		
		console.log("아이디 : " + $("#curloginID").val());
		console.log("이름 : " + $("#Uname").val());
		
		var loginID = $("#curloginID").val();
		var userNm = $("#Uname").val();
		
		$("#dv_code").focus();
		
		if( object == "" || object == null || object == undefined) {
// 			$("#detail_account_cd_modal").show();
// 			$("#detail_account_cd_modal2").hide();
	    	
			$("#dv_code").val("");
			$("#loginID").val(loginID);
			$("#name").val(userNm);
			$("#account_cd_modal").val("");
			$("#detail_account_cd_modal").val("");
			$("#acc_name").val("");
			$("#dv_reg_date").val(getToday);
			$("#dv_use_date").val("");
			$("#dv_amt").val("");
			$("#att_file_form").show();
			$("#att_file").val("");
			$("#filePreview").empty().append("");
			$("#dv_memo").val("");
			
			$("#dv_return_form").hide();
			
			$("#btnDeleteEmpDv").hide();
			$("#btnSaveEmpDv").show();
			
// 			$("#dv_use_date").attr("readonly", false);
// 			$("#dv_amt").attr("readonly", false);
// 			$("#dv_memo").attr("readonly", false);
// 			$("#acc_name").attr("readonly", false);
			
			
			$("#account_cd_modal").prop("disabled","");
			$("#detail_account_cd_modal").prop("disabled","");
			$("#action").val("I");
		} else {			
// 			$("#detail_account_cd_modal").hide();
// 			$("#detail_account_cd_modal2").show();
// 			var html1 = "<option>" + object.dacc_name + "</option>"
// 			$("#detail_account_cd_modal2").html(html1);
	    	
			$("#dv_code").val(object.dv_code);
			$("#loginID").val(object.loginID);
			$("#name").val(object.name);
			$("#account_cd_modal").val(object.bacc_code).prop("selected",true);
			$("#detail_account_cd_modal").val(object.dacc_code).prop("selected",true);
			selectComCombo("accd", "detail_account_cd_modal", "all", object.bacc_code, object.dacc_code);
			console.log($("#detail_account_cd_modal").val());
			console.log(object.dacc_code);
			$("#acc_name").val(object.biz_code).prop("selected",true);
			$("#dv_reg_date").val(object.dv_date);
			$("#dv_use_date").val(object.dv_udate);
			$("#dv_amt").val(object.dv_fee/* .toLocaleString() */);
			$("#file_code").val(object.file_code);
			$("#dv_memo").val(object.dv_memo);
			$("#btnDeleteEmpDv").show();
			$("#att_file_form").show();
// 			$("#dv_use_date").attr("readonly", true);
// 			$("#dv_amt").attr("readonly", true);
// 			$("#dv_memo").attr("readonly", true);
// 			$("#acc_name").attr("readonly", true);
			
			
// 			파일 체크
			var fileName = object.file_name;
			console.log(object.file_name);
			var fileArr = [];
			var previewHtml = "";
			
			if (fileName == "" || fileName == null || fileName == undefined) {
				previewHtml = "";
			}else {
				fileArr = fileName.split(".");
				
				if (fileArr[1] == "jpg" || fileArr[1] == "png") {
// 					previewHtml = "<a href = 'javascript:fn_download()'> <img src='" + object.file_nadd + "' style='width : 150px; height :200px;'/>"+ object.file_nadd +"</a>"
					previewHtml = "<a href = 'javascript:fn_download()'><img src='" + object.file_nadd + "' style='width : 150px; height :200px;'/><b style='color: blue;'><u>파일 다운로드</u></b></a>"
					console.log(object.file_nadd);
				}else{
					previewHtml = "<a href = 'javascript:fn_download()'>" + object.file_nadd + "</a>";
					console.log(object.file_nadd);
				}
			}
			
			$("#filePreview").empty().append(previewHtml);
			               
// 			승인여부
			if((object.dv_sign == 1) || (object.dv_sign == 2)){
				$("#btnDeleteEmpDv").hide();
				$("#btnSaveEmpDv").hide();
			}
			else{
				$("#btnDeleteEmpDv").show();
				$("#btnSaveEmpDv").show();
			}
			
// 			반려사유
			if (object.dv_reres == "" || object.dv_reres == null || object.dv_reres == undefined) {
				$("#dv_return_form").hide();
			}else {
				$("#dv_return_form").show();
				$("#dv_return").val(object.dv_reres);
			}
			
			$("#action").val("U");
		}
	}
	/* function fDvDetailResult(data){
		console.log("음 : " +  data)
		gfModalPop("#layer1");
		
		initpopupfile(data);
	} */
	
// 	파일다운로드
	function fn_download(){
		
		var params = "<input type='hidden' name='dv_code' value='" + $("#dv_code").val() + "'/>";
		
		jQuery("<form action='/accounting/dvFileDownload.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();
		
	}
// 	파일다운로드 끝

	
	function fn_savefile() {
		
		if ($("#action").val() == "I"  || $("#action").val() == "U" ) {
	    	if(!fValidatefile()) {
	    		return;
	      	}
		}
	      
	 	   var frm = document.getElementById("empDvReg");
		   frm.enctype = 'multipart/form-data';
		   
		   var dataWithFile = new FormData(frm);
		   
			var savecallback = function(data) {
							
				console.log(  JSON.stringify(data) );
				
				if(data.result == "SUCCESS") {
					
					if($("#action").val() == "D") {
						alert("삭제 되었습니다.");
						gfCloseModal();
						fListEmpDv();
					} else{
						alert("저장 되었습니다.");
						gfCloseModal();
						fListEmpDv($("#currentpage").val());
					}
					
				}
			}
			
			// Array.from(dataWithFile.keys(), e => console.log(e + " : " + dataWithFile.get(e)));
			
			callAjaxFileUploadSetFormData("/accounting/dvSave.do", "post", "json", true, dataWithFile, savecallback);
			
		}
		
// 		폼체크
		function fValidatefile(){
			
	var arr = [
			 	["account_cd_modal","대분류를 설정하세요."],
			 	["detail_account_cd_modal","상세분류를 설정하세요."],
			 	["acc_name","거래처를 선택하세요."],
			 	["dv_use_date","사용일자를 입력하세요."],
			 	["dv_amt","금액을 입력하세요."]
//				 	if ($("#action").val() == "I" || $("#action").val() == "U") {
			 	,
//					}
			]
	
			if($("#action").val() == "I") {
				arr.push(["att_file","증빙서류를 첨부하세요."]); 
			}
			var chk = checkNotEmpty(arr);
			
			if(!chk){
				return;
			}
			return true;
		}
// 		폼체크 끝
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageEmpDv" value="1">
	<input type="hidden" id="tmpEmpDv"  value="">
	<input type="hidden" id="tmpEmpDvNm" value="">
	<input type="hidden" name="userType" id="userType" value="${userType}">
	<input type="hidden" name="curloginID" id="curloginID" value="${loginID}">
	<input type="hidden" name="Uname" id="Uname" value="${name}">
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
								지출결의서 신청</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>지출결의서 신청</span> <span class="fr">
							  <a class="btnType blue"
										href="javascript:hListEmpDv()" name="search"><span
										>조회</span></a><br/>
							</span>
						</p>
						
			<!-- 지출결의서 조회 조건 -->
						
						<div class = "app_date_apply">
							<Strong>신청일자</Strong> <input type = "date" id="from_date">~<input
										type="date" id="to_date">
							<a class="btnType blue"  href = "javascript: fPopModalEmpDv() " name="modal"><span>신규등록</span></a>
						</div>	
						
						
						<div class = "selectEmpDv">
							<ul>
								<li>
								<strong>계정대분류명</strong>
									<select id ="account_cd" name ="account_cd" >
									</select>	
								</li>
								<li>
								<strong>상세분류명</strong>
									<select id ="detail_account_cd" name ="detail_account_cd">
										<option value="">대분류를 선택해주세요.</option>
									</select>
								</li>
								<li>
								<strong>승인여부</strong>
								<select id = "dv_sign" name= "dv_sign">
									<option value = "" selected>전체</option>
									<option value = "1">승인</option>
									<option value = "2">반려</option>
									<option value = "3">승인대기중</option>
								</select>
								</li>	
							</ul>
					</div>
			
			<!-- 페이지에 출력할 컬럼명 -->			
						
					<div class="divDvList">
						<table class="col">
							<caption>caption</caption>
								<colgroup>
									<col width="14%">
									<col width="9%">
									<col width="*%">
									<col width="*%">
									<col width="10%">
									<col width="10%">
									<col width="9%">
									<col width="8%">
									<col width="*">
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
							</div>
						<div class="paging_area"  id="empDvPagination"> </div>
					</div>
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
		
		
	<!-- 지출결의서 신규 등록 및 수정 모달(단건 조회) -->	
	<form id="empDvReg">
		<input type ="hidden" name = "action" id = "action" value = "">
		<div id = "layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
			<dt>
				<strong>지출결의서 신청 및 삭제</strong>
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
								<td><input type="text" class="inputTxt p100" name="dv_code" id="dv_code"/></td>
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
								<th scope="row">계정대분류명<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="account_cd_modal" name = "bacc_code">
								</select></td>
							</tr>
							<tr>
								<th scope="row">상세과목명<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="detail_account_cd_modal" name = "dacc_code">
									<option value="">대분류를 선택해주세요.</option>
								</select>
								<!-- <select id ="detail_account_cd_modal2" name = "dacc_code2">
								</select> --></td>
							</tr>
	
							<tr>
								<th scope="row">거래처명<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="acc_name" name = "biz_code">
								</select>
								</td>
							</tr>
							<tr>
								<th scope="row">신청일자</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="dv_date" id="dv_reg_date" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="date" name="dv_udate" id="dv_use_date" class ="inputTxt p100" style ="font-size : 92%"/>
								</td>
							</tr>
							<tr>
								<th scope="row">지출금액<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="dv_fee" id="dv_amt" /></td>
							</tr>
							<tr id = "att_file_form">
								<th scope="row">증빙서류<span class="font_red">*</span></th>
								<td colspan="3">
									<span id="filePreview"></span>
									<input type = "file" name = "att_file" id = "att_file"/>
									<input type = "hidden" name = "file_code" id = "file_code" value=""/>
									<div style="font-size: 11px; color: #E76161;">*이미지 파일이 여러 장일 경우 압축하여 업로드하세요.</div>
								</td>
							</tr>
							<tr style = "height: 100px">
								<th scope="row">비고</th>
								<td colspan="3"><textarea cols="20" rows="10" name = "dv_memo" id="dv_memo"  class = "p100" style = "height: 100px"/></textarea></td>
							</tr>
							<tr id = "dv_return_form">
								<th scope ="row">반려사유</th>
								<td colspan ="3"><textarea cols="20" rows="10" name = "dv_reres" id="dv_return" readonly/></textarea></td>
							</tr>	
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveEmpDv" name="btn"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDeleteEmpDv" name="btn"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnCloseEmpDv" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href=""  class="closePop"><span class="hidden">닫기</span></a>
		</div>				
	</form> <!--// content -->

</body>
</html>