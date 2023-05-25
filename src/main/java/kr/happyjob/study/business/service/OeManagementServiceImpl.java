package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.OeManagementDao;
import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.employee.dao.EmpTaDao;

@Service
public class OeManagementServiceImpl implements OeManagementService {
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
		
		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		OeManagementDao oeManagementDao;

		@Override
		public List<OeManagementModel> oemlist(Map<String, Object> paramMap) {
			// TODO Auto-generated method stub
			return oeManagementDao.oemlist(paramMap);
		}

		@Override
		public int oemlistcnt(Map<String, Object> paramMap) {
			// TODO Auto-generated method stub
			return oeManagementDao.oemlistcnt(paramMap);
		}

		@Override
		public List<OeManagementModel> select(Map<String, Object> paramMap) {
			// TODO Auto-generated method stub
			return oeManagementDao.select(paramMap);
		}

		@Override
		public OeManagementModel detail(Map<String, Object> paramMap) {
			return oeManagementDao.detail(paramMap);
		}

		@Override
		public OeManagementModel detail2(Map<String, Object> paramMap) {
			return oeManagementDao.detail2(paramMap);
		}

		@Override
		public int insert(Map<String, Object> paramMap) {
			// TODO Auto-generated method stub
			logger.info("+ Start " + className + ".oeManagementSave");
			logger.info("   - paramMap : " + paramMap);
			int insert = oeManagementDao.insert(paramMap);
			logger.info("+ End " + className + ".oeManagementSave");
			return insert;
		}

		@Override
		public int update(Map<String, Object> paramMap) {
			// TODO Auto-generated method stub
						logger.info("+ Start " + className + ".oeManagementSave");
						logger.info("   - paramMap : " + paramMap);
						int update = oeManagementDao.update(paramMap);
						logger.info("+ End " + className + ".oeManagementSave");
						return update;
		}

		@Override
		public int Ninsert(Map<String, Object> paramMap) {
			logger.info("+ Start " + className + ".oeManagementSave");
			logger.info("   - paramMap : " + paramMap);
			
			//재고수량 업데이트
			oeManagementDao.mprupdate(paramMap);
			//회계전표 인서트
			oeManagementDao.fnlupdate(paramMap);
			//영업실적 업데이트
			oeManagementDao.salupdate(paramMap);
			
			
			logger.info("+ End " + className + ".oeManagementSave");
			
			return 1 ;
			
		}
}
	