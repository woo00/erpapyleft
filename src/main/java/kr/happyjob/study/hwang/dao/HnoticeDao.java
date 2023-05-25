package kr.happyjob.study.hwang.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.hwang.model.HnoticeModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface HnoticeDao {

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
}
