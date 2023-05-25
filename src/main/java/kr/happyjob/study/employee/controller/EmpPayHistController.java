package kr.happyjob.study.employee.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.employee.model.EmpPayHistModel;
import kr.happyjob.study.employee.service.EmpPayHistService;

/**
 * 
 * @author 송학관
 * 급여관리
 *
 */
@Controller
@RequestMapping("employee")
public class EmpPayHistController {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	private EmpPayHistService service;
	
	@RequestMapping("empPayHist.do")
	public String empPayHist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		logger.info("+ Start " + className + ".empPayHist");
		logger.info("   - paramMap : " + paramMap);
		
		
		logger.info("+ End " + className + ".empPayHist");
		return "employee/empPayHist";
	}
	
	@ResponseBody
	@RequestMapping("empPayHistInfo.do")
	public Map<String, Object> empPayHistInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		logger.info("+ Start " + className + ".empPayHist");
		logger.info("   - paramMap : " + paramMap);
		
		HttpSession session = request.getSession();
		String loginID =(String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		paramMap.forEach((key, value)-> System.out.println(key + " : " + value));
		
		Map<String, Object> resultMap = new HashMap<>();
		
		EmpPayHistModel info = service.empPayHistInfo(paramMap);
		resultMap.put("info", info);
		
		logger.info("+ End " + className + ".empPayHist");
		return resultMap;
	}
}
