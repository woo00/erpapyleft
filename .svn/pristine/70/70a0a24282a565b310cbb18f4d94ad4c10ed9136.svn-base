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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.accounting.dao.AccTitleDao;
import kr.happyjob.study.accounting.model.AccTitleModel;


@Service
public class AccTitleServiceImpl implements AccTitleService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AccTitleDao AccTitleDao;
	 
	/** 계정과목 목록 조회 **/
	public List<AccTitleModel> listAccTitle(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.listAccTitle(paramMap);
	}
	
	/** 계정과목 카운트 조회 **/
	public int counthnoticelist(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.counthnoticelist(paramMap);
	}	
	
    /** 계정과목 단건조회**/
    public AccTitleModel selectAccTitle(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.selectAccTitle(paramMap);
	}
	
    /** 계정과목 수정 **/
    public int updateAccTitle(Map<String, Object> paramMap) throws Exception {
		
    	return AccTitleDao.updateAccTitle(paramMap);
	}
    

	/** 곻지사항 신규저장  **/
	public int saveAccTitle(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.saveAccTitle(paramMap);
	}
    
	
	/** 계정과목 삭제 */
	public int deleteAccTitle(Map<String, Object> paramMap) throws Exception{
    
    	return AccTitleDao.deleteAccTitle(paramMap);
    }
}
