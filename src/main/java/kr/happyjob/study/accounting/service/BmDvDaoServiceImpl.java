package kr.happyjob.study.accounting.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accounting.dao.BmDvDao;
import kr.happyjob.study.accounting.model.BmDvModel;

@Service
public class BmDvDaoServiceImpl implements BmDvDaoService {
	@Autowired
	BmDvDao Dao;

	@Override
	public List<BmDvModel> list(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return Dao.list(paramMap);
	}

	@Override
	public int dvtotalcnt(Map<String, Object> paramMap) {
		int result = Dao.dvtotalcnt(paramMap);
		return result;
	}

	@Override
	public BmDvModel detail(Map<String, Object> paramMap) {
		
		return Dao.detail(paramMap);
	}

	@Override
	public int dvSave(Map<String, Object> paramMap) {
		
		int result = (Dao.dvSave(paramMap)+Dao.fnlupdate(paramMap));
		
		return result;
	}
	
}

	 