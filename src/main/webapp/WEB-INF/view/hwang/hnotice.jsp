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

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	/** OnLoad event */ 
	$(function() {
	
		fRegisterButtonClickEvent();
	
		searchnotice();
		
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			btnSavefile
			switch (btnId) {
			    case 'btnSave' :
				fn_save();
				break;
			    case 'btnDelete' :
			    	$("#action").val("D");
					fn_save();
					break;
			    case 'btnSavefile' :
					fn_savefile();
					break;	
			    case 'btnDeletefile' :
			    	$("#action").val("D");
			    	fn_savefile();
					break;	
				case 'btnClose' :
				case 'btnClosefile' :
					gfCloseModal();
					break;
			}
		});
		
		var upfile = document.getElementById('addfile');
		upfile.addEventListener('change',
						function(event) {
							$("#fileview").empty();
							var image = event.target;
							var imgpath = "";
							if (image.files[0]) {								
								imgpath = window.URL.createObjectURL(image.files[0]);
								
								console.log(imgpath);
								
								var filearr = $("#addfile").val().split(".");

								var previewhtml = "";

								if (filearr[1] == "jpg" || filearr[1] == "png") {
									previewhtml = "<img src='" + imgpath + "' style='width: 200px; height: 130px;' />";
								} else {
									previewhtml = "";
								}

								$("#fileview").empty().append(previewhtml);
							}
						});
	}
	
	
	function searchnotice(cpage) {
		
		cpage = cpage || 1;
		
		// 파라메터,  callback
		var param = {
				scrtitle : $("#srctitle").val(),
				srcsdate : $("#srcsdate").val(),
				srcedate : $("#srcedate").val(),
				pageSize : pageSize,
				cpage : cpage,
		}
		
		var listcallback = function(returndata) {
						
			console.log(returndata);
			
			$("#listNotice").empty().append(returndata);
			
			var counthnoticelist = $("#counthnoticelist").val();
			
			var paginationHtml = getPaginationHtml(cpage, counthnoticelist, pageSize, pageBlockSize, 'searchnotice');
			
			$("#noticePagination").empty().append(paginationHtml);
			
			$("#currentpage").val(cpage);
			
		}
		
		callAjax("/hwang/hnoticelist.do", "post", "text", "false", param, listcallback) ;
	}
	
    function getToday(){
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);

        return year + "-" + month + "-" + day;
    }
	
	
    ////파일 미첨부 시작	
	function fn_openpopup() {
		
		initpopup();
		
		gfModalPop("#noticereg");
		
	}
	
	function fn_save() {
		
		if(!fValidate()) {
			return;
		}
		
		var param = {
				notice_no  : $("#noticeno").val(),  
			    notice_title : $("#notice_title").val(),
			    notice_det : $("#notice_det").val(),
				action : $("#action").val(),
		}
		
		var savecallback = function(returndata) {
						
			console.log(  JSON.stringify(returndata) );
			
			if(returndata.result == "SUCCESS") {
				alert("저장 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					searchnotice($("#currentpage").val());
				} else {
					searchnotice();
				}
				
			}
		}
		
		callAjax("/hwang/hnoticesave.do", "post", "json", "false", param, savecallback) ;
		
	}
	
    function fValidate() {
    	
		var chk = checkNotEmpty(
				[
						[ "notice_title", "제목를 입력해 주세요." ]
					,	[ "notice_det", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	function initpopup(object) {	
		
		if( object == "" || object == null || object == undefined) {
			$("#writer").val($("#userNm").val());
			$("#notice_date").val(getToday());
			
			$("#notice_title").val("");
			$("#notice_det").val("");
			
			$("#btnDelete").hide();
			
			$("#action").val("I");
		} else {			
			// {"notice_no":17,"loginID":"admin","writer":"변경","notice_title":"test","notice_date":"2023-05-08","notice_det":"test","file_name":null,"file_size":0,"file_nadd":null,"file_madd":null}
		
		    $("#noticeno").val(object.notice_no);
			$("#writer").val(object.writer);
			$("#notice_date").val(object.notice_date);
			
			$("#notice_title").val(object.notice_title);
			$("#notice_det").val(object.notice_det);
			
			$("#btnDelete").show();
			
			$("#action").val("U");
		}
		
	}
	
	
    function fn_detailone(notice_no,popuptype) {
    	
    	var param = {
    			notice_no : notice_no
    	}
    	
    	var detailonecallback = function(returndata) {
    		console.log(  JSON.stringify(returndata)  );
    		
    		console.log( returndata.detailone.notice_no);
    		
    		if(popuptype == 1) {
    			initpopup(returndata.detailone);
        		
        		gfModalPop("#noticereg");
    		} else {
    			initpopupfile(returndata.detailone);
        		
        		gfModalPop("#noticeregfile");
    		}
    		
    	}
    	
    	callAjax("/hwang/detailone.do", "post", "json", "false", param, detailonecallback) ;
    }    
    //// 파일 미첨부 끝
     
    
    
    
    //// 파일 첨부 시작
    function fn_filechange(event) {
    	
    	var chtag = event.target;
    	
    	alert(chtag);
    	
    }
    
    
    function fn_openpopupfile() {
		
    	initpopupfile();
    	
		gfModalPop("#noticeregfile");
		
	}
    
    function initpopupfile(object) {	
		
		if( object == "" || object == null || object == undefined) {
			$("#writerfile").val($("#userNm").val());
			$("#notice_datefile").val(getToday());
			
			
			
			$("#notice_titlefile").val("");
			$("#notice_detfile").val("");
			$("#addfile").val("");
			$("#fileview").empty();
			
			$("#btnDeletefile").hide();
			
			$("#action").val("I");
		} else {			
			// {"notice_no":17,"loginID":"admin","writer":"변경","notice_title":"test","notice_date":"2023-05-08","notice_det":"test","file_name":null,"file_size":0,"file_nadd":null,"file_madd":null}
		
		    $("#noticeno").val(object.notice_no);
			$("#writerfile").val(object.writer);
			$("#notice_datefile").val(object.notice_date);
			
			$("#notice_titlefile").val(object.notice_title);
			$("#notice_detfile").val(object.notice_det);
			$("#addfile").val("");
			
			var file_name = object.file_name;
			var filearr = [];
			var previewhtml = "";

			
			if( file_name == "" || file_name == null || file_name == undefined) {
				previewhtml = "";
			} else {
				filearr = file_name.split(".");
				
				
				if (filearr[1] == "jpg" || filearr[1] == "png") {
					previewhtml = "<a href='javascript:fn_downaload()'>   <img src='" + object.file_nadd + "' style='width: 200px; height: 130px;' />  </a>";
				} else {
					previewhtml = "<a href='javascript:fn_downaload()'>" + object.file_name  + "</a>";
				}
			}
			

			$("#fileview").empty().append(previewhtml);
			
			$("#btnDeletefile").show();
			
			$("#action").val("U");
		}
		
	}
	
    function fn_downaload() {
    	alert($("#noticeno").val());
    	
    	var params = "<input type='hidden' name='notice_no' value='"+ $("#noticeno").val() +"' />";
	 	
	 	jQuery("<form action='/hwang/hnoticefiledownaload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		 
    	
    }
    
    function fn_savefile() {
		
      if(!fValidatefile()) {
    	  return;
      }
    	
 	   var frm = document.getElementById("myForm");
	   frm.enctype = 'multipart/form-data';
	   var dataWithFile = new FormData(frm);
		
		var savecallback = function(returndata) {
						
			console.log(  JSON.stringify(returndata) );
			
			if(returndata.result == "SUCCESS") {
				alert("저장 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					searchnotice($("#currentpage").val());
				} else {
					searchnotice();
				}
				
			}
		}
		
		callAjaxFileUploadSetFormData("/hwang/hnoticesavefile.do", "post", "json", true, dataWithFile, savecallback);
		
	}
    
    function fValidatefile() {
    	
		var chk = checkNotEmpty(
				[
						[ "notice_titlefile", "제목를 입력해 주세요." ]
					,	[ "notice_detfile", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
    
    
    ////파일 첨부 끝
    

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
								class="btn_nav bold">실습</span> <span class="btn_nav bold">공지사항
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지사항</span> <span class="fr"> 
							   제목
                               <input type="text" id="srctitle" name="srctitle"	 />
                               <input type="date" id="srcsdate" name="srcsdate"	 /> ~
                               <input type="date" id="srcedate" name="srcedate"	 />						   
							   <a	class="btnType blue" href="javascript:searchnotice();" name="modal" ><span>검색</span></a>
							   <a	class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							   <a	class="btnType blue" href="javascript:fn_openpopupfile();" name="modal"><span>신규등록 파일</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="17%">
									<col width="57%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">작성자</th>
										<th scope="col">제목</th>
										<th scope="col">작성일자</th>
									</tr>
								</thead>
								<tbody id="listNotice"></tbody>
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
	
	<div id="noticereg" class="layerPop layerType2" style="width: 600px;">
	     <dl>
			<dt>
				<strong>공지사항 등록/수정</strong>
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
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="writer" id="writer"  readonly /></td>
							<th scope="row">작성일자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="notice_date" id="notice_date" readonly /></td>
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100"	name="notice_title" id="notice_title" />
							</td>
						</tr>

						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea class="inputTxt p100"	name="notice_det" id="notice_det" > </textarea>
							</td>
						</tr>
							
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	
	
	</div>
	
     <div id="noticeregfile" class="layerPop layerType2" style="width: 600px;">
	     <dl>
			<dt>
				<strong>공지사항 등록/수정</strong>
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
							<th scope="row">작성자 </th>
							<td><input type="text" class="inputTxt p100" name="writerfile" id="writerfile"  readonly /></td>
							<th scope="row">작성일자 </th>
							<td><input type="text" class="inputTxt p100" name="notice_datefile" id="notice_datefile" readonly /></td>
						</tr>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100"	name="notice_titlefile" id="notice_titlefile" />
							</td>
						</tr>

						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea class="inputTxt p100"	name="notice_detfile" id="notice_detfile" > </textarea>
							</td>
						</tr>
							
						<tr>
							<th scope="row">파일 </th>
							<td>
							     <!-- input type="file" class="inputTxt p100" name="addfile" id="addfile"  onChange="fn_filechange(event)"  / -->
							     <input type="file" class="inputTxt p100" name="addfile" id="addfile" />
							</td>
							<td colspan="2"><div id="fileview"></div></td>
						</tr>
							
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	
	
	</div>	

</form>
</body>
</html>