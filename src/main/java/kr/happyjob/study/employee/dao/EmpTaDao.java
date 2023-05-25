package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpTaModel;

public interface EmpTaDao {

	List<EmpTaModel> emptalist(Map<String, Object> paramMap);
	int emptalistcnt(Map<String, Object> paramMap);
	EmpTaModel detail(Map<String, Object> paramMap);
	int detailsave(Map<String, Object> paramMap);							
}
  