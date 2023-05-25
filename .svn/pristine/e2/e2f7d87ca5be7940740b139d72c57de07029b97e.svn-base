package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpPayHistModel;
import kr.happyjob.study.employee.model.EmpPaymentModel;

public interface EmpPayDao {
	
	// 급여 지급 내역
	List<EmpPaymentModel> getPaymentList(Map<String, Object> paramMap);

	// 급여 지급 내역 개수
	int getPaymentListCount(Map<String, Object> paramMap);

	// 급여 단건 입력
	int addEmpPayment(Map<String, Object> paramMap);

	// 4대보험
	void addIntl(Map<String, Object> paramMap);

	// 급여 지급 내역 상세 조회
	List<EmpPaymentModel> empPaymentDetailList(Map<String, Object> paramMap);

	// 급여 지급 내역 상세 조회 개수
	int empPaymentDetailListCount(Map<String, Object> paramMap);

	// 급여내역서
	EmpPayHistModel empPayHistInfo(Map<String, Object> paramMap);
	
	// 일괄 지급
	int addAllEmpPayment(Map<String, Object> paramMap);

	// 일괄 지급 (세금)
	void addAllEmpTax(Map<String, Object> paramMap);
}
