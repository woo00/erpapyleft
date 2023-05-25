package kr.happyjob.study.business.service;

import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.business.model.productModel;

public interface productService {

	/** 제품 리스트 조회 */
	public List<productModel> prdList(Map<String, Object> paramMap) throws Exception;
	
	/** 제품수 카운트 */
	public int countListPrd(Map<String, Object> paramMap) throws Exception;
	
	/** 제품 등록 시 회계전표 insert */
	public int fnlRegist(Map<String, Object> paramMap) throws Exception;
	
	/** 대분류 리스트 조회 */
	public List<productModel> pbList(Map<String, Object> paramMap) throws Exception;
	
	/** 소분류 A 리스트 조회 */
	public List<productModel> psAList(Map<String, Object> paramMap) throws Exception;
	
	/** 소분류 B 리스트 조회 */
	public List<productModel> psBList(Map<String, Object> paramMap) throws Exception;
	
	/** 소분류 C 리스트 조회 */
	public List<productModel> psCList(Map<String, Object> paramMap) throws Exception;
	
	/** 신규 제품 등록 */
	public int prdRegist(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	
	/** 상품 단건 조회 */
	public productModel prdSelect(Map<String, Object> paramMap) throws Exception;  
	
	/** 상품 수정 */
	public int prdUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 파일 수정 */
	public int fileUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
 
}
