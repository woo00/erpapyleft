package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmployeeGradeModel;

public interface EmpGradeDao {

	/* 승진내역 리스트 조회 */
	public List<EmployeeGradeModel> empGradeList(Map<String, Object> paramMap);

	/* 승진내역 리스트 조회 -> 총 글 수 조회 */
	public int countEmpGradeList(Map<String, Object> paramMap);

	/* 승진내역 상세리스트 조회 */
	public List<EmployeeGradeModel> empDtlGradeList(Map<String, Object> paramMap);
	
	/* 승진내역 상세리스트 조회 -> 총 글 수 조회 */
	public int countEmpDtlGradeList(Map<String, Object> paramMap);


	

}
