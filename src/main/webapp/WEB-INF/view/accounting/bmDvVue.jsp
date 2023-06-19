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

var container;
var layer1;
//함수 시작
$(document).ready(function(){
	
	//셀렉트박스 이닛
	fn_init();
	//초기화면 설정
	searchList();
	//버튼이벤트 설정
	oRegisterButtonClickEvent();
    // 공통코드 comcombo 사용방법 ->
    // Group Code, Combo Name, Option("all" : 전체 / "sel" : 선택 )
    // acc : 대분류, accd : 소분류
    selectComCombo("acc","account_cd","all","",""); 
    selectComCombo("accd","detail_account_cd","all","","");
    comcombo("dv_sign","dv_app_yn","all","");
    comcombo("dv_sign","detail_yn_modal","all","");
    $("#account_cd").change(function() {
		selectComCombo("accd", "detail_account_cd", "all", $("#account_cd").val(), "");  // 계정 상세 분류
	});
});

function fn_init(){
      container = new Vue({
    	  el : "#container",
    	  data : {
    		  grouplist : [],
    		  from_date : "",
    		  to_date : "",
    		  account_cd : "",
    		  detail_account_cd : "",
    		  dv_app_yn : "",
    		  pageSize : pageSize,
    		  pageNavi : ""
    	  },
    	  methods : {
    		  setGrid : function(test){
    			  searchList(test);
    		  },
    		  regclick: function(event){
    			  gfModalPop("#layer1")
    		  },
    		  grpdetail: function(no){
    			  fn_dvModal(no);
    		  }
    	  }
      });
      
      layer1 = new Vue({
    	  el : "#layer1",
    	  data: {
    		  dv_code : "",
    	      bacc_code : "",
    	      bacc_name : "",
    	      dacc_code : "",
    	      dacc_name : "",
    	      biz_code : "",
    	      biz_name : "",
    	      dv_date : "",
    	      dv_udate : "",
    	      dv_memo : "",
    	      dv_reres : "",
    	      file_code : "",
    	      loginID : "",
    	      name : "",
    	      dv_fee : "",
    	      signID : "",
    	      signName : "",
    	      detail_name : "",
    	      dv_sign : "",
    	      file_size : "",
    	      file_madd : "",
    	      file_nadd : "",
    	      file_name : "",
    	      action : ""
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
	cpage = cpage || 1;
	
	var param = {
  		  from_date : container.from_date,
		  to_date : container.to_date,
		  account_cd : container.account_cd,
		  detail_account_cd : container.detail_account_cd,
		  dv_app_yn : container.dv_app_yn,
		  pageSize : pageSize,
		  cpage : cpage
	}
	var listcallback = function(returndata){
		fnSetGrid(returndata, cpage);
	}
	callAjax("/accounting/bmDvlistVue.do","post","json",true,param,listcallback);
}
function hsearchList(cpage){
	cpage = cpage || 1;
	
	var param = {
  		  from_date : container.from_date,
		  to_date : container.to_date,
		  bacc_code : container.account_cd,
		  dacc_code : container.detail_account_cd,
		  dv_sign : container.dv_app_yn,
		  pageSize : pageSize,
		  cpage : cpage
	}
	var listcallback = function(returndata){
		fnSetGrid(returndata, cpage);
	}
	callAjax("/accounting/bmDvlistVue.do","post","json",true,param,listcallback);
}
function fnSetGrid(data, cpage){
	 container.grouplist = data.bmDvlist;
	 var totalcnt = data.totalcnt;
	 
	 var paginationHtml = getPaginationHtml(cpage,totalcnt,pageSize, pageBlock, "searchList");
	 container.pageNavi = paginationHtml;
}

function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	
	return year + "-" + month + "-" + day;
}
function fn_dvModal(no){
		console.log(no);
	var param = {
			dv_code : no
	}	
	
	var detailonecallback = function(returndata){
		console.log(  JSON.stringify(returndata)  );
		
		console.log( returndata.detail.dv_code);
		
		initpopup(returndata.detail);
		
		gfModalPop("#layer1");
	}
	callAjax("/accounting/detail.do","post","json","false",param,detailonecallback);
}

function initpopup(object){
	console.log(object);
	layer1.dv_code = object.dv_code;
	layer1.loginID = object.loginID;
	layer1.name = object.name;
	layer1.bacc_name = object.bacc_name;
	layer1.dacc_name = object.dacc_name;
	layer1.dv_sign = object.dv_sign;
	layer1.biz_name = object.biz_name;
	layer1.dv_date = object.dv_date;
	layer1.dv_udate = object.dv_udate;
	layer1.dv_fee = object.dv_fee;
	layer1.dv_memo = object.dv_memo;
	layer1.dv_reres = object.dv_reres;
	layer1.file_code = object.file_code;
	layer1.bacc_code = object.bacc_code;
	layer1.dacc_code = object.dacc_code;
	
	var fileName = object.file_name;
	console.log(object.file_name);
	var fileArr = [];
	var previewHtml = "";
	
	if (fileName == "" || fileName == null || fileName == undefined) {
		previewHtml = "";
	}else{
		fileArr = fileName.split(".");
		
		if (fileArr[1] == "jpg"||  file[1] == "png") {
			previewHtml = "<a href = 'javascript:fDownloadAttFile()'> <img src='" + object.file_nadd + "' style='width : 150px; height :200px;'/></a>"
		}else{
			previewHtml = "<a href = 'javascript:fDownloadAttFile()'>" + object.file_nadd + "</a>";
		}
	}
	$("#filePreview").empty().append(previewHtml);
}

function fDownloadAttFile(){
var params = "<input type='hidden' name='dv_code' value='" + layer1.dv_code + "'/>";
	
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
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#"class="btn_nav">회계</a> 
							<span class="btn_nav bold">지출결의서 조회 및 승인</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>지출결의서 조회</span> 
							<span class="fr"> 
								<a class="btnType blue"href="javascript:hsearchList()" name="search">
									<span id="searchEnter">조회</span>
								</a><br/>
							</span>
						</p>
						
			<!-- 지출결의서 조회 조건 -->
						
						<div class = "app_date_apply">
							<Strong>신청일자</Strong> 
							<input type ="date" id="from_date" v-model="from_date">~
							<input type ="date" id="to_date" v-model="to_date">
						</div>	
						
						
						<div class = "selectEmpDv">
							<ul>
								<li>
								<strong>계정대분류명</strong>
									<select id ="account_cd" name ="account_cd"v-model="account_cd">
									</select>	
								</li>
								<li>
								<strong>상세분류명</strong>
									<select id ="detail_account_cd" name ="detail_account_cd" v-model="detail_account_cd">
									</select>
								</li>
								<li>
								<strong>승인여부</strong>
								<select id = "dv_sign" name= "dv_sign" v-model="dv_sign">
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
							<tbody v-for="list, item in grouplist">
								<tr @click="grpdetail(list.dv_code)">
									<td>B-{{list.dv_code}}-{{list.dv_date}}</td>
									<td>{{list.bacc_name}}</td>
									<td>{{list.dacc_name}}</td>
									<td>{{list.biz_name}}</td>
									<td>{{list.dv_date}}</td>
									<td>{{list.dv_udate}}</td>
									<td>{{list.dv_fee}}</td>
									<td>{{list.detail_name}}</td>
									<td>{{list.signName}}</td>
								</tr>
							</tbody>
						</table>
						<div class="paging_area"  id="bmDvPagination" v-html="pageNavi"></div>
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
								<td><input type="text" class="inputTxt p100" name="dv_code" id="dv_code"v-model="dv_code"/></td>
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
								<th scope="row">계정대분류명<span class="font_red" readonly>*</span></th>
								<td colspan="3">
								<input type="text" id ="account_cd_modals" name = "bacc_code" v-model="bacc_name"class="inputTxt p100"  readonly/>
								</td>
							</tr>
							<tr>
								<th scope="row">상세과목명<span class="font_red" readonly>*</span></th>
								<td colspan="3">
								<input type="text" id ="detail_account_cd_modal" name = "detail_account_cd_modal" v-model="dacc_name"class="inputTxt p100" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row">승인여부<span class="font_red">*</span></th>
								<td colspan="3">
								<select id ="detail_yn_modal" name = "dv_sign"v-model="dv_sign">
								</select></td>
							</tr>
							<tr> 
								<th scope="row">거래처명<span class="font_red" >*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="acc_name" id="biz_name" v-model="biz_name"readonly/></td>
							</tr>
							<tr>
								<th scope="row">신청일자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_reg_date" id="dv_date" v-model="dv_date"readonly/></td>
							</tr>
							<tr>
								<th scope="row">사용일자<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" 
									name="dv_use_date" id="dv_udate" v-model="dv_udate"class ="inputTxt p100" style ="font-size : 92%" readonly/></td>
							</tr>
							<tr>
								<th scope="row">지출금액<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="dv_fee" id="dv_amt" v-model="dv_fee" readonly/></td>
							</tr>
							<tr id = "att_file_form">
								<th scope="row">증빙서류</th>
								<td colspan="3">
								<span id="filePreview"></span>
								 <a class="btnType gray att_file_open"
										href="javascript:fDownloadAttFile()" name="att_file_download"><span
										id="att_file_download"v-model="dv_sign">다운로드</span></a><br/>
								</td>
							</tr>
							<tr style = "height: 100px">
								<th scope="row">비고</th>
								<td colspan="3"><textarea cols="20" rows="10" name = "dv_memo" id="dv_memo" v-model="dv_memo" class = "p100" style = "height: 100px" readonly/></textarea></td>
							</tr>
							<tr id="dvrsh" >
								<th scope ="row" >반려사유</th>
								<td colspan ="3"><textarea cols="20" rows="10" name = "dv_reres" id="dv_return" v-model="dv_reres"/></textarea></td>
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