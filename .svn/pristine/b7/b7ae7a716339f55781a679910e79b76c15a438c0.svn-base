<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- 우편번호 조회 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 api   -->
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">
//우편번호 검색 
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('biz_zip').value = data.zonecode;
            document.getElementById("biz_addr").value = roadAddr;
            document.getElementById("biz_daddr").value = data.jibunAddress;

        }
    }).open();
}
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	/** OnLoad event */ 
	$(function() {
		
		selectComCombo("cli","bizname","all","","");
		//selectComCombo("acc","baccname","all","","");  // 계정 대분류
		//comcombo('grade_code', 'bizname', 'sel', '');
	
		fRegisterButtonClickEvent();
	
		searchBizPartner();
		
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			//btnSavefile
			switch (btnId) {
			    case 'btnSave' :
				fn_save();
				break;
			    case 'btnDelete' :
			    	$("#action").val("D");
					fn_save();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});	
	}

//	$('a[name=modal]').click(function(e){	
//		param = {
//				bizname : $("#bizname").val(),
//				pageSize : pageSize,
//				cpage : cpage,
//		};
//		console.log("모달클릭시"+param);
//	
//	});
	
	
	function searchBizPartner(cpage) {
		
		var	param = {
				pageSize : pageSize,
				cpage : cpage,
		};
		
		if(!cpage) {
			param['bizname'] =  $("#bizname").val()
			param.cpage = 1;
			cpage = 1;
		}

		var listcallback = function(returndata) {
			//	alert($("#bizname option:selected").val());
			//	alert($("#baccname option:selected").val()+1);
			//console.log(returndata);
			$("#listBizParter").empty().append(returndata);

			//console.log(returndata);
			var bizPartnerCnt = $("#bizPartnerCnt").val();
			
			var paginationHtml = getPaginationHtml(cpage, bizPartnerCnt, pageSize, pageBlockSize, 'searchBizPartner');
			
			$("#noticePagination").empty().append(paginationHtml);
			
			$("#currentpage").val(cpage);
			//console.log("test1");
			//console.log($("#currentpage").val(cpage));
		}
		callAjax("/business/bizPartnerlist.do", "post", "text", "false", param, listcallback) ;
	}
	
