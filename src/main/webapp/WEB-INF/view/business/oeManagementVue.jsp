<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- 거래처 관리  -->

<script type="text/javascript">
// 페이징 설정 
var pageSize = 5; // 행 다섯개 
var pageBlockSize = 5;  // 블록 갯수 일단 출력

// 함수 시작
$(document).ready(function(){
	//견적서 목록 조회 
	 oemList();
	//모달창 초기화
	// 버튼 이벤트 등록
	oRegisterButtonClickEvent();

});




/** 버튼 이벤트 등록 */
function oRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

		switch (btnIdEst) {

			case 'btnUpdateOem' : // 신규등록 , 저장 
				oeSave();
				break;
			case 'btnUpdateOem2' : // 수정 , 저장 
				oeUpdate();
				break;
			case 'btnDeleteOem' : // 삭제 
				oDeleteOem();
				break;
			case 'btnSearchOem': // 검색 
				break;
			case 'btnCloseOem' : // 모달 닫기 함수 [나는 하나로 썼음 ]
				gfCloseModal();
				break;
		} 
	});
}

function oemList(cpage){
	
	$("#client_search").val($("#hbiz").val());
	$("#est_date").val($("#hedate").val());
	cpage = cpage || 1;
		//거래처 셀렉트박스
		var client_search = $("#client_search").val();
		//날짜 1
		var est_date = $("#est_date").val();
	
	var param = {
			cpage : cpage,
			pageSize : pageSize,
			client_search : client_search,
			est_date : est_date,
			
	}
	var listCallback = function(data){
		
		$("#listOemManage").empty().append(data);
		var counteoemlist = $("#counteoemlist").val();
		var paginationHtml = getPaginationHtml(cpage, counteoemlist, pageSize, pageBlockSize, 'oemList');
		$("#OemPagination").empty().append(paginationHtml);
		$("#hbiz").val($("#client_search").val());
		$("#hedate").val($("#est_date").val());
		
		
		}
	
		callAjax("/business/oeManagementList.do", "post", "text", "false",	param, listCallback);
	}
	
	
