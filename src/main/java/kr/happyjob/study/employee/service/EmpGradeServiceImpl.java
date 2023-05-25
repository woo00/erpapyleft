package kr.happyjob.study.employee.service;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.employee.dao.EmpGradeDao;
import kr.happyjob.study.employee.model.EmployeeGradeModel;

@Service
public class EmpGradeServiceImpl implements EmpGradeService {
	@Autowired
	EmpGradeDao EmpGradeDao;
	
	/* 승진내역관리 승진내역 리스트 조회 */
	@Override
	public List<EmployeeGradeModel> empGradeList(Map<String, Object> paramMap) {
		return EmpGradeDao.empGradeList(paramMap);
	}
	
	/* 승진내역관리 승진내역 리스트 총 글수  */
	@Override
	public int countEmpGradeList(Map<String, Object> paramMap) {
		return EmpGradeDao.countEmpGradeList(paramMap);
	}
	
	/* 승진내역관리 승진내역 상세리스트*/
	@Override
	public List<EmployeeGradeModel> empDtlGradeList(Map<String, Object> paramMap) {
		return EmpGradeDao.empDtlGradeList(paramMap);
	}

	/* 승진내역관리 승진내역 상세리스트 총 글수  */
	@Override
	public int countEmpDtlGradeList(Map<String, Object> paramMap) {
		return EmpGradeDao.countEmpDtlGradeList(paramMap);
	}

	@Override
	public String gainLoginID() {
		// TODO Auto-generated method stub
		return null;
	}

}
