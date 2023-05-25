package kr.happyjob.study.employee.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpPayDao;
import kr.happyjob.study.employee.model.EmpPaymentModel;

import javax.servlet.http.HttpSession;

@Service
public class EmpPaymentService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private EmpPayDao empPayDao;
	
	@Autowired
	private ConfigurableEnvironment env;

	public List<EmpPaymentModel> getPaymentList(Map<String, Object> paramMap) throws IOException {
		getPropertySources(paramMap);
		return empPayDao.getPaymentList(paramMap);
	}

	public int getPaymentListCount(Map<String, Object> paramMap) {
		return empPayDao.getPaymentListCount(paramMap);
	}

	// 단건 추가
	public int addEmpPayment(Map<String, Object> paramMap) throws IOException {
		
		int result = 0;

		getPropertySources(paramMap);

		// tb_pay 테이블에 급여 추가
		result = empPayDao.addEmpPayment(paramMap);
		
		// tb_fnl 4대보험 , 소득세, 실급여 추가 
		empPayDao.addIntl(paramMap); // 국민연금

		return result;
	}
	

	public List<EmpPaymentModel> empPaymentDetailList(Map<String, Object> paramMap) {
		return empPayDao.empPaymentDetailList(paramMap);
	}

	public int empPaymentDetailListCount(Map<String, Object> paramMap) {
		return empPayDao.empPaymentDetailListCount(paramMap);
	}

	public int addAllEmpPayment(Map<String, Object> paramMap) throws IOException {

		int result = 0;

		getPropertySources(paramMap);

		result = empPayDao.addAllEmpPayment(paramMap);

		// 세금
		empPayDao.addAllEmpTax(paramMap);
		return result;
	}
	private void getPropertySources(Map<String, Object> paramMap) throws IOException {

		MutablePropertySources propertySources = env.getPropertySources();
		propertySources.addLast(new ResourcePropertySource("classpath:happyjob.properties"));

		paramMap.put("ip", env.getProperty("emp.rate.natps"));
		paramMap.put("hi", env.getProperty("emp.rate.hinsure"));
		paramMap.put("ii", env.getProperty("emp.rate.ohsinsure"));
		paramMap.put("ei", env.getProperty("emp.rate.einsure"));
		paramMap.put("it", env.getProperty("emp.rate.incometax"));
	}
}