function searchOemList(cpage){
	cpage = cpage || 1;
		//거래처 셀렉트박스
		$("#client_search").val();
		//날짜 1
		$("#est_date").val();
	
	console.log($("#check").val()+"+++++++++++++++++++++++++++");
	var param = {
			cpage : cpage,
			pageSize : pageSize,
			client_search : $("#client_search").val(),
			est_date : $("#est_date").val(),
			
	}
	var listCallback = function(data){
		
		$("#listOemManage").empty().append(data);
		var counteoemlist = $("#counteoemlist").val();
		var paginationHtml = getPaginationHtml(cpage, counteoemlist, pageSize, pageBlockSize, 'oemList');
		$("#OemPagination").empty().append(paginationHtml);
		
		$("#hbiz").val($("#client_search").val());
		$("#hedate").val($("#est_date").val());
		
		}
	
		callAjax("/business/oeManagementList.do", "post", "text", "false",	param, listCallback);
	}

	function oemdetail(num, action) {
		$("#action").val(action);
		$("#est_num").val(num);
		var param = {
			num : num,
			action : action
		}

		var listCallback = function(data) {
			var html2 = "<td>" + data.oelist.prd_name + "</td>" + "<td>"
					+ data.oelist.price + "</td>" + "<td>"
					+ Math.floor((data.oelist.price) * 0.1) + "</td>" + "<td>"
					+ Math.floor((data.oelist.price) * 1.1) + "</td>" + "<td>"
					+ data.oelist.supply_value + "</td>" + "<td>"
					+ data.oelist.est_cnt + "</td>";
			var html3 = "<td>"
					+ data.oelist.prd_name
					+ "</td>"
					+ "<td>"
					+ data.oelist.price
					+ "</td>"
					+ "<td>"
					+ Math.floor((data.oelist.price) * 0.1)
					+ "</td>"
					+ "<td>"
					+ Math.floor((data.oelist.price) * 1.1)
					+ "</td>"
					+ "<td>"
					+ data.oelist.supply_value
					+ "</td>"
					+ "<td>"
					+ "<input type='number' id='oeCntss' name='oeCntss'/>"
					+ "</td>"
					+ "<td>"
					+ data.oelist.loginID
					+ "</td>"
					+ "<td>"
					+ "<input type='radio' name='feeYn2' id='feeYn2' value='Y' checked>"
					+ "완료"
					+ "<br>"
					+ "<input type='radio'  name='feeYn2'   id='feeYn2'  value= 'N' checked>"
					+ "미완료" + "</td>"
			$("#detailinven").val(data.oelist.supply_value);
			$("#sp_code").val(data.oelist.sp_code);

			if (action == 'E') {
				$("#loginID").val(data.loginID);
				$("#OemDetailList1").html(html2);
				$("#txt_money").val(
						numberToKorean(Math.floor((data.oelist.price) * 1.1
								* (data.oelist.est_cnt))));
				$("#agNms").hide();
				$("#agNmss").hide();
				$("#estyn").hide();
				$("#estynn").hide();

			} else {
				$("#loginID").val(data.loginID);
				$("#OemDetailList1").html(html3);
				$("#txt_money").val(
						numberToKorean(Math.floor((data.oelist.price) * 1.1
								* (data.oelist.est_ocnt))));
				$("#agNms").show();
				$("#agNmss").show();
				$("#estyn").show();
				$("#estynn").show();
			}

			if ($("#loginID").val() != data.oelist.loginID) {
				console.log(data.oelist.est_yn);
				$("#oeCntss").val(data.oelist.est_ocnt).attr("readonly", true);
				$(
						"input[type=radio][name='feeYn2'][value='"
								+ data.oelist.est_yn + "']").prop('checked',
						true);
				$("input[type=radio][name='feeYn2']:checked").val(
						data.oelist.est_yn).attr('onclick', 'return false;');
				$("input[type=radio][name='feeYn2']").val(data.oelist.est_yn)
						.attr('onclick', 'return false;');
			} else {
				$("#oeCntss").val(data.oelist.est_ocnt).attr("readonly", true);
				$(
						"input[type=radio][name='feeYn2'][value='"
								+ data.oelist.est_yn + "']").prop('checked',
						true);
				$("input[type=radio][name='feeYn2']:checked").val(
						data.oelist.est_yn);
				$("input[type=radio][name='feeYn2']").val();

			}

			var rtitle = '';
			var html4 = '';
			if (action == 'E'
					|| data.oelist.loginID != '${sessionScope.loginId}') {
				rtitle = "견적서 상세조회";
				$("#btnUpdateOem2").hide();
				html4 = "<div id='divtitle' style='color:white'><b>" + rtitle
						+ "</b></div>";
			} else {
				rtitle = "수주서 상세 조회 및 수정";
				$("#btnUpdateOem2").show();
				html4 = "<div id='divtitle' style='color:white'><b>" + rtitle
						+ "</b></div>";
			}
			var html5 = "<th scope='row' colspan='2' >" + data.oelist.biz_name
					+ "</th><th scope='row' colspan='2' >"
					+ data.myoelist.biz_name + "</th>";

			$("#clcom").html(html5);
			$("#titledt").html(html4);
			$("#estimate_no").val(data.oelist.biz_code);
			$("#slip_no").val(data.myoelist.biz_code);
			$("#cop_no1").val(data.oelist.biz_number);
			$("#erp_copnum1").val(data.myoelist.biz_number);
			$("#direct_nm").val(data.oelist.biz_iname);
			$("#emp_name").val(data.loginID);
			$("#addr").val(data.oelist.biz_addr);
			$("#erp_addr").val(data.myoelist.biz_addr);
			$("#addr_other").val(data.oelist.biz_daddr);
			$("#erp_addr_other").val(data.myoelist.biz_daddr);
			$("#local_tel1").val(data.oelist.biz_phone);
			$("#erp_tel1").val(data.myoelist.biz_phone);
			$("#limit_date").val(addDays(data.oelist.est_edate, 30));
			$("#oprd_code").val(data.oelist.prd_code);

		}
		callAjax("/business/oeManagementEmodal.do", "post", "JSON", "false",
				param, listCallback);

		gfModalPop("#layer2");
	}

	function numberToKorean(number) {
		var inputNumber = number < 0 ? false : number;
		var unitWords = [ '', '만', '억', '조', '경' ];
		var splitUnit = 10000;
		var splitCount = unitWords.length;
		var resultArray = [];
		var resultString = '';

		for (var i = 0; i < splitCount; i++) {
			var unitResult = (inputNumber % Math.pow(splitUnit, i + 1))
					/ Math.pow(splitUnit, i);
			unitResult = Math.floor(unitResult);
			if (unitResult > 0) {
				resultArray[i] = unitResult;
			}
		}

		for (var i = 0; i < resultArray.length; i++) {
			if (!resultArray[i])
				continue;
			resultString = String(resultArray[i]) + unitWords[i] + resultString;
		}

		return resultString;
	}

	function addDays(date, day) {
		//date는 문자열로 받는다 ex, '2023-05-08'
		var result = new Date(date);
		result.setDate(result.getDate() + day);
		result = result.toISOString().substr(0, 10);
		return result;
	}

	function newModal(num, action) {
		$("#est_num").val(num);
		$("#action").val(action);
		var param = {
			num : num,
			action : action,

		}

		var dataCallback = function(data) {
			$("#clNm").val(data.oelist.biz_iname);
			$("#prNm").val(data.oelist.prd_name);
			$("#agNm").val("");
			$("#inven").val(data.oelist.supply_value);
			$("#oCnt").val("");
			$("#oprd_code").val(data.oelist.prd_code);
		}
		callAjax("/business/oeManagementNewModal.do", "post", "JSON", "false",
				param, dataCallback);

		gfModalPop("#layer1");
	}

	function oeSave() {
		if ($("#oCnt").val() == null || $("#oCnt").val() == undefined
				|| $("#oCnt").val() == "" || $("#oCnt").val() == 0) {
			alert("수량을 적어주세요");
			return false;
		}
		;
		if (Number($("#oCnt").val()) > Number($("#inven").val())) {
			alert("재고 수량이 적습니다. 재고를 확인해 주세요.");
			return false;
		}
		;

		var param = {
			num : $("#est_num").val(),
			action : $("#action").val(),
			est_ocnt : $("#oCnt").val(),
			est_yn : $("input[type=radio][name='feeYn']:checked").val(),
			prd_code : $("#oprd_code").val(),
			sp_code : $("#sp_code").val()
		}
		var dataCallback = function(result) {
			alert("저장되었습니다.");
			gfCloseModal();
			oemList();
		}
		callAjax("/business/oeManagementSave.do", "post", "JSON", "false",
				param, dataCallback);

	}
	function oeUpdate() {
		if ($("#oeCntss").val() == null || $("#oeCntss").val() == undefined
				|| $("#oeCntss").val() == "" || $("#oeCntss").val() == 0) {
			alert("수량을 적어주세요");
			return false;
		}
		;
		if (Number($("#oeCntss").val()) > Number($("#detailinven").val())) {
			alert("재고수량이 부족합니다. 재고를 확인해 주세요.");
			return false;
		}
		;

		var param = {
			num : $("#est_num").val(),
			action : 'U',
			est_ocnt : $("#oeCntss").val(),
			est_yn : $("input[type=radio][name='feeYn2']:checked").val(),
			prd_code : $("#oprd_code").val()
		}

		var updatecallback = function(result) {

			alert("저장되었습니다.");
			gfCloseModal();
			oemList();
		}
		callAjax("/business/oeManagementSave.do", "post", "JSON", "false",
				param, updatecallback);
	}
