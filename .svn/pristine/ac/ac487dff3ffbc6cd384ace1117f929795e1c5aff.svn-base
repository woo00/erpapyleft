package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.ImmRevenueDao;
import kr.happyjob.study.sales.model.SalesModel;

@Service
public class MRevServiceImpl implements MRevService {
	@Autowired
	ImmRevenueDao immRevenueDao;

	/** 월별 손익통계
	 * 사용자 직접 입력 조회(combo:user_input) */
	@Override
	public List<SalesModel> listMSalesUI(Map<String, Object> paramMap) throws Exception {
		
		List<SalesModel> listMSalesUI = immRevenueDao.listMSalesUI(paramMap);
		
		return listMSalesUI;
	}

	
	
}
