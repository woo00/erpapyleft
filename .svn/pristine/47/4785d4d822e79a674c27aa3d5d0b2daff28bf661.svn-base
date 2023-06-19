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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 api   -->
<script src="${CTX_PATH}/js/prdcomcombo.js"></script>


<!-- 거래처 관리  -->

<style>
	#layer1,#layer2 {
  overflow-y: scroll;
}
#est_client_nm,#erp_copnm {
 background-color: #BBC1CD;
 font-weight:bolder;
 text-align: center;
}

</style>

<script type="text/javascript">

   // 페이징 설정 
	var listarea;
 

   // 함수 시작
	$(function(){

		 fn_init();
		 
		// 리스트 펼치기
		 fn_estlist();
		// 버튼 등록
		 eRegisterButtonClickEvent();
		
		// 셀렉트 박스
		 selectComCombo("cli", "client_search", "all", ""); //거래처명
		 
// 		 $("#to_date").change(function() {
// 				if ($("#to_date").val() < $("#from_date").val()) {
// 					swal("최소기간 보다 작을수 없습니다.")
// 					$("#to_date").val('');
// 				}
// 			});
	});
	  
	   
 	function eRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

				switch (btnIdEst) {
					case 'btnInsertEst' : // 신규등록 , 저장 btnUpdateEst
						SaveEst();
						break;
					case 'btnUpdateEst' : // 수정
						$("#action").val("U");
						SaveEst();
						break;
					case 'btnDeleteEst' : // 삭제 
						$("#action").val("D");
						SaveEst();
						break;
					case 'btnCloseEst' : // 모달 닫기 함수 [나는 하나로 썼음 ]
						gfCloseModal();
						break;
				}
			});
		}
   	
	function fn_init(){
		
		listarea = new Vue({
			el : "#wrap_area",
			date : {
				estlist : [],
				pageSize : 5,
				pageBlockSize : 5,
				from_date : '',
				to_date : '',
				biz_name : '',
				pb_name : '',
				ps_name : '',
				prd_name : '',
				sp_gcnt : '',
				est_code : '',
				prd_name : '',
				prd_code : '',
				pagingnavi : '',
			},
			methods : {
				estlist : function(){
					fn_estlist();
				}
			}
			
			
		});
		
	}
	 

	function fn_estlist(cpage) {
		console.log("listarea.pageSize : " + listarea.pageSize);
		cpage = cpage || 1;
	
		   var param= {
						cpage : cpage,
						pageSize : 5,
						from_data : listarea.from_data,
						to_data : listarea.to_data,
						client_search : listarea.client_search
				}
					
		   var listpagecallback = function(returndata) {
				console.log("asdflkasldkfjaslkjdflkasjdflksjdlf" + returndata);			
			   listarea.estlist = returndata.listEmployeeModel; 
						
				// 페이지 네비게이션 생성		
				var paginationHtml = getPaginationHtml(cpage, returndata.totalcnt, listarea.pageSize, listarea.pageBlockSize, 'fn_estlist');
				
				listarea.pagingnavi = paginationHtml;
				
		   }
		   
		   callAjax("/business/listpageVue.do", "post", "json", true, param, listpagecallback);
			   
  }
	
	
 </script>
 

