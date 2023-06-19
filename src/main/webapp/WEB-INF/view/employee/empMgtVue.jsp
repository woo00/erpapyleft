<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>인사 관리</title>

<!-- sweet alert import -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- 공통 js/css src 모은 jsp -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	//그룹코드 페이징 설정
	var empPageSize = 10; // 한 페이지당 조회되는 페이지수
	var empPageBlockSize = 5;

	/** OnLoad event : html 이 해당하는 페이지에 출력이 된 직후 발생되는 이벤트 */
	$(function() {
		
		searchUserList();
		$("#all").show();
		$("#y").hide();
		$("#n").hide();
		dateLimit();
		$("#showTotalEmp").addClass('color2');
		$("#showInEmp").removeClass('color2');
		$("#showInEmp").addClass('color1');
		$("#showOutEmp").removeClass('color2');
		$("#showOutEmp").addClass('color1');
		
		//공통코드 검색조건
		comcombo("dep_code", "dept_cd", "sel", ""); 		//	부서
		comcombo("grade_code", "poscd", "sel", ""); 		//	직급
		comcombo("biz_bank", "bank", "sel", ""); 			//	은행
		comcombo("dep_code", "searchKey_dept", "sel", ""); 	
		comcombo("grade_code", "searchKey_poscd", "sel", ""); 
		
	});
	

	function searchUserList(empCpage) {

		$("#showTotalEmp").click(function() {
			$("#state").val("");
			$("#all").show();
			$("#y").hide();
			$("#n").hide();
			$("#showTotalEmp").addClass('color2');
			$("#showInEmp").removeClass('color2');
			$("#showInEmp").addClass('color1');
			$("#showOutEmp").removeClass('color2');
			$("#showOutEmp").addClass('color1');
		});

		$("#showInEmp").click(function() {
			$("#state").val("N");
			$("#all").hide();
			$("#y").hide();
			$("#n").show();
			$("#showInEmp").addClass('color2');
			$("#showTotalEmp").removeClass('color2');
			$("#showTotalEmp").addClass('color1');
			$("#showOutEmp").removeClass('color2');
			$("#showOutEmp").addClass('color1');
		});

		$("#showOutEmp").click(function() {
			$("#state").val("Y");
			$("#all").hide();
			$("#y").show();
			$("#n").hide();
			$("#showOutEmp").addClass('color2');
			$("#showTotalEmp").removeClass('color2');
			$("#showTotalEmp").addClass('color1');
			$("#showInEmp").removeClass('color2');
			$("#showInEmp").addClass('color1');
		});

		empCpage = empCpage || 1;
			console.log("********")
			console.log($("#state").val())
		var param = {
				empPageSize : empPageSize,
				empCpage : empCpage,
				dep_codeKey : $("#dep_codeKeyParam").val(),
				grade_codeKey : $("#grade_codeKeyParam").val(),
				searchKey : $("#searchKeyParam").val(),
				searchWord : $("#searchWordParam").val(),
				from_date : $("#from_dateParam").val(),
				to_date : $("#to_dateParam").val(),
				state : $("#state").val()
			}
		
		var listcallback = function(returndata) {
			console.log(returndata);
			// 값 초기화
			$("#dep_codeKeyParam").val((""));
			$("#grade_codeKeyParam").val((""));
			$("#searchKeyParam").val((""));
			$("#searchWordParam").val((""));
			$("#from_dateParam").val((""));
			$("#to_dateParam").val(("")); 
		
			$("#empList").empty().append(returndata);

			var countListEmp = $("#countListEmp").val();
			console.log(countListEmp);
			var paginationHtml = getPaginationHtml(empCpage, countListEmp,
					empPageSize, empPageBlockSize, 'searchUserList');

			$("#empPagination").empty().append(paginationHtml);

			$("#currentpage").val(empCpage);

		};

		callAjax("/employee/empList.do", "post", "text", false, param,
				listcallback);

	}; // end of searchUserList()
	
 	function btnClick(empCpage){
		
		empCpage = empCpage || 1;
		
		var param = {
				empPageSize : empPageSize,
				empCpage : empCpage,
				dep_codeKey : $("#searchKey_dept option:selected").val(),
				grade_codeKey : $("#searchKey_poscd option:selected").val(),
				searchKey : $("#searchKey option:selected").val(),
				searchWord : $("#searchWord").val(),
				from_date : $("#from_date").val(),
				to_date : $("#to_date").val(),
				state : $("#state").val()
		}
		

		var listcallback = function(returndata) {

			$("#empList").empty().append(returndata);

			var btnCountListEmp = $("#countListEmp").val(); 
			console.log(btnCountListEmp)

			var paginationHtml = getPaginationHtml(empCpage, btnCountListEmp,
					empPageSize, empPageBlockSize, 'btnClick');

			$("#empPagination").empty().append(paginationHtml);

			$("#currentpage").val(empCpage);

		};

		callAjax("/employee/empList.do", "post", "text", false, param,
				listcallback);
			
	} 
	
	
	// 신규 조회 초기화 & 수정
	function initpopup(object) {

			// 비밀번호 확인 초기화		
			$("#passwordConfirm").val("");
			if(object == null || object == "" || object == undefined) {
				var maxNum = $("#maxNum").val();
				$("#loginID").val(maxNum);
				$("#name").val("");
				$("#security_num").val("");
				$("#password").val("");
				$("#mail1").val("");
				$("#mail2").val("");
				$("#tel1").val("");
				$("#tel2").val("");
				$("#tel3").val("");
				$("#zip_code").val("");
				$("#bank").val("");
				$("#birthday").val("");
				$("#account").val("");
				$("#addr").val("");
				$("#addr_detail").val("");
				$("#workyear").val("");
				$("#year_salary").val("");
				$("#entry_date").val(new Date().toISOString().substring(0, 10));
				$("#memo").val("");
				$("#dept_cd").val("");
				$("#poscd").val("");
				 $("#bank").val("")
				 
				 // 파일 초기화
				 $("#profileUpload").val("");			// file 업로드
				 $("#profilePreview").empty();		// 미리보기
				
				$("#poscd").prop('disabled',true);
				$("#entry_date").prop('readonly', true);
				$("#retire_date").prop('readonly', true);
				$("#name").prop('readonly', false);
				$("#security_num").prop('readonly', false);
				$("#birthday").prop('readonly', false);
				$("#btnEmpRegister").show();
				$("#btnEmpUpdate").hide();
		
				
				$("#action").val("I");
			} else {
				var email = object.email;
				var mailSplit = email.split('@');
				
				var hp = object.hp;
				var hpSplit = hp.split('-');
				
				if(object.leave_state == "Y") {
					console.log(object.leave_state);
					console.log(typeof(object.leave_state));
					$("#retire_date").prop('readonly', true);
					$("#retire_date").val(object.leave_date);
				}else {
					$("#retire_date").prop('readonly', true);
					$("#retire_date").val("");
				}
				$("#modalTitle").text("사원 수정");
				$("#loginID").val(object.loginID);
				$("#name").val(object.name);
				$("#security_num").val(object.security_num);
				$("#password").val(object.password);
				$("#birthday").val(object.birthday)
				 $("#mail1").val(mailSplit[0]);
				$("#mail2").val(mailSplit[1]);
				$("#tel1").val(hpSplit[0]);
				$("#tel2").val(hpSplit[1]);
				$("#tel3").val(hpSplit[2]);
				$("#bank").val(object.bank_code);
				$("#account").val(object.account);
				$("#dept_cd").val(object.dep_code);
				$("#poscd").val(object.grade_code);
				$("#entry_date").val(object.regdate);
				$("#year_salary").val(object.salary);
				$("#memo").val(object.user_memo);
				$("#zip_code").val(object.post);
				$("#addr").val(object.loc);
				$("#addr_detail").val(object.loc_detail);
				$("#file_code").val(object.file_code);
				
				// 업데이트 전 데이터
				$("#updatesalay").val(object.salary);
				$("#prmUpdate").val(object.grade_code);	
				console.log("원래 연봉 : "+object.grade_code);
				
				

				var file_name = object.file_name;
				var filearr = [];
				var previewhtml = "";

				
				if( file_name == "" || file_name == null || file_name == undefined) {
					previewhtml = "";
				} else {
					filearr = file_name.split(".");
					$(".fa-sharp").hide();
					
					if (filearr[1] == "jpg" || filearr[1] == "png" || filearr[1] == "jpeg" || filearr[1] == "gif") {
						previewhtml = "<a href='javascript:fn_fileUpload()'>   <img src='" + object.rel_path + "' style='width:150px; height:170px; float:center;' />  </a>";
						console.log("********")
						console.log(object.rel_path);
					} 
				}

				$("#profilePreview").empty().append(previewhtml);
				
				$("#name").prop('readonly', true);
				$("#security_num").prop('readonly', true);
				$("#birthday").prop('readonly', false);
				$("#poscd").prop('disabled',false);
				$("#btnEmpRegister").hide();
				$("#btnEmpUpdate").show();
				$("#action").val("U");
			}
	
	
	};	// end of initpopup()
	
	function execDaumPostcode() {
		new daum.Postcode({
	        oncomplete: function(data) {

	            var addr = "";		// 주소 변수
	            
	            // 검색된 기본 주소 타입: R(도로명), J(지번)
	            if(data.userSelectedType === 'R') {		// 도로명 선택했을 경우
	            	addr = data.roadAddress;					// 도로명 주소
	            } else {
	            	addr = data.jibunAddress;					// 지번 주소
	            }
	            
	         $("#zip_code").val(data.zonecode);
	         $("#addr").val(addr);
	        }
	    }).open();
	}	// end of execDaumPostcode()
	
	
	function fPopModalEmpMgt(){
		
		gfModalPop("#layer1");
		$(".fa-sharp").show();
		var maxNum = $("#maxNum").val();
		initpopup();
		
	};	// end of fPopModalEmpMgt()


	function cancleEmp() {
		gfCloseModal();
		// searchUserList(empCpage);
	}	// end of cancleEmp()
	
	function fn_detailone(loginID,file_code){

		var param = {
				loginID : loginID,
				file_code : file_code
		}
		
		var detailonecallback = function(returndata) {
			console.log(JSON.stringify(returndata));
			//deleteEmp(returndata.detailone.file_code);
			initpopup(returndata.detailone);
			gfModalPop("#layer1");

		}
		
		callAjax("/employee/empSelect.do", "post", "json", false, param, detailonecallback);
		
		
	}	// end of fn_detailone()
	
	function deleteEmp(loginID,file_code) {
		console.log(loginID+" , "+file_code);
		var param = {
				loginID : loginID,
				file_code : file_code,
				action : 'D'
		}
		
		Swal.fire({
			  title: '삭제하시겠습니까?',
			  icon: 'warning',
			  
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			}).then(result => {
				if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					var savecallback = function(){
						 Swal.fire('삭제가 완료되었습니다.');
					      searchUserList();
						  gfCloseModal("#layer2");
						 
					};
					
					callAjax("/employee/empRegist.do", "post", "json", true, param, savecallback);
				
				     
				} else {
					
					Swal.fire('취소되었습니다.','error');
				      searchUserList();
					  gfCloseModal("#layer2");
					  
					  return false;
				}
			})

			
		
	}	// end of deleteEmp()
	
	// 파일 업로드

	function fn_fileUpload() {
		 $("#profileUpload").click();
		 $("#profileUpload").change(function(event){
			 $("#profilePreview").empty();
			 var image = event.target;
			 console.log(image);
			 var imgpath = "";
			 if(image.files[0]) {	// 이미지 존재 시
					imgpath = window.URL.createObjectURL(image.files[0]);	// 삽입한 이미지에 대한 임의의 경로 생성
					var filearr = $("#profileUpload").val().split(".");	// file 확장자 구분짓기 위해 삽입 된 파일명 split 함
					
					var previewhtml = "";	// 미리보기 할 이미지 html 변수 생성
					
					if(filearr[1] == "jpg" || filearr[1] == "png" || filearr[1] == "jpeg" || filearr[1] == "gif"){	 // 삽입 된 파일이 img 파일일때
						previewhtml = "<img src= " + imgpath + " style='width:150px; height:170px; float:center;' />";
						$(".fa-sharp").hide();
						$("#profilePreview").click(function(){
							$("#profilePreview").empty();
							$(".fa-sharp").show();
						})
					} else {		// img 파일 제외한 모든 파일은 미리보기 없이 설정
						Swal.fire({
							  title: '이미지 파일만 선택 가능합니다.',
							  icon: 'warning'
							})
					}
					
					$("#profilePreview").empty().append(previewhtml);	// 미리보기 영역에 변수 append 함
				}
		 })
	}	// end of fn_fileUpload()
	
	
	function fileSave() {
		
		 // 유효성 검사
 		  if(!fValidate()){
			return;
		}  
		 
		var frm = document.getElementById("empRegister");	// 전체 body 영역
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm);	
		
		var savecallback = function(returndata){
			console.log(JSON.stringify(returndata));
			// action i & i2 일때만 
			if(returndata.action != 'U'){
				fn_save();
			};

			if(returndata.result == "SUCCESS") {
				Swal.fire({
					  title: '저장되었습니다.',
					  icon: 'success'
					})
				gfCloseModal();
				searchUserList($("empCpage").val());
			}
		
		};
		
		callAjaxFileUploadSetFormData("/employee/empRegist.do", "post", "json", true, dataWithFile, savecallback);
		
	}	// end of fileSave()
	
	function fn_save(){
		
		var param = {
				action : "I2"
		}
		
		var callback = function(){
			
		}
		callAjax("/employee/empRegist.do", "post", "json", false, param, callback);
		
	}	// end of fn_save()
	
	
	
	function fn_outEmp(loginID,regdate,name) {
		gfModalPop("#layer2");
		$("#resignLoginID").val(loginID);
		$("#resignName").val(name);
		$("#resign_entry_date").val(regdate);
		$("#confirm_retire_date").val("");
		$("#write_retire_note").val("");
		dateLimit();
		
		
	}	// end of fn_outEmp()
	
	function resignEmp(){
		
		if(!fValidate1()){
			return;
		}  

		
		var param = {
				loginID : $("#resignLoginID").val(),
				leave_date : $("#confirm_retire_date").val(),
				leave_memo : $("#write_retire_note").val()
		}
		
		var savecallback = function(){
			Swal.fire({
				  title: '저장되었습니다.',
				  icon: 'success'
				})
				searchUserList();
				gfCloseModal("#layer2");

		};
		
		callAjax("/employee/leaveUpdate.do", "post", "text", true, param, savecallback);
		
	}	// end of resignEmp()

	function dateLimit() {		// 날짜 제한
		
		var now_utc = Date.now()
		var timeOff = new Date().getTimezoneOffset()*60000;
		var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		document.getElementById("confirm_retire_date").setAttribute("min", today);
		document.getElementById("to_date").setAttribute("max", today);
	};	// end of dateLimit()
	
	
	// 유효성 검사
	function fValidate() {

	      var chk = checkNotEmpty(
	            [		// grp_cod => key 값이 빈칸이면 alert 으로 안내
 	                  [ "name", "이름을 입력해주세요" ]
		               ,   [ "security_num", "주민번호를 입력해주세요" ]
		               ,   [ "password", "비밀번호를 입력해주세요" ]
		               ,   [ "mail1", "메일주소를 입력해주세요" ]
		               ,   [ "mail2", "메일주소를 입력해주세요" ]
		               ,   [ "tel1", "연락처를 입력해주세요" ]	            
		               ,   [ "tel2", "연락처를 입력해주세요" ]	  
		               ,   [ "tel3", "연락처를 입력해주세요" ]
		               ,   [ "zip_code", "주소를 입력해주세요" ]
		               ,   [ "account", "계좌번호를 입력해주세요" ]
		               ,   [ "addr", "주소를 입력해주세요" ]
		               ,   [ "addr_detail", "주소를 입력해주세요" ]
		               ,   [ "year_salary", "연봉을 입력해주세요" ]
	                   ,   [ "dept_cd", "부서를 입력해주세요" ] 
 	                   ,   [ "dept_cd", "부서를 입력해주세요" ] 
	            ]
	      );
	      
	if(chk == true) {
		
		// 비밀번호
		if($('#password').val() !== $('#passwordConfirm').val()) {
			Swal.fire({
				  title: '비밀번호를 확인해 주세요.',
				  icon: 'warning'
				})
		   return false;
		}
		
	   // 주민번호 입력 유효성 검사
	  var security_num = $("#security_num").val();
	  
	  var numCheck =  /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/;
	  
	   if(!numCheck.test(security_num)){
		   Swal.fire({
				  title: '주민번호 형식에 맞게 입력해주세요.',
				  icon: 'warning'
				})
		   return false; 
	   };
	   
	   //  생년월일 입력 유효성 검사
	   var birCheck = /^(19|20)\d\d([- /.])(0[1-9]|1[012])\2(0[1-9]|[12][0-9]|3[01])$/;
	  var birthday = $("#birthday").val();
	  
	  if(!birCheck.test(birthday)){
		   Swal.fire({
				  title: '생년월일 형식에 맞게 입력해주세요.',
				  icon: 'warning'
				})
		   return false; 
	   };
	   
	   // 연락처 유효성 검사
	   var numCheck = /^(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*$/;
	   var tel2 = $("#tel2").val();
	   var tel3 = $("#tel3").val();
	   
	   if(!numCheck.test(tel2) || !numCheck.test(tel3)){
		   Swal.fire({
				  title: '연락처 입력란에는 숫자만 입력해주세요.',
				  icon: 'warning'
				})
		   return false; 
	   }
	   
	   // 연봉 유효성 검사  
	   var yearSalary = $("#year_salary").val();

	   if(!numCheck.test(yearSalary)){
		   Swal.fire({
				  title: '연봉 입력란에는 숫자만 입력해주세요.',
				  icon: 'warning'
				})
		   return false; 
	   };
	}
	   
	      if (!chk) {		
	         return;
	      }

	      return true;
	   };	// end of fValidate()
	
	   function fValidate1() {
		   
		   var chk = checkNotEmpty(
		            [		// grp_cod => key 값이 빈칸이면 alert 으로 안내
	 	                    [ "confirm_retire_date", "퇴사 일자를 입력해주세요" ] 
	 	                   ,   [ "write_retire_note", "퇴사 사유를 입력해주세요" ]
		            ]
		      );
		   if (!chk) {		
		         return;
		      }

		      return true;
		      
		   
	   }	// end of fValidate1()

</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="state" value="">
		<input type="hidden" id="salay" value="">
		<input type="hidden" id="empCpage" value="1">
		<input type="hidden" name="dep_codeKeyParam" id="dep_codeKeyParam" value="">
		<input type="hidden" name="grade_codeKeyParam" id="grade_codeKeyParam" value="">
		<input type="hidden" name="searchKeyParam" id="searchKeyParam" value="">
		<input type="hidden" name="from_dateParam" id="from_dateParam" value="">
		<input type="hidden" name="to_dateParam" id="to_dateParam" value="">


		

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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<a href="" class="btn_nav">인사/급여</a> <span class="btn_nav bold">인사
									관리</span> <a href="/employee/empMgt.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>사원 기본정보</span> <span class="fr"> <a
									class="btnType blue" href="javascript:fPopModalEmpMgt();"
									name="modal" id="registerBtn"><span>사원 등록</span></a>
								</span>
							</p>
							<table
								style="margin-bottom: 10px; border: 1px #e2e6ed; border-style: solid !important;"
								height="50px" width="100%" align="left">
								<tr style="border: 0px; border-color: blue">
									<td width="7%" height="25" style="font-size: 120%; text-align: center;">부서</td>
									<td width="9%" height="25" style="font-size: 100%; text-align: left;">
										<select id="searchKey_dept" name="searchKey_dept" style="width: 70px;"></select>
									</td>
									<td width="7%" height="25"
										style="font-size: 120%; text-align: center;">직급</td>
									<td width="10%" height="25"
										style="font-size: 100%; text-align: left;">
										<select id="searchKey_poscd" name="searchKey_poscd"
										style="width: 70px;"></select></td>
									<td width="9%" height="25"
										style="font-size: 100%; text-align: left; padding-left: 14px;">
										<select id="searchKey" name="searchKey" style="width: 70px;">
											<option value="loginID">사번</option>
											<option value="name">사원명</option>
									</select>
									</td>
									<td width="20%" height="25"><input type="text"
										style="width: 180px; height: 25px;" id="searchWord"
										name="searchWord"></td>
									<td width="*" height="25" align="right"
										style="padding-right: 7px;"><a
										href="javascript:btnClick()" class="btnType3 color2"
										 name="suna"><span>검 색</span></a></td>
								</tr>
							</table>
							<span class="fl"> <a id="showTotalEmp"
								class="btnType3 color1 btnStyle"
								href="javascript:searchUserList()"><span>전체</span></a> <a
								id="showInEmp" class="btnType3 color2 btnStyle"
								href="javascript:searchUserList()"><span>재직자</span></a> <a
								id="showOutEmp" class="btnType3 color1 btnStyle"
								href="javascript:searchUserList()"><span>퇴직자</span></a>
							</span>

							<div>
								<span class="fr">
									<p class="Location" style="display: flex; align-items: center;">
										<strong style="margin-left: 7%; width: 25%;">입사일
											조회&nbsp;</strong> 
											<input type="date" id="from_date" style="width: 33%;"> ~ 
											<input type="date" id="to_date" style="width: 33%;">&nbsp 
											<a class="btn_icon search" href="javascript:searchUserList()" name="search">
											<span id="searchEnter">조회</span></a>
									</p>
								</span>
							</div>


							<!-- 재직자 리스트 -->
							<div class="divEmpList">
								<table class="col">
									<colgroup>
										<col width="16%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="15%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">사번</th>
											<th scope="col">사원명</th>
											<th scope="col">부서명</th>
											<th scope="col">직급</th>
											<th scope="col">입사일자</th>
											<th scope="col">재직 구분</th>
											<th id="all" scope="col">비고</th>
											<th id="n" scope="col">퇴직처리</th>
											<th id="y" scope="col">퇴사일자</th>
											<th scope="col">삭제</th>
										</tr>
									</thead>
									<tbody id="empList">
									</tbody>
								</table>
							</div>
							<div class="paging_area" id="empPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
	
	<!-- 모달팝업 -->
	<!-- ***** 사원 등록 모달 ***** -->
	<form id = "empRegister">
	<input type ="hidden" name = "action" id = "action" value = "">
	<input type="hidden" id="updatesalay" name="updatesalay" value="">
	<input type="hidden" id="prmUpdate" name="prmUpdate" value="">
	<div id="layer1" class="layerPosition layerPop layerType2" style="width: 790px;">
		<dl>
			<dt>
				<strong>사원 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="18%">
						<col width="14%">
						<col width="20%">
						<col width="14%">
						<col width="20%">
					</colgroup>

					<tbody>
					
						<tr>
							<td rowspan="3" id = "userProfile" class = "userProfile profile" >
							<i class="fa-sharp fa-regular fa-image fa-4x" style="margin-left:28%; cursor:pointer;" onClick="fn_fileUpload()" ></i>
								<span id = "profilePreview" >
								</span>
								<input type = "file" name = "profileUpload" id ="profileUpload" style = "display:none;">
								<input type="hidden" id="file_code" name="file_code" value="" />
							</td>
							<th scope="row">사번<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginID" id="loginID" readonly /></td>
							<th scope="row">사원명<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="name" id="name" /></td>
						</tr>
						<tr>
							<th scope="row">주민등록번호<span class="font_red">*</span></th>
							<td colspan="3" ><input type="text"  class="inputTxt p100" name="security_num" id="security_num" 
								placeholder="000000-0000000"/></td>
						</tr>
						
						<tr>
							<th scope="row">생년월일</th>
							<td><input type="text" class="inputTxt p100" name="birthday" id="birthday"
								placeholder="0000.00.00" /></td>
							<th scope="row">비밀번호<span class="font_red">*</span></th>
							<td>
								<input type="password" class="inputTxt p100" name="password" id="password" placeholder="비밀번호 입력"/>
								<input type="password" class="inputTxt p100" id="passwordConfirm" placeholder="비밀번호 확인"/>
							</td>	
							
							
						</tr>
						</tbody>
				</table>
				<table class="row" style="margin-top:0.5%;">
					<colgroup>
						<col width="12%">
						<col width="31%">
						<col width="12%">
						<col width="36%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">이메일<span class="font_red">*</span></th>
								<td><input class="inputTxt" style="width: 40%" type="text" id="mail1" name="mail1"> @
								 <input class="inputTxt" style="width: 45%" type="email" id = "mail2" name="mail2"  list="defaultEmails" placeholder="직접입력"> 
								             <datalist id="defaultEmails">
								                <option value="naver.com">
								                <option value="hanmail.net">
								                <option value="gmail.com">
								             </datalist>
								</td>
							<th scope="row">연락처<span class="font_red">*</span></th>
								<td><select name="tel1" id="tel1" style="width: 30%;">
										<option value="" selected="selected">선택</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="02">02</option>
									</select>
									 - <input class="inputTxt"
									style="width: 28%" maxlength="4" type="text" id="tel2"
									name="tel2"> - <input class="inputTxt"
									style="width: 28%" maxlength="4" type="text" id="tel3"
									name="tel3">
								</td>
						</tr>
						<tr>
							<th scope= "row" rowspan = "3">주소<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" style="width: 50%;" name="zip_code" id="zip_code" readonly/>
									<input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" id ="post_cd"
										style="width: 40%; height: 100%; cursor: pointer;" />
								</td>
							<th scope= "row">은행계좌<span class="font_red">*</span></th>
								<td>
									<select id="bank" name="bank" style="width: 33%;"></select>
									<input class="inputTxt"
										style="width: 63%" type="text" id="account" name="account">
								</td>
						</tr>
						<tr>
							<td colspan ="4">
								<input type="text" class="inputTxt" style="width: 99%" name="addr" id="addr" readonly />
							</td>
						</tr>
						<tr>
							<td colspan ="4">
								<input type="text" class="inputTxt p100" name="addr_detail" id="addr_detail" style="width: 90%"/>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="row" style="margin-top:0.5%;">
					<colgroup>
						<col width="13%">
						<col width="17%">
						<col width="12%">
						<col width="20%">
						<col width="10%">
						<col width="19%">
					</colgroup>
					<tbody>
						<tr>
							<th scope= "row">부서<span class="font_red">*</span></th>
							<td colspan ="2">
								<select  id="dept_cd" name="dept_cd" style="width: 95%;"></select>
							</td>
							<th scope= "row">직급</th>
							<td colspan ="2">
								<select id="poscd" name="poscd" style="width: 95%;"></select>
							</td>
						</tr>
						<tr>
							<th scope= "row">입사일<span class="font_red">*</span></th>
							<td colspan ="2"><input type="date" id="entry_date" name = "entry_date" style = "width : 90%; height : 90%" ></td>
							<th scope= "row">퇴사일</th>
							<td colspan ="2"><input type="date" id="retire_date" name = "retire_date" style = "width : 90%; height : 90%" readonly></td>
						</tr>
						<tr>
							<th scope= "row">연봉<span class="font_red">*</span></th>
							<td colspan="2">
								<input type="text" class="inputTxt" style="width: 96%"
									name="year_salary" id="year_salary" />
							</td>
							<th scope= "row" >비고</th>
							<td colspan="2"><input type="text" class="inputTxt"  style="width: 96%" id = "memo" name ="memo" style = "resize:none;" /></td>
						</tr>
						
					</tbody>
				</table>
				
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:fileSave()" class="btnType blue" id="btnEmpRegister" name="btn"><span>저장</span></a> 
					<a href="javascript:fileSave()" class="btnType blue" id="btnEmpUpdate" name="btn"><span>수정</span></a> 
					<!-- 잘못 저장했을 경우를 위한 삭제 --> 
					<a href="javascript:cancleEmp()" class="btnType gray" id="btnCloseEmp" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form> <!-- ***** 사원 등록 모달 끝 ***** -->

	<!-- ***** 퇴직처리 모달 ***** -->
	<div id="layer2" class="layerPop layerType2" style="width: 540px;">
		<dl>
			<dt>
				<strong>퇴직처리</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="50%">
						<col width="10%">
						<col width="50%">
						<col width="10%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">사번 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" id="resignLoginID" name="resignLoginID" readonly/></td>
							<th scope="row">사원명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt" id="resignName" name="resignName" readonly/></td>
						</tr>
						<tr>
							<th scope="row">입사일<span class="font_red">*</span></th>
							<td><input type="date" id="resign_entry_date" style = "width : 90%; height : 80%" readonly></td>
							<th scope="row">퇴사일<span class="font_red">*</span></th>
							<td><input type="date" id="confirm_retire_date" style = "width : 90%; height : 80%"></td>
						</tr>
						
						<tr>
							<th scope="row" colspan ="4" style = "text-align : left;">퇴사 사유</th>
						</tr>
						<tr>
							<td colspan="4"><textarea id = "write_retire_note" name = "write_retire_note" style = "resize:none;"></textarea></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:resignEmp()" class="btnType blue" id="btnEmpOut"><span>퇴사처리</span></a>
					<a href="" class="btnType gray" id="btnCloseEmpOut"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- ***** 퇴직처리 모달 끝 ***** -->
</body>
</html>