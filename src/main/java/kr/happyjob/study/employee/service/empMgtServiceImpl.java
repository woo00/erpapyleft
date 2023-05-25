package kr.happyjob.study.employee.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.employee.dao.empMgtDao;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.employee.model.empMgtModel;

@Service
public class empMgtServiceImpl implements empMgtService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 물리경로
	@Value("${fileUpload.rootPath}")
	private String rootPath;
		
	@Value("${fileUpload.empPath}")
	private String empPath;

	// 논리경로
	@Value("${fileUpload.logicalrootPath}")
	private String logicalrootPath;
	
	@Autowired
	empMgtDao empMgtDao;

	/** 사원 리스트 조회 */
	public List<empMgtModel> empList(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.empList(paramMap);
	};
	
	/** 전체 사원수 조회 */
	public int countListEmp(Map<String, Object> paramMap) throws Exception{
		
		return empMgtDao.countListEmp(paramMap);
	}
	
	/** 사번 max 값 추출 */
	public int maxNum(Map<String, Object> paramMap) throws Exception{
		
		return empMgtDao.maxNum(paramMap);
	}
	
	/** 파일 신규 등록 */
	public int fileRegist(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		// request를 MultipartHttpServletRequest 타입으로 형 변환
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String itemFilePath = empPath + File.separator;	// 실제 저장되는 물리경로 
																											// File.separator : window 경로 구분 : \
																											//								 linux & unix 경로 구분 : /
																											//  OS 에 따라서 / & \ 구분해서 지정해주는 객체
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();	// uploadFiles() : 실제 업로드 처리해주는 메소드
		
		paramMap.put("file_madd", fileInfo.get("file_loc"));
		paramMap.put("file_name", fileInfo.get("file_nm"));
		paramMap.put("file_size", fileInfo.get("file_size"));
		
		if(fileInfo.get("file_size") != null || fileInfo.get("file_size") != "" ) {
			paramMap.put("file_nadd",  logicalrootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		}	else {
			paramMap.put("file_nadd", null);
		}

		paramMap.put("fileyn", "Y");


		return empMgtDao.fileRegist(paramMap);
	}

	/** 사원 신규 등록 */
	public int empRegist(Map<String, Object> paramMap) throws Exception {
		 	
		return empMgtDao.empRegist(paramMap);
	}
	
	/** 승진 내역 등록 */
	public int prmRegist(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.prmRegist(paramMap);
	}
	
	/** 연봉 내역 등록 */
	public int salRegist(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.salRegist(paramMap);
	}

	/** 사원 단건 조회 */
	public empMgtModel empSelect(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.empSelect(paramMap);
	}
	
	/** 수정 된 연봉, 연봉 내역에 신규 등록 */
	public int salUpdate(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.salUpdate(paramMap);
	}
	
	/** 연봉 전 데이터 날짜 업데이트 */
	public int salDateUpdate(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.salDateUpdate(paramMap);
	}
	
	/** 승진 내역 등록 */
	public int prmUpdate(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.prmUpdate(paramMap);
	}
	
	/** 사원 수정 */
	public int empUpdate(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.empUpdate(paramMap);
		
	}
	
	/** 파일 수정 */
	public int fileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		// request를 MultipartHttpServletRequest 타입으로 형 변환
				MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
				
				empMgtModel empSelect = empMgtDao.empSelect(paramMap);
				
				if(empSelect.getFile_name() != null) {
					File exitfile = new File(empSelect.getAbs_path());
					exitfile.delete();		// 파일의 물리경로를 찾아서 해당하는 파일을 삭제해줌
			} 
				String itemFilePath = empPath + File.separator;	// 실제 저장되는 물리경로 
																													// File.separator : window 경로 구분 : \
																													//								 linux & unix 경로 구분 : /
																													//  OS 에 따라서 / & \ 구분해서 지정해주는 객체
				FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
				Map<String, Object> fileInfo = fileUtil.uploadFiles();	// uploadFiles() : 실제 업로드 처리해주는 메소드
				
				paramMap.put("file_madd", fileInfo.get("file_loc"));
				paramMap.put("file_name", fileInfo.get("file_nm"));
				paramMap.put("file_size", fileInfo.get("file_size"));
				
				if(fileInfo.get("file_size") != null || fileInfo.get("file_size") != "" ) {
					paramMap.put("file_nadd",  logicalrootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
				}	else {
					paramMap.put("file_nadd", null);
				}

				paramMap.put("fileyn", "Y");

				
		return empMgtDao.fileUpdate(paramMap);
	}
	
	/** 퇴직처리 */
	public int leaveUpdate(Map<String, Object> paramMap) throws Exception{
		
		return empMgtDao.leaveUpdate(paramMap);
	};
	
	/** 이력서 오등록을 위한 삭제 기능 */
	public int empDelete (Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.empDelete(paramMap);
	}
	
	/** 삭제 된 이력서 등록 파일 삭제 */
	public int fileDelete(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.fileDelete(paramMap);
	}
	
	/** 이력서 삭제 시 승진내역 삭제 */
	public int prmDelete(Map<String, Object> paramMap) throws Exception {
		
		return empMgtDao.prmDelete(paramMap);
	}
	
	
	
	
}
