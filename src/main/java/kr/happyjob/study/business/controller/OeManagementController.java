package kr.happyjob.study.business.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.business.service.OeManagementService;

@Controller
@RequestMapping("/business/")
public class OeManagementController {
	
	@Autowired
	OeManagementService service;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("oeManagement.do")
	public String 	initOeManagement(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".oeManagement");
		List<OeManagementModel> oemlist = service.select(paramMap);
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("oemlist", oemlist);
		
		model.addAttribute("userNm", (String) session.getAttribute("userNm"));
		model.addAttribute("loginId", (String) session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".oeManagement");
		return "business/oeManagement";
	}

	@RequestMapping("oeManagementList.do")
	public String oemlist(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".oeManagementList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageindex = (cpage - 1) * pageSize;
		
		paramMap.put("pageindex", pageindex);
		paramMap.put("pageSize", pageSize);
		
		List<OeManagementModel> oemlist = service.oemlist(paramMap);
		int oemlistcnt = service.oemlistcnt(paramMap);
		
		model.addAttribute("oemlist", oemlist);
		model.addAttribute("counteoemlist" ,oemlistcnt );
		
		logger.info("==========================");
		for(OeManagementModel list : oemlist) {
			logger.info(list.getBiz_code() + " / " + list.getBiz_name());
		}
		
		logger.info("+ End " + className + ".oeManagementList");
		return "business/oeManagementList";
	}
	@RequestMapping("oeManagementEmodal.do")
	@ResponseBody
	public Map<String, Object> oeManagementOmodal(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".oeManagementEmodal");
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		logger.info("   - paramMap : " + paramMap);
		
		int num = Integer.parseInt((String) paramMap.get("num"));
		paramMap.put("est_code", num);
		resultMap.put("loginID", session.getAttribute("loginId"));
		resultMap.put("est_code", num);
		resultMap.put("oelist", service.detail(paramMap));
		resultMap.put("myoelist", service.detail2(paramMap));
		
		
		logger.info("+ End " + className + ".oeManagementEmodal");
		return resultMap;
	}
	
	@RequestMapping("oeManagementNewModal.do")
	@ResponseBody
	public Map<String, Object> oeManagementNewModal(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".oeManagementNewModal");
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		logger.info("   - paramMap : " + paramMap);
		
		int num = Integer.parseInt((String) paramMap.get("num"));
		paramMap.put("est_code", num);
		paramMap.put("loginId",session.getAttribute("loginId"));
		resultMap.put("loginID", session.getAttribute("loginId"));
		resultMap.put("est_code", num);
		resultMap.put("oelist", service.detail(paramMap));
		resultMap.put("myoelist", service.detail2(paramMap));
		
		
		logger.info("+ End " + className + ".oeManagementNewModal");
		return resultMap;
	}
	
	@RequestMapping("oeManagementSave.do")
	@ResponseBody
	public Map<String, Object>	oeManagementSave(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".oeManagementSave");
		logger.info("   - paramMap : " + paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("loginId",session.getAttribute("loginId"));
		resultMap.put("est_code", paramMap.get("num"));
		String action = (String) paramMap.get("action");
		String resultMsg = "suc";
		paramMap.put("loginId",session.getAttribute("loginId"));
		paramMap.put("prd_code", paramMap.get("prd_code"));
		paramMap.put("est_ocnt", Integer.parseInt((String)paramMap.get("est_ocnt")));
		if( "I".equals(action)){
			
			service.insert(paramMap);
			
			if("Y".equals(paramMap.get("est_yn"))){
				// 재고 -1
				// 실적수량 UDPATE
				// 회계전표 INSERT
				service.Ninsert(paramMap);
				
			}
		}else if("U".equals(action)){
			service.update(paramMap);
			if("Y".equals(paramMap.get("est_yn"))){
				// 재고 -1
				// 실적수량 UDPATE
				// 회계전표 INSERT
				service.Ninsert(paramMap);
				
			}
		}
		
		resultMap.put("result",resultMsg);
		
		logger.info("+ End " + className + ".oeManagementSave");
		return resultMap;
	}
	
}