</head>
<body>
	<form id="estForm1" action=""  method="">
	   <input type="hidden" id="EstCurrentPage" value="1">
	    <input type="hidden" name="action" id="action" value=""> 
  
		   
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
	                        class="btn_nav">영업</a> <span class="btn_nav bold"> 견적서 작성 및 조회
	                        </span> <a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
	                  </p>
	
	                  <p class="conTitle">
	                     <span>견적서 작성 및 조회</span> <span class="fr"> 
	                     </span>
	                  </p>

	                  
	                  

	          <!-- 검색조회 --> 
	     
                 <!--검색   -->
                 <br>      
			                    
		  <div style = "padding : 3% 10% 3% 13%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
				<!-- 거래처 콤보박스   -->
				<div style ="padding: 2% 2% 0 1% ; margin: auto" >	
					<b style ="padding: 0 1% 0 1%" >거래처</b>
					<select name="client_search" id ='client_search'></select>
		                    
	                  	달력 조회 
							<b style ="padding-left: 90px">날짜 </b>
							<input type="date" id="from_date" name="from_date" style= "padding : 0.5%;" > ~ 
							<input type="date" id="to_date" name="to_date" style="padding : 0.5%" >
					
							<a href="" class="btnType blue" id="btnSearchEst" style ="float : right; ">
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
	                           <col width="10%">
	                           <col width="15%">
                               <col width="15%">
	                           <col width="10%">
	                           <col width="10%">
	                           <col width="10%">
	                           <col width="10%">
	                        </colgroup>
	                        
	                        
	                       <thead>
	                           <tr>
	                             <th scope="col">등록일</th>
	                              <th scope="col">거래처이름</th>
	                               <th scope="col">대분류</th>
	                               <th scope="col">소분류</th>
	                               <th scope="col">제품이름</th>
	                              <th scope="col">목표수량</th>
	                              <th scope="col">견적서 작성여부</th>
	                           </tr>
	                        </thead>
	                       

	                        <!--BizParnerCallBack으로 넘어감.여기는 틀만 만드는곳  -->
	                         <tbody id="listEstManage" v-for="(list.index) in estlist"> 
	                        	<tr>
									 날짜 누르면 readonly 
								   <template v-if="list.reg_yn == 'Y'">
								   		<td @click = "estOne(list.sp_code,list.est_code)" >
							   				<strong>{{ ist.sp_date }}</strong>
								   		</td>
								   </template>
								   <template v-if="list.reg_yn == 'Y'">
								   		<td>
							   				{{ list.sp_date }}
								   		</td>
								   </template>
				                  <td> {{ list.biz_name }} </td>
				                  <td> {{ list.pb_name }} </td>
	                              <td> {{ list.ps_name }}</td>
	                              <td> {{ list.prd_name }}</td>
	                              <td> {{ list.sp_gcnt }}</td>
	                               <template v-if="list.reg_yn == 'Y'">
		                              <td>
		                              	 <a>{{ list.est_code }}</a>
									  </td>
	                              </template>
	                               <template v-if="list.reg_yn == 'Y'">
		                              <td href="insertModal(list.sp_code, list.est_code, list.biz_name, list.biz_code, list.ps_name, list.ps_code, list.pb_name, list.pb_code, list.prd_name, list.prd_code">
										 <strong >{{ list.loginID }} </strong>
									  </td>			                              
	                              </template>
								</tr>
							</tbody> 
                     	</table>
	                     	
	                  	<!-- 페이징에리어 -->
						<div class="paging_area"  id="EstPagination" ></div>
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
		            <div id="divtitle" style="color:white">견적서 등록</div>
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
							  <td hidden="">
							  	<input type="text" class="inputTxt p100" name="estimate_no" id="estimate_no" />
							  	<input type="text" class="inputTxt p100" name="sp_code" id="sp_code"/>
							  </td> 
		     
		                     <th scope="row">거래처 이름</th>
		                     <td hidden=""><input type="hidden" id="client_nm"></td>
		                     				
							<td><!-- 거래처 콤보박스   -->
								<input type="text"  id ='client_search1' readOnly></input>	
								<input type="hidden" name="client_search1" readOnly></input>	
							</td>
		                
			                  <tr>
			                     <th scope="row">대분류</th>
                   				<td>
									<input type="text" id="scm_big_class"  readOnly></input>
									<input type="hidden" name="scm_big_class"></input>
								</td>
	                             <th scope="row">소분류</th>
								<td>
									<input type="text" id="scm_middle_class" readOnly></input>
									<input type="hidden" name="scm_middle_class" readOnly></input>
								</td>
			                  </tr>
			          
			                  <tr>
	                             <th scope="row">제품</th>
									<td>
										<input type="text" id="divproducttall" readOnly></input>
										<input type="hidden" name="divproducttall" readOnly></input>
									</td>
									        <th scope="row">수량</th>
			                    			 <td colspan="3">
			                    			 			<input type='number' name="estimate_cnt" id="estimate_cnt"  />
                    			 			</td>
			                	  </tr>

			               </tbody>
			            </table>
			            <div class="btn_areaC mt30">
			               <a href="" class="btnType blue" id="btnInsertEst" name="btn"><span>등록</span></a> 	
			               <a href=""   class="btnType gray"  id="btnCloseEst" name="btn"><span>취소</span></a>
			            </div>
			         </dd>
			      </dl>
			      <a href="" class="closePop"><span class="hidden">닫기</span></a>
			   </div>
			   <!-- 모달1 끝 -->
			   
			   
			   
			   	 <!-- 모달팝업2 ==  readOnly -->
	   <div id="layer2" class="layerPop layerType2"  style="width: 800px;">
	      <dl>
	         <dt>
	            <div id="divtitle2" style="color:white"><b>견적서 상세 조회</b></div>
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
					   
					    
	                       <tr>
		                     <th scope="row" colspan="2"> <input type ="text"  id="est_client_nm"   readOnly > </th>
		                      <th scope="row" colspan="2"><input type ="text"  id="erp_copnm"   readOnly ></th>
		                  </tr>
		  
		                
		                  <tr>
		                  <!-- 목록조회 외에 UPDATE, INSERT , DELETE 등을 위해 필요함  hidden 값  // INT가 아닌것도 있음  -->
		                   <td hidden=""><input type="text" class="inputTxt p100" name="estimate_no2" id="estimate_no2" /></td>
                       	   
                       	   <th scope="row">사업자등록번호</th>
		                     <td  class="inputTxt p100">  	
				                  <input type="text"   name="cop_no1" id="cop_no1" style ="width :70%; height :70%" maxlength="4"  readOnly>
		     			 <th scope="row">사업자등록번호</th>
	                     	<td  class="inputTxt p100">
                  				 <input type="text"   name="erp_copnum1" id="erp_copnum1" style ="width :70%; height :70%" maxlength="4"  readOnly>
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
				                  <input type="text"   name="local_tel1" id="local_tel1" style ="width :70%; height :70%" maxlength="4"  readOnly/>
		     
		     			 <th scope="row">TEL</th>
	                     	<td  class="inputTxt p100">
                  				 <input type="text"   name="erp_tel1" id="erp_tel1" style ="width :70%; height :70%" maxlength="4"  readOnly/>
              				
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
			   			 <th scope="row">견적작성일</th>
	                     	<td  class="inputTxt p100">
	                 			<input type="text"   name="estimate_date" id="estimate_date" style ="width :70%; height :70%"    readOnly/>
	                  </tr>
	                  
	                  <tr>
			   			 <th scope="row" class="han_money" id="han_money" >  합 계 </th>
			  				<td><input type="text" id="txt_money" maxlength="12"  readOnly  />
			  				</td>
			  			</tr>
			  			
			  		<table class="col">
				
                        
			  			  	<tr>
			   			 		<th scope="col" class="prd_name" id="prd_name" style="background-color:#BBC2CD;">  제품명 </th>
			  						<td><input type="text" id="prname" maxlength="12"  readOnly  />
			  						</td>
			  				</tr>
			  				
			  			  	<tr>
			   			 		<th scope="col" class="price" id="price"  style="background-color:#BBC2CD;"> 공급가액 </th>
			  						<td><input type="text" id="txmoney" maxlength="12"  readOnly  />
			  						</td>
			  				</tr>
			  			
			  			  	<tr>
			   			 		<th scope="col" class="pay" id="pay"  style="background-color:#BBC2CD;">  세액</th>
			  						<td><input type="text" id="money" maxlength="12"  readOnly  />
			  						</td>
			  				</tr>
			  				
			  			
			  			  	<tr>
			   			 		<th scope="col" class="sup_price" id="sup_price" style="background-color:#BBC2CD;">  제품단가 </th>
			  						<td><input type="text" id="prdprice" maxlength="12"  readOnly  />
			  						</td>
			  				</tr>
			  			
			  			  	<tr>
			   			 		<th scope="col" class="est_cnt" id="est_cnt" style="background-color:#BBC2CD;">  수량 </th>
			  						<td><input type="number" id="cntree" name="cntree"/>
			  					</td>
			  				</tr>
			  		</table>

				<div class="btn_areaC mt30">
					<div id= "changeArea" style="padding-bottom: 30px;">
	               <a href=""   class="btnType blue"  id="btnUpdateEst" name="btn"><span>수정</span></a>
	               <a href=""   class="btnType red"  id="btnDeleteEst" name="btn"><span>삭제</span></a>
	               </div>
	               <a href=""   class="btnType gray"  id="btnCloseEst" name="btn"><span>취소</span></a>
	            </div>
	         </dd>
	      </dl>
	      <a href="" class="closePop"><span class="hidden">닫기</span></a>
	   </div>
	   </tbody>
	   </table>
	   </dd>
	   </dl>
	   </div>
	   


	   
	   <!-- 모달2 끝 -->
			
	</form>

   </body>
</html>