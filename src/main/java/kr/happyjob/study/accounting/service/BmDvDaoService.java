package kr.happyjob.study.accounting.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accounting.model.BmDvModel;

public interface BmDvDaoService {

	List<BmDvModel> list(Map<String, Object> paramMap);

	int dvtotalcnt(Map<String, Object> paramMap);

	BmDvModel detail(Map<String, Object> paramMap);

	int dvSave(Map<String, Object> paramMap);

	
}
