<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 미수금 관리 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>

<script type="text/javascript">

	// 페이징 설정 
	var listarea;
	
	var dtlManagement;
	var hiddenarea;
	
	$(function() {
		
		fn_init();
		
// 		listarea.armlist();
		
		fn_armlist();
		
		fRegisterButtonClickEvent();
		
		selectComCombo("cli","cildall","all","","");  // 거래처 대분류
	});
	
	function fn_armlist(cpage) {
	      console.log("check");
	     cpage = cpage || 1;
	     
	     // hidden태그에 cpage 값을 저장
		hiddenarea.currentpage = cpage;
		   var param= {
						cpage : cpage,
						pageSize : listarea.pageSize,
						from_date : listarea.from_date,
						to_date : listarea.to_date,
						D_U : listarea.D_U,
						biz_ac : listarea.cildall,
				}
					
		   var armlistcallback = function(returndata) {
					
			   listarea.armngList= returndata.listARM; 
						
				// 페이지 네비게이션 생성		
				var paginationHtml = getPaginationHtml(cpage, returndata.counthnoticelist, listarea.pageSize, listarea.pageBlockSize, 'fn_armlist');
				
				listarea.pagingnavi = paginationHtml;
				
		   }
		   
		   callAjax("/sales/listARMVue.do", "post", "json", true, param, armlistcallback);
			   
			         
  }
	
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_armlist();
					break;
				case 'btnClose' :
					gfCloseModal("dtlManagement");          
					break;
				case 'btnUpdate' :
					console.log("수정이안되ㅏ몬어리ㅏㅓㄴㅇ;라ㅣㅓ;ㄴ아ㅣ러")
					fn_update();
					break;
					
			}
		});
	}
	
	
	function fn_init() {
		
		listarea = new Vue({
			el : "#wrap_area",
			data : {
				pageSize : 10,
				pageBlockSize : 10,
				armngList  : [],
				from_date : '',
				to_date : '',
				detail_name : '', 
				D_U : '',
				biz_ac : '',
				cildall :'',
				biz_name : '',
				pagingnavi : '',
			},
			methods : {
				armlist : function(){
					fn_armlist();
				},
				regclick: function(event){
					gfModalPop("#dtlManagement")
				},
				fn_selectArm : function(est_code, D_U){
					fn_selectArm(est_code, D_U);
				}
			
				
			}	
		});
		
	
		
		dtlManagement = new Vue({
			el: "#dtlManagement",
			data: {
				armngList  : [],
				from_date : '',
				to_date : '',
				detail_name : '', 
				D_U : '',
				biz_ac : '',
				cildall :'',
				biz_name : '',
				biz_iname : '',
				biz_phone : '',
				biz_bank : '',
				pagingnavi : '',
				
				updatebtnflag : '',
				dis:'',
				
			},
			
			methods:{
				close : function(){
					gfCloseModal();
				}
			}
			
		
			
		});
		
		hiddenarea = new Vue({
			el : "#hiddenarea",
			data : {
				currentpage : '',
				action : '',
				estcode : '',
								
			}
		})
	}
		function fn_openpopup(){
			initpopup();
			
			gfModalPop("dtlManagement");
			
		}
		
		function fn_update(){
			var param = {
					
				est_yn : dtlManagement.est_yn,
				est_code : dtlManagement.est_code,
				action : dtlManagement.action,
			
			  }
			var updatecallback = function(returndata) {
				
// 				   console.log( JSON.stringify(returndata));
				   
				   if(returndata.result = "SUCCESS") {
					   alert("입금 처리 되었습니다.");
					   gfCloseModal();
					   //  fn_armlist(hiddn에 저장했떤 페이지);
					   fn_armlist(hiddenarea.currentpage);
					  
						}
				   
		   }
			
			callAjax("/sales/updateArm.do", "post", "json", false, param, updatecallback);
	   }
		
		
		
	   
	   function initpopup(object) {
		   
		   if( object.est_yn == 'Y'){   
			   
			   dtlManagement.est_code = object.est_code;
			   dtlManagement.biz_code = object.biz_code;
			   dtlManagement.est_edate = object.est_edate;
			   dtlManagement.est_odate = object.est_odate;
			   dtlManagement.est_yn = object.est_yn;
			   dtlManagement.biz_name = object.biz_name;
			   dtlManagement.biz_iname = object.biz_iname;
			   dtlManagement.biz_phone = object.biz_phone;
			   dtlManagement.biz_bank = object.biz_bank;
			   dtlManagement.biz_ac = object.biz_ac;
			   dtlManagement.psd = object.psd;
			   dtlManagement.sign_user = object.sign_user;
			   dtlManagement.detail_name = object.detail_name;
			   dtlManagement.est_yn = object.est_yn;
			   dtlManagement.biz_iname = object.biz_iname;
		   	   dtlManagement.est_yn = object.est_yn; 
		   	   dtlManagement.updatebtnflag = false; 
		   	   dtlManagement.dis = true; 
		   	   
			   dtlManagement.action = "U";
			   
		   }else{ 
			   
			   dtlManagement.est_code = object.est_code;
			   dtlManagement.biz_code = object.biz_code;
			   dtlManagement.est_edate = object.est_edate;
			   dtlManagement.est_odate = object.est_odate;
			   dtlManagement.est_yn = object.est_yn;
			   dtlManagement.biz_name = object.biz_name;
			   dtlManagement.biz_iname = object.biz_iname;
			   dtlManagement.biz_phone = object.biz_phone;
			   dtlManagement.biz_bank = object.biz_bank;
			   dtlManagement.biz_ac = object.biz_ac;
			   dtlManagement.psd = object.psd;
			   dtlManagement.sign_user = object.sign_user;
			   dtlManagement.detail_name = object.detail_name;
			   dtlManagement.est_yn = object.est_yn;
			   dtlManagement.biz_iname = object.biz_iname;
		   	   dtlManagement.est_yn = object.est_yn; 
		   	   dtlManagement.updatebtnflag = true; 
		   	   dtlManagement.dis = false;  
		   	   
		   }
	   }  
	   
		
		
		
 		function fn_selectArm(est_code, est_yn) {
			
 			var param = {
 					est_code : est_code,
 					est_yn  : est_yn		
 			}
			
 			var selectArmcallback = function(returndata){
				 
 				console.log( "체크", JSON.stringify(returndata));
				   
 				initpopup(returndata.selectarm);
	
 		    	gfModalPop("#dtlManagement")
		 
 	   		}
			
 			callAjax("/sales/selectArm.do", "post", "json", false, param, selectArmcallback);
 		}
	
	
	
	
