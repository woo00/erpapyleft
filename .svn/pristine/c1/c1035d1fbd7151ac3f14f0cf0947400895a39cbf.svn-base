package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.ARMDao;
import kr.happyjob.study.sales.model.ARMModel;



@Service
public class ARMServiceImpl implements ARMService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	ARMDao ArmDao;
	
	
	public List<ARMModel> listARM(Map<String, Object> paramMap) throws Exception {
		
		return ArmDao.listARM(paramMap);
	}
	
	public int counthnoticelist(Map<String, Object> paramMap) throws Exception {
		
		return ArmDao.counthnoticelist(paramMap);
		
	}	
	
    public ARMModel selectArm(Map<String, Object> paramMap) throws Exception {
		
    	return ArmDao.selectArm(paramMap);
		
	}
	
	
    public int updateArm(Map<String, Object> paramMap) throws Exception {
		
    	return ArmDao.updateArm(paramMap);
	}

	@Override
	public int insertFnl(Map<String, Object> paramMap) throws Exception {

		return ArmDao.insertFnl(paramMap);
	}
    
        
}
