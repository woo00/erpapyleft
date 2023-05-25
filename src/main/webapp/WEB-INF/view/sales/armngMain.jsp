<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 미수금 관리 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlockSize = 5;		// 블럭으로 잡히는 페이징처리 수
	
	$(function() {
		
		fn_init();
		
		fn_armlist();
		
		fRegisterButtonClickEvent();
	});
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_armlist();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'btnUpdate' :
					fn_update();
					break;
					
			}
		});
	}
	
	
	function fn_init() {
		selectComCombo("cli","cildall","all","","");  // 거래처 대분류
		
				
	}
	
	
	function fn_armlist(cpage) {
					      
	     cpage = cpage || 1;
		
	     var param ={	 
	    		 from_date : $("#from_date").val()
				  ,to_date : $("#to_date").val()
				  ,detail_name : $("#detail_name").val()
				  ,D_U : $("#D_U").val()
				  ,biz_ac : $("#cildall").val()
				  ,cpage : cpage
				  ,pageSize : pageSize
				};
						   
		   var armlistcallback = function(returndata) {
			   
			   console.log(returndata);  
			   
			   $("#armngMainList").empty().append(returndata);	
			   
			   var counthnoticelist = $("#counthnoticelist").val();
						
				// 페이지 네비게이션 생성		
				var paginationHtml = getPaginationHtml(cpage, counthnoticelist, pageSize, pageBlockSize, 'fn_armlist');
				
				$("#pagingnavi").empty().append( paginationHtml );
				
				// 현재 페이지 설정
				$("#currentPage").val(cpage);
			   
		   }
		   
		   callAjax("/sales/listARM.do", "post", "text", true, param, armlistcallback);
			   
			         
    }
	
	function fn_update(){
		
		var param = {
			  est_yn : $("#est_yn").val()
			  ,est_code : $("#estcode").val()
		
		  }
		var updatecallback = function(returndata) {
			
			   console.log( JSON.stringify(returndata));
			   
			   if(returndata.result = "SUCCESS") {
				   alert("입금 처리 되었습니다.");
				   gfCloseModal();
				   fn_armlist($("#currentpage").val());
				  
					}
			   
	   }
		
		callAjax("/sales/updateArm.do", "post", "json", false, param, updatecallback);
   }
	
	
	
   
   function initpopup(object) {
	   
	   if( object.est_yn == 'Y'){   
		   $("#estcode").val(object.est_code);
		   $("#biz_code").val(object.biz_code);
		   $("#est_edate").val(object.est_edate);
		   $("#est_odate").val(object.est_odate);
		   $("#est_yn").val(object.est_yn);
		   $("#biz_name").val(object.biz_name);
		   $("#biz_iname").val(object.biz_iname);
		   $("#biz_phone").val(object.biz_phone);
		   $("#biz_bank").val(object.biz_bank);
		   $("#biz_ac").val(object.biz_ac);
		   $("#psd").val(object.psd);
		   $("#sign_user").val(object.sign_user);
		   $("#detail_name").val(object.detail_name);
		   $("#est_yn").prop("disabled", true);
		   
		   $("#btnUpdate").hide();
		   
	   } else {
		   $("#estcode").val(object.est_code);
		   $("#biz_code").val(object.biz_code);
		   $("#est_edate").val(object.est_edate);
		   $("#est_odate").val(object.est_odate);
		   $("#est_yn").val(object.est_yn);
		   $("#biz_name").val(object.biz_name);
		   $("#biz_iname").val(object.biz_iname);
		   $("#biz_phone").val(object.biz_phone);
		   $("#biz_bank").val(object.biz_bank);
		   $("#biz_ac").val(object.biz_ac);
		   $("#psd").val(object.psd);
		   $("#sign_user").val(object.sign_user);
		   $("#detail_name").val(object.detail_name);
		   $("#est_yn").prop("disabled", false);
		   
		   $("#btnUpdate").show();
		   
	   }
   }  
   
					   
	function fn_selectArm(est_code, est_yn) {
		
		var param = {
				est_code : est_code,
				est_yn  : est_yn		
		}
		
		$("#estyn").val(est_yn);
		var selectArmcallback = function(returndata){
			 
			console.log( "체크", JSON.stringify(returndata));
			   
			initpopup(returndata.selectarm);

	    	gfModalPop("#dtlManagement")
	 
   		}
		
		callAjax("/sales/selectArm.do", "post", "json", false, param, selectArmcallback);
	}
			

// 	   function fValidate() {
	    	
// 			var chk = checkNotEmpty(
// 					[
// 							[ "paccall", "계정대분류명을 선택해 주세요." ]
// 						,	[ "dacc_name", "계정세부명을 선택해 주세요" ]
// 						,	[ "dacc_detail", "상세내용을 입력해 주세요" ]
// 						,	[ "dacc_div", "구분을 선택해 주세요" ]
// 						,	[ "use_yn", "사용여부를 선택해 주세요" ]
// 					]
// 			);

