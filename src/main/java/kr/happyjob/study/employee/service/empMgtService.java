package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.employee.model.empMgtModel;
import kr.happyjob.study.hwang.model.HnoticeModel;

public interface empMgtService {

	/** 사원 리스트 조회 */
	public List<empMgtModel> empList(Map<String, Object> paramMap) throws Exception;
	
	/** 전체 사원수 조회 */
	public int countListEmp(Map<String, Object> paramMap) throws Exception;
	
	/** 사번 max 값 추출 */
	public int maxNum(Map<String, Object> paramMap) throws Exception;
	
	/** 파일 신규 등록 */
	public int fileRegist(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 사원 신규 등록 */
	public int empRegist(Map<String, Object> paramMap) throws Exception;
	
	/** 수정 된 연봉, 연봉 내역에 신규 등록 */
	public int salUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 연봉 전 데이터 날짜 업데이트 */
	public int salDateUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 승진 내역 등록 */
	public int prmRegist(Map<String, Object> paramMap) throws Exception;
	
	/** 연봉 내역 등록 */
	public int salRegist(Map<String, Object> paramMap) throws Exception;
	
	/** 승진 내역 등록 */
	public int prmUpdate(Map<String, Object> paramMap) throws Exception;

	/** 사원 단건 조회 */
	public empMgtModel empSelect(Map<String, Object> paramMap) throws Exception;
	
	/** 사원 수정 */
	public int empUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 파일 수정 */
	public int fileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 퇴직처리 */
	public int leaveUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 이력서 오등록을 위한 삭제 기능 */
	public int empDelete (Map<String, Object> paramMap) throws Exception;
	
	/** 삭제 된 이력서 등록 파일 삭제 */
	public int fileDelete(Map<String, Object> paramMap) throws Exception;
	
	/** 이력서 삭제 시 승진내역 삭제 */
	public int prmDelete(Map<String, Object> paramMap) throws Exception;
	
	
	
	
	
}
