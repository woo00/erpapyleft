package kr.happyjob.study.accounting.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accounting.dao.AccSlipFDao;
import kr.happyjob.study.accounting.model.AccSlipFModel;;

@Service
public class AccSlipFServiceImpl implements AccSlipFService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	@Autowired
	AccSlipFDao accslipfDao;
	
	/** 공지사항 목록 조회 */
	public List<AccSlipFModel> accslipflist(Map<String, Object> paramMap) throws Exception {
		logger.info("+ AccSlipFServiceImpl " + paramMap + ".AccSlipFServiceImpl");
		return accslipfDao.accslipflist(paramMap);
		
	}

	/** 공지사항 목록 카운트 조회 */
	
	@Override
	public int countaccslipflist(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accslipfDao.countaccslipflist(paramMap);
	}

	@Override
	public List<AccSlipFModel> accslipfmodal(Map<String, Object> paramMap) throws Exception {
		logger.info("+ AccSlipFServiceImpl " + paramMap + ".AccSlipFServiceImpl");
		return accslipfDao.accslipfmodal(paramMap);
	}



	
	
	
	
    
    
	
}
