package kr.happyjob.study.employee.controller;

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

import kr.happyjob.study.employee.model.taapproveModel;
import kr.happyjob.study.employee.service.taapproveService;

@Controller
@RequestMapping("employee")
public class EmpTaapproveController {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	taapproveService service;
	
	// 휴가 관리(관리자, 회계총무, 영업, 임원) - 휴가 관리 페이지 이동
	@RequestMapping("taapprove.do")
	public String initEmpTaapprove(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".empTaapprove");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		model.addAttribute("loginID",session.getAttribute("loginId"));
		model.addAttribute("leave_date",service.getLeave_date(paramMap));
		model.addAttribute("use_leave",service.getUse_leave(paramMap));
		model.addAttribute("dept_name",service.getUser_detail(paramMap).getDept_name());
		model.addAttribute("user_name",service.getUser_detail(paramMap).getUse_loginID());
		
		logger.info("+ End " + className + ".empTaapprove");
		return "/employee/taapprove";
	}
	
	@RequestMapping("valist.do")
	public String valist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".valist");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int startPage = (Integer.parseInt((String) paramMap.get("page"))-1) * pageSize;
				
		paramMap.put("loginID", session.getAttribute("loginId"));
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		model.addAttribute("leave_date",service.valist(paramMap));
		model.addAttribute("use_leave",service.vacnt(paramMap));
		
		logger.info("+ End " + className + ".valist");
		return "/employee/valist";
	}
	
	@RequestMapping("vadetail.do")
	@ResponseBody
	public taapproveModel vadetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".vadetail");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vadetail");
		return service.vadetail(paramMap);
	}
	
	@RequestMapping("vasave.do")
	@ResponseBody
	public int vasave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".vasave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		if(action.equals("I"))
		{
			return service.vainsert(paramMap);
		}
		else if(action.equals("U"))
		{
			return service.vaupdate(paramMap);
		}
		else if(action.equals("D"))
		{
			return service.vadelete(paramMap);
		}
		
		logger.info("+ End " + className + ".vasave");
		return 0;
	}
	
	@RequestMapping("resultdetail.do")
	@ResponseBody
	public taapproveModel resultdetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".resultdetail");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".resultdetail");
		return service.resultdetail(paramMap);
	}
}
