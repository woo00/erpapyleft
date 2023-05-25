package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpTaDao;
import kr.happyjob.study.employee.model.EmpTaModel;
@Service
public class EmpTaServiceImpl implements EmpTaService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	EmpTaDao empTaDao;
 
	@Override
	public List<EmpTaModel> emptalist(Map<String, Object> paramMap) {
		return empTaDao.emptalist(paramMap);
	}
 
	@Override
	public int emptalistcnt(Map<String, Object> paramMap) {
		return empTaDao.emptalistcnt(paramMap);
	}

	@Override
	public EmpTaModel detail(Map<String, Object> paramMap) {
		return empTaDao.detail(paramMap);
	}

	@Override
	public int detailsave(Map<String, Object> paramMap) {
		return empTaDao.detailsave(paramMap);
	}
	
	
}
	