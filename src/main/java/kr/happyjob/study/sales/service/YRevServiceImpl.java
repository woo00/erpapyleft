package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.IyyRevenueDao;
import kr.happyjob.study.sales.model.SalesModel;

@Service
public class YRevServiceImpl implements YRevService {
	
	@Autowired
	IyyRevenueDao iyyRevenueDao;
	
	/** 년도별 손익통계
	 * 사용자 직접 입력 조회(combo:user_input) */
	@Override
	public List<SalesModel> listYSalesUI(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listYSalesUI = iyyRevenueDao.listYSalesUI(paramMap);
		
		return listYSalesUI;
	}
	
	/** 년도별 손익통계
	 * 상/하반기 조회(combo:half) */
	@Override
	public List<SalesModel> listYSalesHalf(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listYSalesHalf = iyyRevenueDao.listYSalesHalf(paramMap);
		
		return listYSalesHalf;
	}

	/** 년도별 손익통계
	 * 1-4분기 조회(combo:quarter) */
	@Override
	public List<SalesModel> listYSalesQuart(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listYSalesQuart = iyyRevenueDao.listYSalesQuart(paramMap);
		
		return listYSalesQuart;
	}




}
