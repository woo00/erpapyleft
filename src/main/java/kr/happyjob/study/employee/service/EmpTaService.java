package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpTaModel;

public interface EmpTaService {

	public List<EmpTaModel> emptalist(Map<String, Object> paramMap)  throws Exception;

	public int emptalistcnt(Map<String, Object> paramMap)  throws Exception;

	public EmpTaModel detail(Map<String, Object> paramMap) throws Exception;

	public int detailsave(Map<String, Object> paramMap) throws Exception;
	
	  
}
