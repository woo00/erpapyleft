package kr.happyjob.study.accounting.service;

 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.accounting.model.DvModel;


public interface DvService{

	/** 지출결의 목록 조회(신청페이지) */
	public List<DvModel> dvList(Map<String, Object> paramMap) throws Exception;
	
	public int dvListcnt(Map<String, Object> paramMap) throws Exception;
	
	//상세
	public DvModel dvDetail(Map<String, Object> paramMap) throws Exception;
	
//	저장
	public int dvSave(Map<String, Object> paramMap) throws Exception;
	
//	수정
	public int dvUpdate(Map<String, Object> paramMap) throws Exception;
	
//	삭제	
	public int dvDelete(Map<String, Object> paramMap) throws Exception;
	
//	파일등록
	public int dvFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;	

//	파일수정
	public int dvFileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

//	파일삭제
	public int dvFileDelete(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

//	메인페이지에 유저이름 가져오기
	public String getName(Map<String, Object> paramMap);
}