</script>

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	<div id="hiddenarea">
	    <input type="hidden" id="currentpage"  id="currentpage" v-model="currentpage">
		<input type="hidden" name="action" id="action" value=""> 
		<input type="hidden" id="loginId"  name="loginId"  value="${loginId}">
		<input type="hidden" id="estcode"  name="estcode"  value="">
	</div>

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
	                            <input type="date" style="width: 100px" id="from_date" name="from_date" v-model="from_date"> ~ 
	                            <input type="date" style="width: 100px" id="to_date" name="to_date">
                            </td>
                           <td style="font-size: 100%">수금상태</td>
                           <td style="font-size: 100%">
                                 <select id="D_U" name="D_U" v-model = "D_U">
                                     <option value="">전체</option>
                                     <option value="Y">입금완료</option>
                                     <option value="N">미입금</option>
                                  
                                 </select>
                           </td>
	 							<td style="font-size: 100%">거래처명</td>
	                           		<td style="font-size: 100%">
	                                <td><select id="cildall" name="cildall" v-model = "cildall" style="width: 200px; height: 25px;" /></select>
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
											<%-- <td><a href="javascript:fn_selectArm('${list.est_code}','${list.est_yn}')">${list.est_code}-${list.est_odate}-O</a> </td> --%>
								<tbody id="armngMainList" v-for="(item,index) in armngList">
									<tr @click="fn_selectArm(item.est_code, item.est_yn)" >
										<td>{{ item.est_code }}-{{ item.est_odate }}-O</td>
										<td>{{ item.biz_name }}</td>
										<td>{{ item.psd }}</td>
										<td>{{ item.est_odate }}</td>
										<td>{{ item.detail_name }}</td>
										<td>{{ item.sign_user }}</td>
									</tr> 
								</tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi" v-html="pagingnavi">
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
							<td colspan="2"><input type="text" class="inputTxt p100" name="est_edate" id="est_edate" v-model = "est_edate" value="${armModel.est_edate}" readonly/>
							 </td>
							<th scope="row">납품일자 </th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="est_odate" id="est_odate" v-model = "est_odate" readonly/></td>
						</tr>
						<tr>
							<th scope="row">수금상태</th>
							<td colspan="2"><select id="est_yn" name="est_yn" v-model = "est_yn" :disabled="dis">
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
								name="biz_name" id="biz_name" v-model = "biz_name" readonly/></td>
								<th scope="row">거래처 담당자</th>
							<td colspan="2">
							    <input type="text" class="inputTxt p100" name="biz_iname" id="biz_iname" v-model = "biz_iname" readonly/>
						</tr>
						<tr>
							<th scope="row">거래처담당자번호</th>
							<td colspan="2"><input type="text" class="inputTxt p100"
								name="biz_phone" id="biz_phone" v-model = "biz_phone" readonly/></td>
						</tr>
						<tr>
						    <th scope="row" colspan='6'>입금정보</th>
						</tr>
						<tr>
							<th scope="row">입금은행</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="biz_bank" id="biz_bank" v-model = "biz_bank" readonly/></td>
						    <th scope="row">계좌번호</th>
							<td colspan="1"><input type="text" class="inputTxt p100" name="biz_ac" id="biz_ac" v-model = "biz_ac" readonly/></td>
						</tr>
						<tr>
						
							<th scope="row">처리자</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="sign_user" id="sign_user" v-model = "sign_user" readonly/></td>
						</tr>
						<tr>
							<th scope="row">미납액</th>
							<td colspan="1"><input type="text" class="inputTxt p50" v-model="psd"
								name="psd" id="psd" readonly/></td>
						</tr>	
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdate" name="btn" v-show="updatebtnflag"><span>수정</span></a>  
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
				<a href="" @click.prevent="close()" class="closePop"><span class="hidden">닫기</span></a>
			</dd>

		</dl>
		
	</div>
	
	

</form>
</body>
</html>
