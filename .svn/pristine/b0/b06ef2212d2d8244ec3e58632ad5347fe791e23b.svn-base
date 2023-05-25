package kr.happyjob.study.accounting.service;
 
import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.accounting.dao.DvDao;
import kr.happyjob.study.accounting.model.DvModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class DvServiceImpl implements DvService{
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.logicalrootPath}")
	private String logicalRootPath;
	
	@Value("${fileUpload.dvPath}")
	private String dvPath;
	
	
	@Autowired
	DvDao dvDao;
	
//	메인페이지에 이름 가져오기
	
	
	
	/** 지출결의 목록 조회(신청페이지) **/
	
	public List<DvModel> dvList(Map<String, Object> paramMap) throws Exception{
		
		List<DvModel> dvList = dvDao.dvList(paramMap);
		
		return dvList;
	}
	
	public int dvListcnt(Map<String, Object> paramMap) throws Exception {
		
		return dvDao.dvListcnt(paramMap);
	}
	
	//상세
	public DvModel dvDetail(Map<String, Object> paramMap) throws Exception{
		return dvDao.dvDetail(paramMap);
	}
	
//	등록
	public int dvSave(Map<String, Object> paramMap) throws Exception{
	
		return dvDao.dvSave(paramMap);
	}
	
//	수정
	public int dvUpdate(Map<String, Object> paramMap) throws Exception{
		
		return dvDao.dvUpdate(paramMap);
		
	}
	
//	삭제	
	public int dvDelete(Map<String, Object> paramMap) throws Exception{
		return dvDao.dvDelete(paramMap);
	}
	
//	파일등록
	public int dvFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception{
		// request를 MultipartHttpServletRequest 타입으로 형 변환
				MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
				
				String itemFilePath = dvPath + File.separator;	// 실제 저장되는 물리경로 
				FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
				Map<String, Object> fileInfo = fileUtil.uploadFiles();	// uploadFiles() : 실제 업로드 처리해주는 메소드
				
				fileInfo.put("file_nadd", logicalRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
				paramMap.put("fileInfo", fileInfo);
				
				paramMap.put("file_madd", fileInfo.get("file_loc"));
				paramMap.put("file_name", fileInfo.get("file_nm"));
				paramMap.put("file_size", fileInfo.get("file_size"));
				
				if(fileInfo.get("file_size") != null || fileInfo.get("file_size")!="") {
					paramMap.put("file_nadd",  logicalRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
				}	else {
					paramMap.put("file_nadd", null);
				}

				paramMap.put("fileyn", "Y");


				return dvDao.dvFile(paramMap);
	}
//	파일수정
	public int dvFileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception{
		// request를 MultipartHttpServletRequest 타입으로 형 변환
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		paramMap.put("dv_no", paramMap.get("dv_no"));
		
		DvModel dvDetail = dvDao.dvDetail(paramMap);
				
		if (dvDetail.getFile_name() != null) {
			File remove = new File(dvDetail.getFile_madd());
			remove.delete();
		}
		
		String itemFilePath = dvPath + File.separator;	// 실제 저장되는 물리경로 
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();	// uploadFiles() : 실제 업로드 처리해주는 메소드
		
		fileInfo.put("file_nadd", logicalRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		paramMap.put("fileInfo", fileInfo);
		
		paramMap.put("file_madd", fileInfo.get("file_loc"));
		paramMap.put("file_name", fileInfo.get("file_nm"));
		paramMap.put("file_size", fileInfo.get("file_size"));
		
		if(fileInfo.get("file_size") != null || fileInfo.get("file_size")!="") {
			paramMap.put("file_nadd",  logicalRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		}	else {
			paramMap.put("file_nadd", null);
		}

		paramMap.put("fileyn", "Y");


		return dvDao.dvFileUpdate(paramMap);
	}

	@Override
	public int dvFileDelete(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		return dvDao.dvFileDelete(paramMap);
	}

	@Override
	public String getName(Map<String, Object> paramMap) {
		return dvDao.getName(paramMap);
	}
}
	
	
	

