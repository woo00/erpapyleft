<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<!--vue.js  -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<!-- 영업계획  -->
<style>
	#layer1 {
		overflow-y: auto;
	}
</style>



<script type="text/javascript">

// 그룹코드 페이징 설정
var pageSizeSalePlan = 8;		
var pageBlockSizeSalePlan = 5;	



// 함수 시작
	$(document).ready(function(){
		
		//셀렉박스 먼저 세팅
        fn_init();
        
		//거래처 목록
		fn_planList();
		
		// 버튼 이벤트 등록
		pRegisterButtonClickEvent();
        
		// '목표일' 오늘 날짜 이전은 선택하지 못하도록
		$('#sp_goal2').datepicker({ minDate: 0 });	
		
		// '등록일' 선택한 날짜1 이전은 선택하지 못하도록
	    $("#sp_date1").change(function() {
	    	document.getElementById("sp_date2").setAttribute("min", $("#sp_date1").val());
	    });
	   

	});





	/** 버튼 이벤트 등록 */
	function pRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnIdPlan = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

			switch (btnIdPlan) {
				case 'btnUpdatePlan' : // 수정사항 저장
					fn_save();
					break;
				case 'btnDeletePlan' : // 삭제 
					$("#action").val("D");
					fn_save();
					break;
				case 'btnSearchPlan': // 검색 
					fn_planList();
					break;
				case 'btnClosePlan' : // 모달 닫기 함수
					gfCloseModal();
					break;
			}
		});
	}
	
	
	function fn_init() {
		
		// 공통코드 comcombo 사용방법
		// Group Code, Combo Name, Option("all" : 전체 / "sel" : 선택 )
		// l : 대분류, m : 소분류, p: 제품
       
		//-조회 셀렉박스-
		selectComCombo("cli","client_search","all","","");  // 거래처 대분류
        selectComCombo("pro","proall","all","","");  // 제품 대분류
        
        productCombo("l", "prolall", "all", "", "",  "");  // 제품 대분류 코드
        
        $("#prolall").change(function() {
           productCombo("m", "promall", "all", $("#prolall").val(), "",  "");  // 제품 소분류
           $("#prodall").children('option:not(:first)').remove();   // 제품 옵션 전부 삭제
        });
        
        $("#promall").change(function() {
           productCombo("p", "prodall", "all", $("#prolall").val(), $("#promall").val(),  "");  // 제품 목록
        });
        
        //-모달 셀렉박스-
        selectComCombo("cli","client_nmPop","sel","","");  // 거래처 대분류
        selectComCombo("pro","proall2","sel","","");  // 제품 대분류
        
        productCombo("l", "prolall2", "sel", "", "",  "");  // 제품 대분류 코드
        
        $("#prolall2").change(function() {
           productCombo("m", "promall2", "sel", $("#prolall2").val(), "",  "");  // 제품 소분류
           $("#prodall2").children('option:not(:first)').remove();   // 제품 옵션 전부 삭제
        });
        
        $("#promall2").change(function() {
           productCombo("p", "prodall2", "sel", $("#prolall2").val(), $("#promall2").val(),  "");  // 제품 목록
           $("#prodall2").children('option:not(:first)').remove();   // 제품 옵션 전부 삭제
        });
		
	}
	
	
	
	
	
	
	
	// 목록 조회
	function fn_planList(cpage){
		
		cpage = cpage || 1;
		
		//PlCurrentpage 에 현재 페이지 설정
		$("#PlanCurrentPage").val(cpage);
		
		//조회(검색)할 데이터
		var param = {
				pageSize123 : pageSizeSalePlan,
				cpage : cpage,
				client_search : $("#client_search").val(),
				sp_date1 : $("#sp_date1").val(),
				sp_date2 : $("#sp_date2").val(),
				prolall	: $("#prolall").val(),
				promall	: $("#promall").val(),
				prodall	: $("#prodall").val()
		}
		console.log(" param :                    " ,param);
		console.log("param.valueOf() :           ",  param.valueOf());
		 
		 
		var planListCallBack = function(data){
			console.log("planListCallBack data:         " + data);
			
			// 신규 목록 삭제하고 다시 생성
			$("#listPlan").empty().append(data);
			
			// 총 갯수 추출
			var planCnt = $("#planCnt").val();
			
			// 네비게이션
			//현재 페이지,          총건수        ,     페이지 사이즈        ,      페이지 블럭            ,    리스트함수
			var planHtml = getPaginationHtml (
					cpage,
					planCnt,
					pageSizeSalePlan,
					pageBlockSizeSalePlan,
					'fn_planList'
					);
			
			console.log("planHtml:          " + planHtml);
			
			//네비게이션 비우고 다시 채우기
			$("#PlanPagination").empty().append(planHtml);
			
			// 값이 제대로 왔나 확인 
			var PlCurrentpage  = $("#PlanCurrentPage").val();
			console.log("PlCurrentpage  :                     " +  PlCurrentpage );
			
		}
		
		callAjax("/business/planList.do", "post", "text", false, param, planListCallBack);
	}
	
	
	
	
	
	
	//계획등록 모달창 - 모달실행	
	//계획등록 모달, 거래처이름 클릭시 모달 fn_PlanModal
	function fn_PlanModal(sp_code) {
		
        //insert할 데이터
        var param = {
        		spcode : sp_code,	//조회 - 영업번호        
        		client_search : $("#client_nmPop").val(),
        		sp_goal : $("#sp_goal2").val(),
        		prolall : $("#prolall2").val(),
        		promall : $("#promall2").val(),
        		prodall	: $("#prodall2").val(),
        		sp_gcnt : $("#goal_amt").val(),
        		action : $("#action").val()
        }
        
        //콜백함수
        var planOneCallBack = function(data){
        	console.log(data);
        	fn_modal(data);
        }
        
        callAjax("/business/planListSelect.do", "post", "json", false, param, planOneCallBack);
		
	}
	
	function fn_modal(data){
		
		//모달창팝업
    	gfModalPop("#layer1");
		
		//신규등록시
    	if(data.detailone123 == null || data.detailone123 == "" || data.detailone123 == undefined){
        	$("#client_nmPop").val("");
        	$("#sp_goal2").val("");
        	$("#prolall2").val("");
        	$("#promall2").val("");
        	$("#prodall2").val("");
        	$("#goal_amt").val("");
        	
        	$('#divtitle').empty();
			$("#divtitle").append("<strong>신규계획등록</strong>");
			
			$("#btnUpdatePlan").show();
       		$("#btnDeletePlan").hide();
			
        	$("#action").val("I")
        
        //수정시	
    	} else {
    		$("#spcode").val(data.detailone123.sp_code);								//영업번호
    		$("#client_nmPop").val(data.detailone123.biz_code).prop("selected",true);	//거래처이름
        	$("#sp_goal2").val(data.detailone123.sp_goal).prop("selected",true);		//목표일
        	$("#prolall2").val(data.detailone123.pb_code);								//대분류
            //productCombo(comtype, combo_name, type, lcode, mcode, selvalue)
        	productCombo("m", "promall2", "sel", data.detailone123.pb_code, "",  data.detailone123.ps_code);  // 제품 소분류
            productCombo("p", "prodall2", "sel", data.detailone123.pb_code, data.detailone123.ps_code,  data.detailone123.prd_code);  // 제품 목록
            $("#goal_amt").val(data.detailone123.sp_gcnt).prop("selected",true);		//목표수량
            
        	$('#divtitle').empty();
			$("#divtitle").append("<strong>영업계획수정</strong>");
			
        	$("#action").val("U");
        	 
        	if( data.detailone123.loginID == data.nowLogin ){
        		$("#btnUpdatePlan").show();
        		$("#btnDeletePlan").show();
        	}else{
        		$("#btnUpdatePlan").hide();
        		$("#btnDeletePlan").hide();
        	}
        	
    	}
    	
    	
    }
	
	

	
	
	//저장
	function fn_save(data) {
		
		if(!fValidate()) {
			return;
		}
		
		var param = {
				spcode : $("#spcode").val(),	//삭제 - 영업번호  
				client_search : $("#client_nmPop").val(),
				prolall	: $("#prolall2").val(),
				promall	: $("#promall2").val(),
				prodall	: $("#prodall2").val(),
				sp_goal : $("#sp_goal2").val(),
				sp_gcnt : $("#goal_amt").val(),
				action : $("#action").val(),
		}
		
		
		var saveCallBack = function(returndata){
			console.log(  JSON.stringify(returndata) );
			
			
			 if($("#action").val() != "I"){
				 spcode = $("#spcode").val();
			 }
			 console.log("    #spcode                    : " + $("#spcode").val());
			
			
			if(returndata.result == "SUCCESS") {
				
				if($("#action").val() == "I") {
					alert("저장되었습니다.")
				} else if ($("#action").val() == "U") {
					alert("수정되었습니다.")
				} else if ($("#action").val() == "D") {
					alert("삭제되었습니다.")
				}
				
				gfCloseModal();
				fn_planList($("#PlanCurrentPage").val());
				
			} 
			
		}
		
		callAjax("/business/savePlanList.do", "post", "json", "false", param, saveCallBack);
		
	}
	
	
	function fValidate() {
		
		var chk = checkNotEmpty(
				[
						[ "client_nmPop", "거래처를 선택해 주세요." ],
						[ "sp_goal2", "목표일을 선택해 주세요." ],
						[ "prolall2", "대분류를 선택해 주세요." ],
						[ "promall2", "소분류를 선택해 주세요." ],
						[ "prodall2", "제품을 선택해 주세요." ],
						[ "goal_amt", "목표수량을 선택해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
		
	}
	
	
	

	 
</script>



<body>
<form id="salesForm1" action=""  method="">

	   <input type="hidden" name="action" id="action" value=""> <!-- form을 Callback으로 보냄  -->
	   <input type="hidden" name="loginId" id="loginId" value="${loginId}">
	   <input type="hidden" name="spcode" id="spcode" value=""> 
	   <input type="hidden" name="PlanCurrentPage" id="PlanCurrentPage" value="">

		   
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
	                        class="btn_nav">영업</a> <span class="btn_nav bold"> 영업계획
	                        </span> <a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
	                  </p>
	
	                  <p class="conTitle">
	                     <span>영업계획</span> <span class="fr"> <a
	                        class="btnType blue" href="javascript:fn_PlanModal();" name="modal"><span>계획등록</span></a>
	                     </span>
	                  </p>
	                  
	                  

	          <!-- 검색조회 -->
	          <!--  == 콤보박스로 체크  -->   
	     
                 <!--검색   -->
                 <br>       
                 <div style = "padding : 3% 10% 3% 13%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
						
					 <div>	
							<b>거래처</b>
							<select name="client_search" id ='client_search'></select>
	
		                  	<!-- 달력 조회  -->
							<b>등록일</b>
							<input type="date" id="sp_date1" name="sp_date1" style="padding : 0.7%;"> 
							 ~ 
							<input type="date" id="sp_date2" name="sp_date2" style="padding : 0.7%;" >  
								
							<tr>	
								<br>
							    <b>대분류</b>
                   				<td>
										<select id="prolall" name="prolall"></select>
								</td>
					
	                            <b>소분류</b>
								<td>
										<select id="promall" name="promall">
											<option value="">대분류를 선택해주세요</option>
										</select>
			    				<b>제품</b>
										<select id="prodall" name="prodall">
											<option value="">소분류를 선택해주세요.</option>
										</select>
								</td>
							</tr>
							
							<a href="" class="btnType blue" id="btnSearchPlan" name="btn" style ="float : right; ">
							 	<span>조회</span>
							</a> 
					 </div>
			            
                  </div>
                   <!-- 검색조건 끝 -->
							
	
                  			
	                <!-- 조회목록 윗칸띄우기 -->
	                  <div class="zldf" style ="padding-top: 2%;margin: auto;"> </div>
                <!-- 조회목록 -->
                     <table class="col">
                        <caption>caption</caption>
                       	<colgroup>
                           <col width="10%">
                           <col width="14%">
                           <col width="14%">
                           <col width="10%">
                           <col width="15%">
            
                           <col width="*">
	               		</colgroup>

                        <thead>
                           <tr>
                              <th scope="col">등록일</th>
                              <th scope="col">거래처이름</th>
                              <th scope="col">대분류</th>
                              <th scope="col">소분류</th>
                              <th scope="col">제품이름</th>
                              <th scope="col">목표수량</th>
                              <th scope="col">실적수량</th>
                              <th scope="col">목표일</th>
                           </tr>
                        </thead>
                        <tbody id="listPlan"></tbody>
                     </table>
                  	<div class="paging_area"  id="PlanPagination"> </div>
                  </div>
   				</div>
   			</li>
   		</ul>
 	  </div>
   </div>
   
   

   <!-- 모달팝업 ==  신규 등록 1 -->
		   <div id="layer1" class="layerPop layerType2"  style="width: 800px;">
		   
		      <dl>
		         <dt>
		            <div id="divtitle" style="color:white; font-size: 16px;">신규계획 등록</div>
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
							<!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
							<td hidden=""><input type="text" class="inputTxt p100" name="estimate_no" id="estimate_no" /></td> 
		     
		                    <th scope="row">거래처 이름<span class="font_red">*</span></th>
							
							<td> <!-- 거래처 콤보박스   -->
								<select name="client_search" id ='client_nmPop'></select>	
							</td>
		                	
		                	<th scope="row">목표일<span class="font_red">*</span></th>
                   				<td>
									<input type="text" placeholder="연도-월-일" 
									id="sp_goal2" name="sp_goal2" 
									style="padding: 0.7%; width: 173px; height: 30px;" >
								</td>
		                
			                <tr>
			                    <th scope="row">대분류<span class="font_red">*</span></th>
                   				<td>
									<select id="prolall2" name="scm_big_class1" ></select>
								</td>
	                            <th scope="row">소분류<span class="font_red">*</span></th>
								<td>
									<select id="promall2" name="scm_middle_class1">
										<option value="">대분류를 선택해주세요.</option>
									</select>
								</td>
			                </tr>
			
			                <tr>
                             	<th scope="row">제품<span class="font_red">*</span></th>
								<td>
									<select id="prodall2" name="divproducttall1">
										<option value="">소분류를 선택해주세요.</option>
									</select>
								</td>
						        <th scope="row">목표수량<span class="font_red">*</span></th>
                    			<td colspan="3">
                    			 	<input type='number' name="goal_amt" id="goal_amt" 
                    			 	style="width: 176px; height: 30px;" />
               			 		</td>
			                </tr>

			               </tbody>
			            </table>
			            <div class="btn_areaC mt30">
				             <a href="" class="btnType blue" id="btnUpdatePlan" name="btn"><span>저장</span></a>
			              	 <a href="" class="btnType blue" id="btnDeletePlan" name="btn"><span>삭제</span></a>
			             	 <a href="" class="btnType gray" id="btnClosePlan" name="btn"><span>닫기</span></a>
			            </div>
			      </dl>
			      <a href="" class="closePop"><span class="hidden">닫기</span></a>
			   </div>
			   <!-- 모달1 끝 -->
		
	</form>	   
      

</body>
