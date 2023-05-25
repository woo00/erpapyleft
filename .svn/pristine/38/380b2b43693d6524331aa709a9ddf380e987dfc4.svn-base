package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.EstManagementDao;
import kr.happyjob.study.business.model.EstManagementModel;

@Service
public class EstManagementServiceImpl implements EstManagementService{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private EstManagementDao estManagementDao;
	
	public List<EstManagementModel> listpage(Map<String, Object> paramMap) {
		return estManagementDao.listpage(paramMap);
	}

	public int countlistpage(Map<String, Object> paramMap) {
		return estManagementDao.countlistpage(paramMap);
	}

	@Override
	public int estnewsave(Map<String, Object> paramMap) throws Exception {
		
		logger.info("est_code1 : " + paramMap.get("est_code"));
		
		// est table insert
		estManagementDao.estnewsave(paramMap);
		
		logger.info("est_code2 : " + paramMap.get("est_code"));
		
		// salplan table update
		return estManagementDao.updateestcode(paramMap);
		
	}

	@Override
	public int estnewupdate(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.estnewupdate(paramMap);
	}

	@Override
	public int estnewdelete(Map<String, Object> paramMap) throws Exception {
		
		// 삭제
		estManagementDao.estnewdelete(paramMap);
		
		// 업데이트
		return estManagementDao.estcodenull(paramMap);
	}

	@Override
	public EstManagementModel estManagementSelect(Map<String, Object> paramMap) {
		return estManagementDao.estManagementSelect(paramMap);
	}

	



}
