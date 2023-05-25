package kr.happyjob.study.hwang.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.hwang.model.HnoticeModel;;

public interface HnoticeService {

	/** 곻지사항 목록 조회 */
	public List<HnoticeModel> hnoticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 곻지사항 목록 카운트 조회 */
	public int counthnoticelist(Map<String, Object> paramMap) throws Exception;
	
	
	/** 곻지사항 저장 */
	public int hnoticenewsave(Map<String, Object> paramMap) throws Exception;
	
	
	/** 곻지사항 수정 */
	public int hnoticenewupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 곻지사항 삭제 */
	public int hnoticenewdelete(Map<String, Object> paramMap) throws Exception;
	
	/** 곻지사항 상세 조회 */
	public HnoticeModel detailone(Map<String, Object> paramMap) throws Exception;
	
	
	/** 곻지사항 저장 파일 */
	public int hnoticenewsavefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 곻지사항 수정 파일 */
	public int hnoticenewupdatefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 곻지사항 삭제 파일 */
	public int hnoticenewdeletefile(Map<String, Object> paramMap) throws Exception;
	
	
}
