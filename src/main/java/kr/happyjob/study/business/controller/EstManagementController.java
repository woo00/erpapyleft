package kr.happyjob.study.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.model.EstManagementModel;
import kr.happyjob.study.business.service.EstManagementService;

@Controller
@RequestMapping("business")
public class EstManagementController {
	
	@Autowired
	private EstManagementService estManagementService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	@RequestMapping("estManagement.do")
	public String estManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".estManagement");
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("loginId", (String) session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".estManagement");
		return "business/EstManagement";
	}	
	@RequestMapping("estManagementVue.do")
	public String estManagementVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".estManagementVue");
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("loginId", (String) session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".estManagementVue");
		return "business/EstManagementVue";
	}	
	
	@RequestMapping("listpage.do")
	public String listpage(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".listpage");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageindex = (cpage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageindex);
		paramMap.put("pageSize", pageSize);
		System.out.println(pageSize);
		paramMap.forEach((key, value) -> System.out.println(key + ": " + paramMap.get(key)));
		
		List<EstManagementModel> listEmployeeModel = estManagementService.listpage(paramMap);
		model.addAttribute("listEmployeeModel", listEmployeeModel);

		int totalcnt = estManagementService.countlistpage(paramMap);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".listpage");
		return "business/EstManagementList";
	}
	
	@RequestMapping("listpageVue.do")
	@ResponseBody
	public Map<String, Object> listpageVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletResponse response,
				HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".listpage");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageIndex = (cpage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<EstManagementModel> listEmployeeModel = estManagementService.listpage(paramMap);
		
		int totalcnt = estManagementService.countlistpage(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("listEmployeeModel", listEmployeeModel);
		resultMap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".listpageVue");
		
		return resultMap;
	}
	

	
	@RequestMapping("estManagementSave.do")
	@ResponseBody
	public Map<String, Object> estManagementSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".estManagementSave");
		logger.info("   - paramMap : " + paramMap);		
		
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		
		String action = (String) paramMap.get("action");
		
		if("I".equals(action)) {
			estManagementService.estnewsave(paramMap);
		} else if("U".equals(action)) {
			estManagementService.estnewupdate(paramMap);
		} else if("D".equals(action)) {
			estManagementService.estnewdelete(paramMap);
		}
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		returnmap.put("result", "SUCCESS");
		
		logger.info("+ End " + className + ".estManagementSave");

		return returnmap;
	}		
	
	
	// 단건 조회 
	 	@RequestMapping("estManagementSelect.do")
	 	@ResponseBody
	 	public Map<String, Object> estManagementSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	 			HttpServletResponse response, HttpSession session) throws Exception{
	 	
			logger.info("+ 자바단 컨트롤러 Start " + className + " .estManagementSelect");
			logger.info("   - paramMap : " + paramMap);
	 		
	 		//단건 조회  
	 		//단건조회에 맞는 모달 안 리스트 뽑을 때 estimate_no는 여기서 꺼내서 썼음 
			EstManagementModel estpart = estManagementService.estManagementSelect(paramMap); 
	 		 Map<String, Object> resultMap = new HashMap<String, Object>();
	 		 
	 		resultMap.put("result", "SUCCESS");
	 		resultMap.put("estpart",estpart); // 단건조회 목록
		 
		 	logger.info("+ End " + className + "estpart"); // log4j  순서도 중요 
			 
	 		return resultMap ;
	 		
	 	}
}
