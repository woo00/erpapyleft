package kr.happyjob.study.employee.controller;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("employee")
public class EmpEntController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("empEnt.do")
	public String initEmpEnt(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".empEnt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".empEnt");
		return null;
	}
	
}