function fPopModalBizPartner() {
	initpopup();
	gfModalPop("#wrap_area2");

	}
	

	function fn_save() {
	
		
		console.log($("#action").val());
		var savecallback = function(returndata) {
			console.log( "++++++++++++++++");		
			console.log(  JSON.stringify(returndata) );
			
			if(returndata.result == "SUCCESS") {
				alert("저장 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					console.log("currentpage  "+$("#currentpage").val());
					searchBizPartner($("#currentpage").val());
				} else {
					searchBizPartner();
				}
				
			}
		}
		
		callAjax("/business/bizPartListSave.do", "post", "json", "false", $("#bizForm").serialize(), savecallback) ;
		
	}
	
	function fValidate() {
	    	
			var chk = checkNotEmpty(
					[
						 ["biz_name", "업체명을 입력해주세요!"],
						 ["local_tel1", "번호를 입력해주세요"],
						 ["local_tel2", "번호를 입력해주세요"],
						 ["local_tel3", "번호를 입력해주세요"],
						 ["biz_iname", "담당자를 입력해주세요"],
						 ["biz_phone1", "번호를 선택해주세요"],
						 ["biz_phone2", "번호를 입력해주세요"],
						 ["biz_phone3", "번호를 입력해주세요"],
						 ["biz_number1", "사업자번호를 입력해주세요"],
						 ["biz_number2", "사업자번호를 입력해주세요"],
						 ["biz_number3", "사업자번호를 입력해주세요"],
						 ["biz_bank", "계좌번호를 입력해주세요"],
						 ["biz_ac", "계좌번호를 입력해주세요"]
					]
			);
	
			if (!chk) {
				return;
			}
	
			return true;
		}
	
	function initpopup(object) {	
		
		if( object == "" || object == null || object == undefined) {
			//콤보박스
			//$("#client_search").val("");
			
			$("#biz_name").val("");
			
			$("#local_tel1").val("");
			$("#local_tel2 ").val("");
			$("#local_tel3").val("");
			
			$("#biz_iname").val("");
			$("#biz_phone1").val("");
			$("#biz_phone2").val("");
			$("#biz_phone3").val("");
			
			$("#biz_zip").val("");

			$("#biz_addr").val("");
			$("#biz_daddr").val("");

			$("#biz_category").val("");
			$("#biz_number1").val("");
			$("#biz_number2").val("");
			$("#biz_number3 ").val("");
			
			$("#biz_bank").val("국민은행");
			$("#biz_ac").val("");
			$("#biz_memo").val(""); 
			
			
			$("#biz_phone1").val("");
			$("#biz_phone2").val("");
			$("#biz_phone3").val("");
			
			$("#email1").val("");
			$("#email2").val("none_email");			
			$("#memo").val("");
			
			
			$("#divtitle").empty().append("<strong>거래처등록</strong>");
			
			$("#action").val("I");
			
			$("#btnDelete").hide();
			
			//$("#btnSave").focus();
			document.getElementById("btnSave").focus();
			
		} else {			

			//2 - 2 단건조회 수정 모달창 
			$("#biz_code").val(object.biz_code);
		 	
		 	$("#biz_name").val(object.biz_name); // object.실제컬럼이름

			// 회사번호 
			$("#local_tel2").val(object.biz_hp);	
			var beta0 = $("#local_tel1").val();
			var beta1 = $("#local_tel2").val();
			var beta1Answer = beta1.split("-");
			
			console.log("beta1Answer    ",beta1Answer);
			
			$("#local_tel2").val(beta1Answer[1]);
			var beta2 = $("#local_tel3").val();

			console.log("beta1Answer    ",beta1Answer[2]);
			$("#local_tel3").val(beta1Answer[2]);
			
			console.log("beta0    " ,  beta0);
			console.log("beta1    " ,  beta1);
			console.log("beta2    " ,  beta2);
			if(beta0 != beta1Answer[0]){
				console.log("beta0    " ,  beta0);
				
				$("#local_tel1").val(beta1Answer[0]);
			}
			
			

			//담당자 이름
			$("#biz_iname").val(object.biz_iname);
			
			//담당자 번호 split [표본]
			$("#biz_phone2").val(object.biz_phone);
			var alpa0 =$("#biz_phone1").val();
			var alpa1 = $("#biz_phone2").val();
			var alpa1Answer = alpa1.split("-");
			console.log("alpa0    ",alpa0);
			console.log("alpa1    ",alpa1);
			console.log("alpa1Answer    ",alpa1Answer);
			
			
			$("#biz_phone2").val(alpa1Answer[1]);
			var alpa2 = $("#biz_phone3").val();
			console.log("alpa1Answer    ",alpa1Answer[2]);
			$("#biz_phone3").val(alpa1Answer[2]);
			
			if(alpa0 != alpa1Answer[0]){
				console.log("alpa0    " ,  alpa0);
				
				$("#biz_phone1").val(alpa1Answer[0]);
			}
			

			$("#biz_zip").val(object.biz_zip);
			$("#biz_addr").val(object.biz_addr);
			$("#biz_daddr").val(object.biz_daddr);
			

			$("#email1").val(object.biz_email);
			var gamma0 = $("#email1").val();
			var gamma0Answer = gamma0.split('@');
			console.log("gamma0Answer" , gamma0Answer[0]);

			$("#email1").val(gamma0Answer[0]);
			
			var gamma1 = $("#email2").val();		
			//if(gamma1 != gamma0Answer[1]){
				$("#email2").val(gamma0Answer[1]);	
			//}
			
			$("#biz_category").val(object.biz_category);
			
			$("#biz_number").val(object.biz_number);
			var biznumber = object.biz_number;
			var biz_number = biznumber.split('-');
			
			
			$("#biz_number1").val(biz_number[0]);
			$("#biz_number2").val(biz_number[1]);
			$("#biz_number3 ").val(biz_number[2]);
			
			
			
			// 셀렉트 
			$("#biz_bank").val(object.biz_bank).text();
			var bank0 = $("#biz_bank").val();
			console.log("bank0 " ,  bank0);

			$("#biz_ac").val(object.biz_ac);
			$("#biz_memo").val(object.biz_memo);			
			

			$("#divtitle").empty().append("<strong>거래처수정</strong>");
		
			$("#action").val("U");
			
			//$("#btnDelete").show();
			
			
		}
		
	}
	
	
    function fn_detailone(biz_code,popuptype) {
    	
    	var param = {
    			biz_code : biz_code
    	}
    	
    	var detailonecallback = function(returndata) {
    		console.log(  JSON.stringify(returndata)  );
    		
    		console.log( returndata.detailone.biz_code);
    		
    		if(popuptype == 1) {
    			initpopup(returndata.detailone);
        		
    			gfModalPop("#wrap_area2");
    		} 
    		
    	}
    	
    	callAjax("/business/detailone.do", "post", "json", "false", param, detailonecallback) ;
    }    
    //// 파일 미첨부 끝
     
    
    
 

