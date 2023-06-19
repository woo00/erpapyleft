<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
     var container;
     var layer1;
     
     /* OnLoad event */ 
     $(function() {
         fn_init();

         fRegisterButtonClickEvent();

         fListEmpDv();
         
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
    });
     
     
     function fn_init(){
    	 
    	 
    	container = new Vue({
    		el : "#container",
    		data : {
    			grouplist : [],
    			srctitle : "",
    			from_date : "",
    			to_date : "",
    			pageSize : pageSize,
    			pageNavi : ""
    		},
    		methods : {
    			setGrid: function(test){
    				fListEmpDv(test);
    			},
    			regclick: function(event){
    				gfModalPop("#layer1")
    			},
    			grpdetail: function(no){
    				fPopModalEmpDv(no);
    			}
    		}
    	}); 
    	
    	layer1 = new Vue({
    		el : "#layer1",
    		data : {
    			dv_code: "",
    			loginID: "",
    			name: "",
    			bacc_name: "",
    			dacc_name: "",
    			dv_date: "",
    			dv_udate: "",
    			dv_fee: "",
    			dv_memo: "",
    			dv_reres: "",
    			dv_sign: "",
    			dacc_code: "",
    			bacc_code: "",
    			file_code: "",
    			file_name: "",
    			file_size: "",
    			file_nadd: "",
    			file_madd: "",
    			action: ""
    		}
   		});
   	}
    
    function fRegisterButtonClickEvent(){
    	$('a[name=btn]').click(function(e){
//     		e.preventdefault();
    		
			var btnId = $(this).attr('id');
			
			switch (btnId) {
			    case 'btnSaveEmpDv' :
			    	console.log("111111111111111111");
					fn_savefile();
					break;	
			    case 'btnDeleteEmpDv' :
			    	layer1.action = "D";
			    	fn_savefile();
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
    
    function fListEmpDv(cpage){
    	cpage = cpage || 1;
    	
		var param = {
				scrtitle : container.srctitle,
				from_date : container.from_date,
				to_date : container.to_date,
				pageSize : pageSize,
				cpage : cpage,
		}
		
		var listcallback = function(returndata){
			fnSetGrid(returndata, cpage);
		}
		
		callAjax("/accounting/DvlistVue.do","post","json",true,param,listcallback);
    } 
    
    function fnSetGrid(data, cpage){
    	container.grouplist = data.dvList;
    	var dvListcnt = data.dvListcnt;
    	
    	var paginationHtml = getPaginationHtml(cpage, dvListcnt, pageSize, pageBlockSize, 'fListEmpDv');
    	container.pageNavi = paginationHtml;
    }
    
//     function getToday(){
//         var date = new Date();
//         var year = date.getFullYear();
//         var month = ("0" + (1 + date.getMonth())).slice(-2);
//         var day = ("0" + date.getDate()).slice(-2);

//         return year + "-" + month + "-" + day;
//     }

    function fn_fileChange(event){
    	var chTag = event.target;
    	
    	alert(chTag);
    }
    
    function fPopModalEmpDv(no){
    	if (no == null || no == ""){
    		layer1.action = "I";
    		
    		initpopupfile();
    		
    		gfModalPop("#layer1");
    		
    	}else{
    		fDvDetail(no);
    	}
    }
    
    function fDvDetail(no){
    	var param = {
    			dv_code : no
    	}
    	
    	var resultCallback = function(returndata){
    		console.log(JSON.stringify(returndata)  );
    		
    		console.log(returndata.dvDetail.dv_code);
    		
			initpopupfile(returndata.dvDetail);
			
			gfModalPop("#layer1");
    	}
    	callAjax("/accounting/dvDetail.do", "post", "json", "false", param, resultCallback);
    }
    
    function initpopupfile(object){
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
		
		if(object =="" || object == null || object== undefined){
			layer1.dv_code="";
			layer1.loginID=loginID;
			layer1.name=userNm;
			layer1.bacc_code="";
			layer1.dacc_code="";
			layer1.biz_code="";
			layer1.dv_date=getToday;
			layer1.dv_udate="";
			layer1.dv_fee="";
			layer1.file_code="";
			layer1.dv_memo="";
			layer1.action="I";
			
			$("#filePreview").empty().append("");
			$("#dv_return_form").hide();
		}else{
			layer1.dv_code=object.dv_code;
			layer1.loginID=object.loginID;
			layer1.name=object.name;
			layer1.bacc_code="";
			selectComCombo("acc", "account_cd_modal", "all", object.bacc_code, object.bacc_code);
			layer1.dacc_code="";
			selectComCombo("accd", "detail_account_cd_modal", "all", object.bacc_code, object.dacc_code);
			layer1.biz_code="";
			selectComCombo("cli", "acc_name", "all", object.biz_code, object.biz_code);
			layer1.dv_date=object.dv_date;
			layer1.dv_udate=object.dv_udate;
			layer1.dv_fee=object.dv_fee;
			layer1.file_code=object.file_code;
			layer1.dv_memo=object.dv_memo;
			layer1.dv_reres=object.dv_reres;
			
			//파일 체크
			var fileName = object.file_name;
			var fileArr = [];
			var previewHtml = "";
			
			if (fileName == "" || fileName == null || fileName == undefined) {
				previewHtml = "";
			}else{
				fileArr = fileName.split(".");
				
				if (fileArr[1] == "jpg" || fileArr[1] == "png") {
					previewHtml = "<a href = 'javascript:fn_download()'><img src='" + object.file_nadd + "' style='width : 150px; height :200px;'/><b style='color: blue;'><u>파일 다운로드</u></b></a>"
				}else{
					previewHtml = "<a href = 'javascript:fn_download()'>" + object.file_nadd + "</a>";
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
			
			
			layer1.action="U";
			
		}
    }
    
//    	파일다운로드
	function fn_download(){
		var params ="<input type='hidden' name='dv_code' value='" + $("#dv_code").val() + "'/>";
		
		jQuery("<form action='/accounting/dvFileDownload.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();
	}
	
	function fn_savefile() {
		
		console.log(layer1.action);
		if (layer1.action == "I"  || layer1.action == "U" ) {
	    	if(!fValidatefile()) {
	    		alert(111);
	    		return;
	      	}
		}
		
		var param = {
			dv_code : layer1.dv_code,
			loginID : layer1.loginID,
			name : layer1.name,
			bacc_code : layer1.bacc_code,
			dacc_code : layer1.dacc_code,
			biz_code : layer1.biz_code,
			dv_date : layer1.dv_date,
			dv_udate : layer1.dv_udate,
			dv_fee : layer1.dv_fee,
			file_code : layer1.file_code,
			dv_memo : layer1.dv_memo,
			action : layer1.action
		}
			
// 	 	   var frm = document.getElementById("empDvReg");
// 		   frm.enctype = 'multipart/form-data';
		   
// 		   var dataWithFile = new FormData(frm);
// 		   console.log(dataWithFile);
			var savecallback = function(data) {
							
				console.log(  JSON.stringify(data) );
				
				if(data.result == "SUCCESS") {
					
					if(layer1.action == "D") {
						alert("삭제 되었습니다.");
						gfCloseModal();
						fListEmpDv();
					} else{
						alert(333);
						alert("저장 되었습니다.");
// 						gfCloseModal();
						fListEmpDv($("#currentpage").val());
					}
					
				}
			}
			
			// Array.from(dataWithFile.keys(), e => console.log(e + " : " + dataWithFile.get(e)));
			
			callAjaxFileUploadSetFormData("/accounting/dvSave.do", "post", "json", true, param, savecallback);
			
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
	
			if(layer1.action == "I") {
				arr.push(["att_file","증빙서류를 첨부하세요."]); 
			}
			var chk = checkNotEmpty(arr);
			if(!chk){
				return;
			}
			return false;
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
							  <a class="btnType blue" href="javascript:hListEmpDv()" name="search">
							  <span>조회</span></a><br/></span>
						</p>
						
			<!-- 지출결의서 조회 조건 -->
						
						<div class = "app_date_apply">
							<Strong>신청일자</Strong>
							<input type="date" id="from_date" name="from_date" v-model="from_date" /> ~
                            <input type="date" id="to_date" name="to_date" v-model="to_date" />
							<a class="btnType blue"  @click = "javascript: fPopModalEmpDv() " name="modal"><span>신규등록</span></a>
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
								<tbody  v-for="list, item in grouplist" id="listEmpDv">
										<tr @click="grpdetail(list.dv_code)">
											<td>B-{{list.dv_code}}-{{list.dv_date}}</td>
											<td>{{ list.bacc_name}}</td>
											<td>{{ list.dacc_name }}</td>
											<td>{{ list.biz_name }}</td>
											<td>{{ list.dv_date }}</td>
											<td>{{ list.dv_udate }}</td>
											<td>{{ list.dv_fee }}</td>
											<template v-if="list.dv_sign == 1">
											<td>승인</td>
											</template>
											<template v-if="list.dv_sign == 2">
											<td>반려</td>
											</template>
											<template v-if="list.dv_sign == 3">
											<td>승인대기</td>
											</template>
											<td>{{ list.signName }}</td>
										</tr>
								</tbody>
							</table>
							</div>
						<div class="paging_area"  id="empDvPagination"  v-html="pageNavi"> </div>
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
								<td><input type="text" class="inputTxt p100" name="dv_code" id="dv_code" v-model="dv_code"/></td>
							</tr>
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="loginID" v-model="loginID"readonly/></td>
							</tr>
							<tr>
								<th scope="row">사원명</th>
								<td><input type="text" class="inputTxt p100" name="name" id="name" v-model="name"readonly/></td>
							</tr>
							<tr>
								<th scope="row">계정대분류명<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="account_cd_modal" name = "bacc_code" v-model="bacc_code">
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
								<td colspan="3"><input type="text" class="inputTxt p100" name="dv_date" id="dv_reg_date"v-model="dv_date" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="date" name="dv_udate" id="dv_use_date" v-model="dv_udate"class ="inputTxt p100" style ="font-size : 92%"/>
								</td>
							</tr>
							<tr>
								<th scope="row">지출금액<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="dv_fee" id="dv_amt" v-model="dv_fee"/></td>
							</tr>
							<tr id = "att_file_form">
								<th scope="row">증빙서류<span class="font_red">*</span></th>
								<td colspan="3">
									<span id="filePreview"></span>
									<input type = "file" name = "att_file" id = "att_file"/>
									<input type = "hidden" name = "file_code" id = "file_code" value=""v-model="file_code"/>
									<div style="font-size: 11px; color: #E76161;">*이미지 파일이 여러 장일 경우 압축하여 업로드하세요.</div>
								</td>
							</tr>
							<tr style = "height: 100px">
								<th scope="row">비고</th>
								<td colspan="3"><textarea cols="20" rows="10" name = "dv_memo" id="dv_memo" v-model="dv_memo" class = "p100" style = "height: 100px"/></textarea></td>
							</tr>
							<tr id = "dv_return_form">
								<th scope ="row">반려사유</th>
								<td colspan ="3"><textarea cols="20" rows="10" name = "dv_reres" id="dv_return" v-model="dv_reres"readonly/></textarea></td>
							</tr>	
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a class="btnType blue" id="btnSaveEmpDv" name="btn"><span>저장</span></a>
						<template v-if="action !='I'"> 
							<a class="btnType blue" id="btnDeleteEmpDv" name="btn"><span>삭제</span></a> 
						</template>
						<a href=""	class="btnType gray"  id="btnCloseEmpDv" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href=""  class="closePop"><span class="hidden">닫기</span></a>
		</div>				
	</form> <!--// content -->

</body>
</html>