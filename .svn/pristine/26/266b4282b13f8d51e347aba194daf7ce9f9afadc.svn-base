package kr.happyjob.study.system.service;

import kr.happyjob.study.system.dao.PrdComcomboDao;
import kr.happyjob.study.system.model.PrdComcomboModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class PrdComcomboService {

	@Autowired
	private PrdComcomboDao dao;
	
	public PrdComcomboModel prdComcombo(Map<String, Object> paramMap) {
		return dao.prdComcombo(paramMap);
	}
}
