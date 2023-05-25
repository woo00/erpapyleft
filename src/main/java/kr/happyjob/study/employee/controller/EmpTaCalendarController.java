package kr.happyjob.study.employee.controller;

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

import kr.happyjob.study.employee.model.EmpTaModel;
import kr.happyjob.study.employee.service.EmpTaService;

@Controller
@RequestMapping("/employee/")
public class EmpTaCalendarController {
	
	@Autowired
	EmpTaService service;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	  
	//초기설정
	@RequestMapping("empTaCalendar.do")
	public String initEmpTaCalendar(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".empTaCalendar");
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("userNm", (String) session.getAttribute("userNm"));
		model.addAttribute("loginId", (String) session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".empTaCalendar");
		return "employee/empTaCalendar";
		
	}
	
	// list
	@RequestMapping("empTalist.do")
	public String empTalist(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".empTaCalendar");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageindex = (cpage - 1) * pageSize;
		
		paramMap.put("pageindex", pageindex);
		paramMap.put("pageSize", pageSize);
		
		List<EmpTaModel> emptalist = service.emptalist(paramMap);
		int emptalistcnt = service.emptalistcnt(paramMap);
		
		model.addAttribute("empTalist", emptalist);
		model.addAttribute("countempTalist" ,emptalistcnt );
		
		logger.info("+ End " + className + ".empTaCalendar");
		return "employee/empTaList";
	}
	
	
	//상세보기
	@RequestMapping("empdetail.do")
	@ResponseBody
	public Map<String, Object> empDetail(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".empdetail");
		logger.info("   - paramMap : " + paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("detail", service.detail(paramMap));
		
		logger.info("+ End " + className + ".empdetail");
		return resultMap;
	}
	
	//저장
	@RequestMapping("detailsave.do")
	@ResponseBody
	public Map<String, Object> detailSave(Model model, @RequestParam Map<String, Object> paramMap
			, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".detailSave");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", service.detailsave(paramMap));
		
		
		logger.info("+ End " + className + ".detailSave");
		return resultMap;
	}
}
