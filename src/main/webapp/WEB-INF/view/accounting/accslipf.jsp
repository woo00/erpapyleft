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
<style>
.scrolltbody {
/* 	    display: block; */
	    border-collapse: collapse;
	    border: 1px solid rgb(187,194,205);
	}
	.scrolltbody th { border: 1px solid #000; }
	.scrolltbody td { border: 1px solid #000; border-top: 0; }
	.scrolltbody tbody {
	 /*    display: block;
	    height: 300px;
	    overflow: auto; */
	}
	.scrolltbody > tr > th:nth-of-type(1){ width: 84px; }
	.scrolltbody > tr > th:nth-of-type(2){ width: 93px; }
	.scrolltbody > tr > th:nth-of-type(3){ width: 92px; }
	.scrolltbody > tr > th:nth-of-type(4){ width: 92px; }
	.scrolltbody > tr > th:nth-of-type(5){ width: 92px; }
	.scrolltbody > tr > th:nth-of-type(6){ width: 92px; }
	.scrolltbody > tr > th:nth-of-type(7){ width: 100px; }
	.scrolltbody > tr > th:nth-of-type(8){ width: 100px; }
	.scrolltbody > tr > th:nth-of-type(9){ width: 92px; } 

/* 	.accSlipListModal > tr > td:nth-of-type(1){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(2){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(3){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(4){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(5){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(6){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(7){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(8){ width: 10%; }
	.accSlipListModal > tr > td:nth-of-type(9){ width: 10%; }   */
	
	
/* 	.accSlipListModal > tr > td:nth-of-type(1){ width: 80px; }
	.accSlipListModal > tr > td:nth-of-type(2){ width: 98.5px; }
	.accSlipListModal > tr > td:nth-of-type(3){ width: 88px; }
	.accSlipListModal > tr > td:nth-of-type(4){ width: 88px; }
	.accSlipListModal > tr > td:nth-of-type(5){ width: 88px; }
	.accSlipListModal > tr > td:nth-of-type(6){ width: 3px; }
	.accSlipListModal > tr > td:nth-of-type(7){ width: 90px; }
	.accSlipListModal > tr > td:nth-of-type(8){ width: 90px; }
	.accSlipListModal > tr > td:nth-of-type(9){ width: 92px; }  */

</style>


<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;

	/** OnLoad event */ 
	$(function() {
		
		selectComCombo("acc","baccname","all","","");  // 계정 대분류
	
		searchaccslipf();
	

	});
	  $("#bizname").change(function() {
		 // alert($("#bizname option:selected").val());
         });

	
	
	function searchaccslipf(cpage) {
		
		cpage = cpage || 1;
		
		// 파라메터,  callback
		var param = {

				//srcsdate : $("#srcsdate").val(),
				//srcedate : $("#srcedate").val(),
				//bizname : $("#bizname").val(),
				baccname : $("#baccname").val(),
				pageSize : pageSize,
				cpage : cpage,
		}
		
		if(!cpage) {
			param['baccname'] =  $("#baccname").val()
			param.cpage = 1;
			cpage = 1;
		}
		var listcallback = function(returndata) {
			//alert($("#bizname").val());
			//	alert($("#baccname option:selected").val()+1);
			console.log(returndata);
			
			$("#listNotice").empty().append(returndata);

			var countaccslipflist = $("#countaccslipflist").val();
			console.log("cpage  :  " + cpage);
			console.log("countaccslipflist  :  " + countaccslipflist);
			console.log("pageSize  :  " + pageSize);
			console.log("pageBlockSize  :  " + pageBlockSize);
			
			var paginationHtml = getPaginationHtml(cpage, countaccslipflist, pageSize, pageBlockSize, 'searchaccslipf');
			
			$("#noticePagination").empty().append(paginationHtml);
			
			$("#currentpage").val(cpage);
			
		}
		
		callAjax("/accounting/accslipflist.do", "post", "text", "false", param, listcallback) ;
	}
	
function fPopModalAccSlip() {
	var param = {

			srcsdate : $("#srcsdate").val(),
			srcedate : $("#srcedate").val(),
			bizname : $("#bizname option:selected").val(),
			baccname : $("#baccname option:selected").val(),

	}
	var listcallback = function(returndata) {

		//	alert($("#baccname option:selected").val()+1);
		console.log(returndata);
		
		$("#listResult").empty().append(returndata);
		
		var inamt = $("#inamt").val();
		console.log("inamt  :  " + inamt);
		var outamt = $("#outamt").val();
		console.log("outamt  :  " + outamt);	
		
		$("#inamtarea").empty().append(inamt.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		$("#outamtarea").empty().append(outamt.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		
	}
	
	callAjax("/accounting/accslipfmodal.do", "post", "text", "false", param, listcallback) ;

	gfModalPop("#wrap_area2");
	
	
	
	}
	
	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="loginId" id="loginId" value="${loginId}">
	<input type="hidden" name="userNm" id="userNm" value="${userNm}">
	<input type="hidden" name="noticeno" id="noticeno" value="">
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
								class="btn_nav bold">회계</span> <span class="btn_nav bold">회계전표 조회</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" style="height:auto" >
							<span>회계전표 조회</span> <span class="fr"> 
	   

								   <span>계정과목</span>
								   		<select id="baccname" style="width:80px">
										    <option value="전체">전체</option>
										    <option value="급여">급여</option>
										    <option value="영업">영업</option>
									  </select>
									  <a	class="btnType blue" href="javascript:searchaccslipf();" name="modal" ><span>조회</span></a>
		 							 <a	class="btnType blue " href="javascript:fPopModalAccSlip()" id="submitBtn"><span style="margin-bottom: 10px;">상세조회</span></a>
					
							</span>
						</p>
				
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="3%">
										<col width="6%">
										<col width="9%">
										<col width="9%">
										<col width="8%">
									</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">계정코드</th>
										<th scope="col">계정과목</th>
										<th scope="col">지출</th>
										<th scope="col">수입</th>
									</tr>
								</thead>
								<tbody id="listNotice">
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
		<div id="wrap_area2" class="layerPop layerType2" style="width: 900px; top: 111.5px; left: 220px; display: block;">
			<dl>
				<dt>
					<strong>회계전표</strong>
				</dt>
				<dd style="height: auto;">
					<h1 style="font-size: 50px; height: 40px; padding-top: 2%; width: 50%;">회계전표</h1>
			<div style="width:100%; height:200px; overflow:auto">		
					<table class="scrolltbody col" >
						<colgroup>
										<col width="91.11px">
										<col width="91.11px">
										<col width="91.11px">
										<col width="91.11px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">전표번호</th>
								<th scope="col">계정과목</th>
								<th scope="col">지출</th>
								<th scope="col">수입</th>
							</tr>
						</thead>
						<tbody  scope="col" id="listResult" class = "accSlipListModal">
						</tbody>
					</table>
				</div>
					<table  class="col">
                        <colgroup>
								<col width="525px">
								<col width="247px">
								<col width="247px">
								<col width="1px">
	<%-- 							<col width="117.47px"> --%>
						</colgroup>
					      <tr>
					           <td style="font-weight:bold; color:#333; background-color:rgb(220,225,230);">합계 </td>
					           <td><div id="inamtarea"></div></td>					           
					           <td><div id="outamtarea"></div></td>	
					           <td style="background-color:rgb(220,225,230);"></td>				
					      </tr>
					</table>
					<div class="btn_areaC mt20">
						 <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
    

</form>
</body>
</html>