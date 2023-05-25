package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.taapproveModel;

public interface taapproveDao 
{
	// 년차 구하기
	public int getLeave_date(Map<String, Object> paramMap) throws Exception;

	// 사용 연차 구하기
	public Integer getUse_leave(Map<String, Object> paramMap) throws Exception;

	// 휴가 리스트
	public List<taapproveModel> valist(Map<String, Object> paramMap) throws Exception;

	// 휴가 총 개수
	public Integer vacnt(Map<String, Object> paramMap) throws Exception;

	// 유저 기본 정보
	public taapproveModel getUser_detail(Map<String, Object> paramMap) throws Exception;

	// 휴가 신청 단건 조회
	public taapproveModel vadetail(Map<String, Object> paramMap);
}