</script>

</head>
<body>
<form id="bizForm" action=""  method="">		
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentpage" id="currentpage" value="">
	
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
								class="btn_nav bold">영업</span> <span class="btn_nav bold">거래처 관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" height=auto>
							<span>거래처 관리</span> <span class="fr"> 
							   제목				   
								   <span>거래처명</span>
									   <select id="bizname" style="width:80px" >
									   		<option value="전체">전체</option>
										    <option value="test">test</option>
										    <option value="test2">test2</option> 
										    <option value="본사">본사</option>
									  </select>
	
								  	<a	class="btnType blue" href="javascript:searchBizPartner();" name="modal" ><span>조회</span></a>
									<a	class="btnType blue" href="javascript:fPopModalBizPartner()"  id="submitBtn"><span>거래처등록</span></a>
				
							</span>
						</p>
					
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
			                           <col width="10%">
			                           <col width="14%">
			                           <col width="14%">
			                           <col width="14%">
			                           <col width="14%">
			                           <col width="10%">
			                           <col width="*">
									</colgroup>
								<thead>
									<tr>
										<th scope="col">등록번호</th>
										<th scope="col">거래처이름</th>
										<th scope="col">주소</th>
										<th scope="col">회사전화</th>
										<th scope="col">담당자</th>
										<th scope="col">tel</th>
										<th scope="col">email</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listBizParter">
								</tbody>				
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	   <!-- 모달팝업 ==  거래처 등록 1 -->
	   <div id="wrap_area2" class="layerPop layerType2"  style="width: 800px;">
	      <dl>
	         <dt>
	            <div id="divtitle" style="color:white"></div>
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
				
						 <!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값 // INT가 아니여서라는 이유도 있음   -->
						  <td hidden=""><input type="text" class="inputTxt p100" name="biz_code" id="biz_code" /></td> 
	     
	                     <th scope="row">업체명 <span class="font_red">*</span></th>
	                     <td hidden=""><input type="hidden" id="biz_code"></td>
	                     <td><input type="text" class="inputTxt p100" name="biz_name" id="biz_name" /></td>
	                     
	                     <th scope="row">업체전화<span class="font_red">*</span></th>
	                     <td  class="inputTxt p100">
	                     	<select style ="width :20%" id="local_tel1" name = "local_tel1" >
	                     	  	<option value ="" selected>선택</option>
		                    	 <option value ="02">02</option>
		                     	 <option value ="031">031</option>
		                     	 <option value ="053">053</option>
	                     	 </select>
	                     	 -<input type="text"   name="local_tel2" id="local_tel2" style ="width :30%; height :70%" maxlength="4" >
	                     	 -<input type="text"  name="local_tel3" id="local_tel3" style ="width :30%; height :70%" maxlength="4"/>
		                  </tr>
		                  <tr>
		                     <th scope="row">담당자<span class="font_red">*</span></th>
		                     <td><input type="text" class="inputTxt p100" name="biz_iname" id= "biz_iname" /></td>
		                     
		                     <th scope="row">휴대전화<span class="font_red">*</span></th>
		                     <td  class="inputTxt p100">
		                     	<select style ="width :20%"  id="biz_phone1" name = "biz_phone1">
		                     	 	 <option  value ="" selected>선택</option> 
			                    	 <option value ="010"  >010</option>
			                     	 <option value ="017" >017</option>
			                     	 <option value ="018" >018</option>
		                     	 </select>
		                     	 -<input type="text" id="biz_phone2"  name = "biz_phone2" style ="width :30%; height :70%" maxlength="4" >
		                     	 -<input type="text"  id="biz_phone3" name = "biz_phone3" style ="width :30%; height :70%" maxlength="4"/>
		                  </tr>
		                  

		               
		                  <tr>
		                     <th scope="row">우편번호</th>
		             		  <td  class="inputTxt p100">
		             		  
		             		  	<input type="text"  name="biz_zip" id="biz_zip" style ="width :35%; height :90%" >
		             		 <input type="button" onclick="sample4_execDaumPostcode()" class="btnType blue" id="btnSearchGrpcod" name="btn"  value="우편번호 찾기"><br>
		             		  </td>			
		                  </tr>
		                  
		                  
		       
		                  <tr>
		                     <th scope="row">주소</th>
		                     <td colspan="3"><input type="text" class="inputTxt p100"
		                        name="biz_addr" id="biz_addr" /></td>
		                  </tr>
		                  
		                  <tr>
		                     <th scope="row">나머지주소</th>
		                     <td colspan="3"><input type="text" class="inputTxt p100"
		                        name="biz_daddr" id="biz_daddr" /></td>
		                  </tr>

		                  
		            
		                  
		                  <tr>
		                     <th scope="row" >업체이메일</th>
			                     <td colspan="3"> <!--  칸 늘림  -->
			                     	<input type="text"  name="email1" id="email1" style ="width :20%; height :80%" > @ 
			                  		<select style ="width :20% "  name="email2" id="email2">
			                  			 <option  value ="none_email" selected>선택</option>
				                    	 <option  value ="naver.com">naver.com</option>
				                     	 <option  value ="daum.net">daum.net</option>
				                     	 <option  value ="gmail.com">gmail.com</option>
			                     	 </select>
			                    </td>
		                  </tr>
		                  
		                  <tr>
			                  <th scope="row" >업종</th>
				                <td colspan="3">
				                   <input type="text"  name="biz_category" id="biz_category" style ="width :50%; height :80%" > 
				                 </td>
		                  </tr>
		                  
		                 <tr>
		                 	<th scope="row" >사업자등록번호<span class="font_red">*</span></th>
				               <td colspan="3">
				                  <input type="text"  name="biz_number1" id="biz_number1" style ="width :15%; height :80%"  maxlength="3">-
				                  <input type="text"  name="biz_number2" id="biz_number2" style ="width :15%; height :80%"  maxlength="2" >-
				                  <input type="text"  name="biz_number3" id="biz_number3" style ="width :15%; height :80%"  maxlength="5" >
				                   
				             </td>
		                  </tr>
		                  
		                   
		                  <tr>
		                     <th scope="row" >은행<span class="font_red">*</span></th>
			                     <td> <!--  칸 늘림  -->
			                  		<select id="biz_bank" name="biz_bank" style="width: 33%;">
			                  			<option value="국민은행" selected>국민은행</option>
										<option value="기업은행" >기업은행</option>
										<option value="농협은행" >농협은행</option>
										<option value="하나은행" >하나은행</option>
										<option value="우리은행" >우리은행</option>
									</select>
									<input class="inputTxt" style="width: 63%" type="text" id="biz_ac" name="biz_ac" maxlength="12">
			                    </td>
			                
		                   </tr>
		                    <tr>
			                  <th scope="row" >메모</th>
				                <td colspan="3">
				                   <input type="text"  name="biz_memo" id="biz_memo" style ="width :50%; height :80%" > 
				                 </td>
		                  </tr>
		               </tbody>
		            </table>
		            <div class="btn_areaC mt30">
		               <a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
		               <a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
		               <a href=""   class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
		            </div>
		         </dd>
		      </dl>
		      <a href="" class="closePop"><span class="hidden">닫기</span></a>
		   </div>
		   <!-- 모달1 끝 -->
	
   

</form>
</body>
</html>