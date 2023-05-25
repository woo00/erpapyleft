package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.employee.model.EmployeeGradeModel;

public interface EmpGradeService {

	/* 인사관리 사원등록 -> 로그인 아이디 가져오기 */
	public String gainLoginID();

	/* 승진내역관리 승진내역 리스트 조회 */
	public List<EmployeeGradeModel> empGradeList(Map<String, Object> paramMap);

	/* 승진내역관리 승진내역 리스트 총 글수  */
	public int countEmpGradeList(Map<String, Object> paramMap);

	/* 승진내역관리 승진내역 상세리스트*/
	public List<EmployeeGradeModel> empDtlGradeList(Map<String, Object> paramMap);
	
	/* 승진내역관리 승진내역 상세리스트 총 글수  */
	public int countEmpDtlGradeList(Map<String, Object> paramMap);

}
