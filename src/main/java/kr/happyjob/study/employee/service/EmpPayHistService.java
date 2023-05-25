package kr.happyjob.study.employee.service;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpPayDao;
import kr.happyjob.study.employee.model.EmpPayHistModel;

@Service
public class EmpPayHistService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private EmpPayDao dao;
	
	@Autowired
	private ConfigurableEnvironment env;

	public EmpPayHistModel empPayHistInfo(Map<String, Object> paramMap) {
		return dao.empPayHistInfo(paramMap);
	}
}
