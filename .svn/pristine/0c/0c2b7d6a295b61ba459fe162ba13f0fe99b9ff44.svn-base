package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.IddRevenueDao;
import kr.happyjob.study.sales.model.SalesModel;

@Service
public class DRevServiceImpl implements DRevService {
	@Autowired
	IddRevenueDao iddRevenueDao;
	
	/** 일별매출목록 카운트 조회 */
	@Override
	public int countListddRevenue(Map<String, Object> paramMap) {
		int totalCount = iddRevenueDao.countListddRevenue(paramMap);
		
		return totalCount;
	}
	
	/** 검색날짜 매출 목록 조회 */
	@Override
	public List<SalesModel> listDSales(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listDSales = iddRevenueDao.listDSales(paramMap);
		
		return listDSales;
	}

	/** 검색날짜 손익통계 */
	@Override
	public List<SalesModel> listDaySalesSum(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listDaySalesSum = iddRevenueDao.listDaySalesSum(paramMap);
		
		return listDaySalesSum;
	}

	/** 검색날짜 기준 한달전 매출 시각화*/
	@Override
	public List<SalesModel> listDaySalesChart(Map<String, Object> paramMap) throws Exception {
		List<SalesModel> listDaySalesChart = iddRevenueDao.listDaySalesChart(paramMap);
		
		return listDaySalesChart;
	}

	


}
