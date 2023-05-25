package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.sales.model.ARMModel;

public interface ARMService {

	public List<ARMModel> listARM(Map<String, Object> paramMap) throws Exception;

	public int counthnoticelist(Map<String, Object> paramMap) throws Exception;
	
	public ARMModel selectArm(Map<String, Object> paramMap) throws Exception;

	public int updateArm(Map<String, Object> paramMap) throws Exception;
}