package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.taapproveDao;
import kr.happyjob.study.employee.model.taapproveModel;

@Service
public class taapproveService {

	@Autowired
	taapproveDao dao;
	
	// 총 연차 구하기
	public int getLeave_date(Map<String, Object> paramMap) throws Exception {
		int month = dao.getLeave_date(paramMap);
		int leave_date[] = {0,15,15,16,16,17,17,18,18,19,19,20,20,21,21,22,22,23,23,24,24};
		int result = 0;
		
		if(month >= 21)
		{
			result = 25;
		}
		else
		{
			result = leave_date[month];
		}
		
		return result;
	}

	// 사용 연차 구하기
	public Integer getUse_leave(Map<String, Object> paramMap) throws Exception{
		return dao.getUse_leave(paramMap);
	}

	// 휴가 리스트
	public List<taapproveModel> valist(Map<String, Object> paramMap) throws Exception {
		return dao.valist(paramMap);
	}

	// 휴가 총 개수
	public Integer vacnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return dao.vacnt(paramMap);
	}

	// 유저 기본정보
	public taapproveModel getUser_detail(Map<String, Object> paramMap) throws Exception{
		return dao.getUser_detail(paramMap);
	}

	// 휴가 신청 단건 조회
	public taapproveModel vadetail(Map<String, Object> paramMap) {
		return dao.vadetail(paramMap);
	}

	// 휴가 신청
	public int vainsert(Map<String, Object> paramMap) {
		return dao.vainsert(paramMap);
	}

	// 휴가 결과 조회
	public taapproveModel resultdetail(Map<String, Object> paramMap) {
		return dao.resultdetail(paramMap);
	}

	// 신청 수정
	public int vaupdate(Map<String, Object> paramMap) {
		return dao.vaupdate(paramMap);
	}

	// 신청 취소
	public int vadelete(Map<String, Object> paramMap) {
		return dao.vadelete(paramMap);
	}
}
