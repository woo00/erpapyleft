package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.model.BmSalePlanModel;

import kr.happyjob.study.business.service.BmSalePlanService;
import kr.happyjob.study.business.dao.BmSalePlanDao;


@Service
public class BmSalePlanServiceImpl implements BmSalePlanService{

	@Autowired
	BmSalePlanDao bmSalePlanDao;
	
	
	@Override
	/** 영업실적조회 리스트 조회 **/
	
	public List<BmSalePlanModel> bmPlanList(Map<String, Object> paramMap) throws Exception{
		
		List<BmSalePlanModel> listPlan = bmSalePlanDao.bmPlanList(paramMap);
		
		return listPlan;
		
	}
	
	
	@Override
	/** 영업실적 목록 카운트 조회(신청페이지) **/
	
	public int countPlanList(Map<String, Object> paramMap) throws Exception{
		
		   int totalCount = bmSalePlanDao.countPlanList(paramMap);
			
		   return totalCount;
		}		
	
}
