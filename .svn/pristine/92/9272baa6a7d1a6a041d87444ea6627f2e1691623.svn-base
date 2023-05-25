package kr.happyjob.study.business.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.model.productModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.business.dao.productDao;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class productServiceImpl implements productService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 물리경로
	@Value("${fileUpload.rootPath}")
	private String rootPath;
		
	@Value("${fileUpload.productPath}")
	private String productPath;

	// 논리경로
	@Value("${fileUpload.logicalrootPath}")
	private String logicalrootPath;

	@Autowired
	productDao productdao;

	@Override
	/** 제품 리스트 조회 */
	public List<productModel> prdList(Map<String, Object> paramMap) throws Exception {
		
		return productdao.prdList(paramMap);
	}
	
	/** 제품수 카운트 */
	public int countListPrd(Map<String, Object> paramMap) throws Exception {
		
		return productdao.countListPrd(paramMap);
	}
	
	/** 제품 등록 시 회계전표 insert */
	public int fnlRegist(Map<String, Object> paramMap) throws Exception {
		
		return productdao.fnlRegist(paramMap);
	}
	
	@Override
	/** 대분류 리스트 조회 */
	public List<productModel> pbList(Map<String, Object> paramMap) throws Exception {
		
		return productdao.pbList(paramMap);
	}
	
	@Override
	/** 소분류 A 리스트 조회 */
	public List<productModel> psAList(Map<String, Object> paramMap) throws Exception {
		
		return productdao.psAList(paramMap);
	}
	
	@Override
	/** 소분류 B 리스트 조회 */
	public List<productModel> psBList(Map<String, Object> paramMap) throws Exception {
		
		return productdao.psBList(paramMap);
	}
	
	@Override
	/** 소분류 C 리스트 조회 */
	public List<productModel> psCList(Map<String, Object> paramMap) throws Exception {
		
		return productdao.psCList(paramMap);
	}
	
	@Override
	/** 신규 제품 등록 */
	public int prdRegist(Map<String, Object> paramMap , HttpServletRequest request) throws Exception {
		
		// request를 MultipartHttpServletRequest 타입으로 형 변환
				MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
				
				String itemFilePath = productPath + File.separator;	 
																												
				FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
				Map<String, Object> fileInfo = fileUtil.uploadFiles();	
				
				paramMap.put("file_madd", fileInfo.get("file_loc"));
				
				
				String asd  = "";
				
				System.out.println(fileInfo.get("file_nm"));
				
				if(fileInfo.get("file_nm") == asd || fileInfo.get("file_nm" ) == null){
					paramMap.put("file_name", "");
					
					System.out.println("여기냐");
				} else {
					paramMap.put("file_name", fileInfo.get("file_nm"));
					paramMap.put("file_nadd",  logicalrootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
					paramMap.put("file_size", fileInfo.get("file_size"));
					productdao.fileRegist(paramMap);
					System.out.println("왜 들어오냐");

				}
				paramMap.put("fileyn", "Y");

		return productdao.prdRegist(paramMap);
	}
	
	
	
	/** 상품 단건 조회 */
	public productModel prdSelect(Map<String, Object> paramMap) throws Exception {
		
		return productdao.prdSelect(paramMap);
	};
	
	/** 상품 수정 */
	public int prdUpdate(Map<String, Object> paramMap) throws Exception {
		
		return productdao.prdUpdate(paramMap);
	}
	
	/** 파일 수정 */
	public int fileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String itemFilePath = productPath + File.separator;	 
																										
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();	
		
		paramMap.put("file_madd", fileInfo.get("file_loc"));
		paramMap.put("file_name", fileInfo.get("file_nm"));
		paramMap.put("file_size", fileInfo.get("file_size"));
		
		if(fileInfo.get("file_size") != null || fileInfo.get("file_size") != "" ) {
			paramMap.put("file_nadd",  logicalrootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		}	else {
			paramMap.put("file_nadd", null);
		}

		paramMap.put("fileyn", "Y");

		return productdao.fileUpdate(paramMap);
	}
 
	

	

	
}