</script>
 
 

</head>
<body>
	<form id="oemForm1" action=""  method="">
	    <input type="hidden" name="action" id="action" value="">
	    <input type="hidden" name="loginID" id="loginID" value="">
	    <input type="hidden" name="est_num" id="est_num" value="">
	    <input type="hidden" name="oprd_code" id="oprd_code" value="">
	    <input type="hidden" name="sp_code" id="sp_code" value="">
	    <input type="hidden" name="hbiz" id="hbiz" value="">
	    <input type="hidden" name="hedate" id="hedate" value="">
	    <input type="hidden" name="check" id="check" value="">
  
		   
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
	                        class="btn_nav">영업</a> <span class="btn_nav bold"> 수주서 작성 및 조회
	                        </span> <a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
	                  </p>
	
	                  <p class="conTitle">
	                     <span>수주서 작성 및 조회</span>
	                  </p>
	                  
	                  

	          <!-- 검색조회 -->
	          <!-- form 안에 form이 맞나? 버튼두고 자바스크립트로  보내기  자바스크립트 함수 하나 만들기   xxxxxx안하기로 함  -->        
	          <!--  == 콤보박스로 체크  -->   
	     
                 <!--검색   -->
                 <br>       
			                    
		  <div style = "padding : 3% 10% 3% 13%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
				<!-- 거래처 콤보박스   -->
				<div>
					<b style ="padding: 0 1% 0 1%" >거래처</b>
					<select name="client_search" id ='client_search'>
								<option value="">선택</option>
								<c:forEach items="${oemlist}" var="list">
									<option value="${list.biz_code}">${list.biz_name}</option>
								</c:forEach>
					</select>
		                    
	                  	<!-- 달력 조회  -->
							<b style ="padding: 0 3% 0 5%">견적서 작성 날짜 </b>
							<input type="date" id="est_date" >
					
							<a class="btnType blue" href="javascript: searchOemList();"  name="modal" style ="float : right; ">
							 	<span>조회</span>
							</a> 
						</div>
                  </div>
                   <!-- 검색조건 끝 -->
							
							
							
	                <!-- 조회목록 윗칸띄우기 -->
	                  <div class="zldf" style ="padding-top: 2%;margin: auto;"> </div>

	                     <table class="col">
	                        <caption>caption</caption>
	                        <colgroup>
	                           <col width="12.5%">
	                           <col width="12.5%">
	                           <col width="10%">
                               <col width="15%">
	                           <col width="10%">
	                           <col width="10%">
	                           <col width="10%">
	                        </colgroup>
	                        
	                        
	                       <thead>
	                           <tr>
	                           <th scope="col">견적서번호</th>
	                             <th scope="col">수주서번호</th>
	                              <th scope="col">거래처</th>
	                               <th scope="col">제품이름</th>
	                               <th scope="col">단가</th>
	                               <th scope="col">부가세</th>
	                              <th scope="col">공급가액</th>
	                           </tr>
	                        </thead>
	                        

	                        <tbody id="listOemManage"></tbody> <!--BizParnerCallBack으로 넘어감.여기는 틀만 만드는곳  -->
	                     </table>
	                  	<!-- 페이징에리어 -->
						<div class="paging_area"  id="OemPagination"></div>
	               </div> 
	               <!-- content end -->
	         </div>
					 <h3 class="hidden">풋터 영역</h3>
	                 <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
	          </div>
	
	
		   <!-- 모달팝업 ==  신규 등록 1 -->
		   <div id="layer1" class="layerPop layerType2"  style="width: 800px;">
		      <dl>
		         <dt>
		            <div id="divtitle" style="color:white">수주서 신규등록</div>
		         </dt>
		         <dd class="content">
		            <!-- s : 여기에 내용입력 -->
		            <table class="row">
		               <caption>caption</caption>
		               <colgroup>
		                  <col width="20%">
		                  <col width="30%">
		                  <col width="10%">
		                  <col width="10%">
		                  <col width="10%">
		                  <col width="10%">
		               </colgroup>
		
		               <tbody>
							<tr>
								<th scope="row" >거래처</th>
								<th scope="row" >제품이름</th>
								<th scope="row" >재고</th>
								<th scope="row" >수량 </th>
								<th scope="row">입금여부</th>
								<th scope="row" >승인자</th>
							</tr>
							<tr>
								<td><input type="text" class="inputTxt p100" name="clNm"  id="clNm" readOnly/></td>
								<td><input type="text" class="inputTxt p100" name="prNm"  id="prNm"  readOnly/></td>
								<td><input type="number" class="inputTxt p100" name="inven"  id="inven" readOnly/></td>
								<td><input type="number" class="inputTxt p100" name="oCnt"  id="oCnt" /></td>
								<td><input type="radio"  name="feeYn"   id="feeYn"  value='Y''>완료
								<br>
										<input type="radio"  name="feeYn"   id="feeYn"  value= 'N'>미완료
								</td>
								<td><input type="text" class="inputTxt p100" name="agNm"   id="agNm"  readOnly/></td>
							</tr>
						</tbody>
			            </table>
			            <div class="btn_areaC mt30">
			               <a href="" class="btnType blue" id="btnUpdateOem" name="btn"><span>등록</span></a> 	
			               <a href=""   class="btnType gray"  id="btnCloseOem" name="btn"><span>취소</span></a>
			            </div>
			         </dd>
			      </dl>
			      <a href="" class="closePop"><span class="hidden">닫기</span></a>
			   </div>
			   <!-- 모달1 끝 -->
			   
			   
			
		   
	</form>
	
	<!-- 모달팝업2 ==  readOnly -->
	   <div id="layer2" class="layerPop layerType2"  style="width: 800px;">
	      <dl>
	         	<dt id= "titledt">
	         		
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
	                <tr>
					   
					    
	                       <tr id="clcom">
		                     <th scope="row" colspan="2" ></th>
		                      <th scope="row" colspan="2" ></th>
		                  </tr>
		  
		                
		                  <tr>
		                  <!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
		                   <td hidden=""><input type="text" class="inputTxt p100" name="estimate_no" id="estimate_no" /></td> 
		                      <!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
		                   <td hidden=""><input type="text" class="inputTxt p100" name="slip_no" id="slip_no" /></td> 
                       	   
                       	   <th scope="row">사업자등록번호</th>
		                     <td  class="inputTxt p100">  	
				                  <input type="text"   name="cop_no1" id="cop_no1"   readOnly>
		     
		     			 <th scope="row">사업자등록번호</th>
	                     	<td  class="inputTxt p100">
                  				 <input type="text"   name="erp_copnum1" id="erp_copnum1"  readOnly>
	                  </tr>
	                  <tr>
	                     <th scope="row">담당자</th>
	                     <td><input type="text" class="inputTxt p100" name="direct_nm" id= "direct_nm" readOnly/></td>
	                      <th scope="row">담당자</th>
	                     <td><input type="text" class="inputTxt p100" name="emp_name" id= "emp_name" readOnly/></td>
	                  </tr>
	          
	                  <tr>
                         <th scope="row">주소</th>
	                     	<td >
	                     		<input type="text" class="inputTxt p100"  name="addr" id="addr" readOnly />
	                     	</td>
	                     	<th scope="row">주소</th>
		                     	<td>
		                     		<input type="text" class="inputTxt p100"  name="erp_addr" id="erp_addr"  readOnly/>
		                     	</td>
	                  </tr>
	                  <tr>
                         <th scope="row">나머지 주소</th>
	                     	<td >
	                     		<input type="text" class="inputTxt p100"  name="addr_other" id="addr_other"  readOnly/>
	                     	</td>
	                     	<th scope="row">나머지주소</th>
		                     	<td>
		                     		<input type="text" class="inputTxt p100"  name="erp_addr_other" id="erp_addr_other"  readOnly/>
		                     	</td>
	                  </tr>
	                   <tr> 	   
	                   	<th scope="row">TEL</th>
		                     <td  class="inputTxt p100">  	
				                  <input type="text"   name="local_tel1" id="local_tel1" readOnly/>
		     
		     			 <th scope="row">TEL</th>
	                     	<td  class="inputTxt p100">
                  				 <input type="text"   name="erp_tel1" id="erp_tel1"  readOnly/>
              				
	                  </tr>
	                  
	                  	                  
	           <!-- 거래처 + erp 회사 정보 끝 -->
	           
	           
	                  <!--  한 칸 띄우기  -->
	            	  <tr>
                     	<td  colspan="4" class="inputTxt p100">
		              </tr>
		             						
				     	<tr>
                     		<td scope="row" colspan="4" >
	                     		<br>
	                     		    1. 귀사의 일익 번창하심을 기원합니다. <br>
	                     		    2.하기와 같이 견적드리오니 검토하기 바랍니다.<br>
		              	</tr>
           			<tr>

	                  
	                  <tr>
			   			 <th scope="row" class="han_money" id="han_money" >  합 계 </th>
			  				<td><input type="text" id="txt_money" maxlength="12"  readOnly  />
			  				</td>
			  				<th scope="row" class="han_money" id="han_money" >견적서 유효기간</th>
			  				<td><input type="text" id="limit_date"  name ='limit_date'  readOnly />
			  				</td>
			  			</tr>
	            
		              
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="10%">
                           <col width="10%">
                            <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%" id="agNmss">
                           <col width="10%" id="estyn">
                        </colgroup>
                       <thead>
  
  		
                           <tr>
                             <th scope="col">제품명</th>
                              <th scope="col">공급가액</th>
                               <th scope="col">세액</th>
                               <th scope="col">제품단가</th>
                               <th scope="col" id= "detailinven">제품재고</th>
                               <th scope="col" id= "oeCnts">수량</th>
                               <th scope="col" id="agNms">승인자</th>
                               <th scope="col" id="estynn">입금여부</th>
                           </tr>
                        </thead>
	                    <tbody">
								<tr id="OemDetailList1"></tr>
							</tbody>    <!--  detail 끼워넣기  -->
	            </table>
	            <div class="btn_areaC mt30">
	   				 <a href="" class="btnType blue" id="btnUpdateOem2" name="btn"><span>수정</span></a>
	               <a href=""   class="btnType gray"  id="btnCloseOem" name="btn"><span>취소</span></a>
	            </div>
	         </dd>
	      </dl>
	     
	      <a href="" class="closePop"><span class="hidden">닫기</span></a>
	   </div>
	   
   </body>
</html>