// 			if (!chk) {
// 				return;
// 			}

// 			return true;
// 		}

	


</script>

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	
    <input type="hidden" id="currentpage"  id="currentpage" value="">
	<input type="hidden" name="action" id="action" value=""> 
	<input type="hidden" id="loginId"  name="loginId"  value="${loginId}">
	<input type="hidden" id="estcode"  name="estcode"  value="">

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav bold">매출</a> 
								<span class="btn_nav bold">미수금 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>미수금 관리 </span> 
						</p>
						
					<!--검색창  -->

			
					<style> 
							table#either {border-collapse: separate;border-spacing: 15px 15px;}
					</style>
					<div style="height: auto; width: 100%; border:1px solid black;">
					<table id="either">
                          <colgroup>
		                   <col width="8%">
		                   <col width="50%">
		                   <col width="20%">
		                   <col width="10%">
		                   <col width="20%">
		                   <col width="10%">
		                   <col width="10%">
	                 </colgroup>					
					  <tbody>
					    <tr>
							<td style="font-size: 100%">일자</td>
	                           <td style="font-size: 100%" >
	                            <input type="date" style="width: 100px" id="from_date" name="from_date"> ~ 
	                            <input type="date" style="width: 100px" id="to_date" name="to_date">
                            </td>
                           <td style="font-size: 100%">수금상태</td>
                           <td style="font-size: 100%">
                                 <select id="D_U" name="D_U">
                                     <option value="">전체</option>
                                     <option value="Y">입금완료</option>
                                     <option value="N">미입금</option>
                                  
                                 </select>
                           </td>
	 							<td style="font-size: 100%">거래처명</td>
	                           		<td style="font-size: 100%">
	                                <td><select id="cildall" name="cildall" v-model="cildall" style="width: 200px; height: 25px;" /></select>
	                           </td>
	                           <td><a href="" class="btnType blue" id="btnSearch" name="btn"><span>조회</span></a></td> 
                        	</tr>
                        </tbody>
                     </table>
                     </div>    
						
						
						<div class="divSalesList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="20%">
						                   <col width="14%">
						                   <col width="9%">
						                   <col width="17%">
						                   <col width="9%">
						                   <col width="13%">
					                 </colgroup>
								<thead>
									<tr>
										  <th scope="col">수주번호</th>
							              <th scope="col">거래처명</th>
							              <th scope="col">납입금액</th>
							              <th scope="col">수주일자</th>
										  <th scope="col">수금상태</th>
										  <th scope="col">처리자</th>							          
									</tr>
								</thead>
								<tbody id="armngMainList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업  1.-->
	<div id="dtlManagement" class="layerPop layerType2" style="width: 800px; height:550px;">
		<dl>
			<dt>
				<strong>상세정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
									<colgroup>
						                   <col width="16%">
						                   <col width="34%">
					                 </colgroup>
					<tbody>
						<tr>
							<th scope="row">수주일자</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="est_edate" id="est_edate" value="${armModel.est_edate}" readonly/>
							 </td>
							<th scope="row">납품일자 </th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="est_odate" id="est_odate" readonly/></td>
						</tr>
						<tr>
							<th scope="row">수금상태</th>
							<td colspan="2"><select id="est_yn" name="est_yn">
                                     <option value="Y" >입금완료</option>
                                     <option value="N">미입금</option>
                                 </select></td>
						</tr>
						<tr>
							<th scope="row" colspan='6'>거래처정보</th>
						</tr>
						<tr>	
							<th scope="row">거래처</th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="biz_name" id="biz_name" readonly/></td>
								<th scope="row">거래처 담당자</th>
							<td colspan="2">
							    <input type="text" class="inputTxt p100" name="biz_iname" id="biz_iname"  readonly/>
						</tr>
						<tr>
							<th scope="row">거래처담당자번호</th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="biz_phone" id="biz_phone"  readonly/></td>
						</tr>
						<tr>
						    <th scope="row" colspan='6'>입금정보</th>
						</tr>
						<tr>
							<th scope="row">입금은행</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="biz_bank" id="biz_bank"readonly/></td>
						    <th scope="row">계좌번호</th>
							<td colspan="1"><input type="text" class="inputTxt p100" name="biz_ac" id="biz_ac" readonly/></td>
						</tr>
						<tr>
						
							<th scope="row">처리자</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="sign_user" id="sign_user"readonly/></td>
						</tr>
						<tr>
							<th scope="row">미납액</th>
							<td colspan="1"><input type="text" class="inputTxt p50"
								name="psd" id="psd" readonly/></td>
						</tr>	
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>  
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
				<a href="" class="closePop"><span class="hidden">닫기</span></a>
			</dd>

		</dl>
		
	</div>
	
	

</form>
</body>
</html>
