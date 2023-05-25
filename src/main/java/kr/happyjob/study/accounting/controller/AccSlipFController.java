package kr.happyjob.study.accounting.controller;

import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

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

import kr.happyjob.study.accounting.model.AccSlipFModel;
import kr.happyjob.study.accounting.service.AccSlipFService;
import kr.happyjob.study.hwang.model.HnoticeModel;
import kr.happyjob.study.hwang.service.HnoticeService;

@Controller
@RequestMapping("accounting")
public class AccSlipFController {
	
	@Autowired
	AccSlipFService accslipfService;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("accSlipF.do")
	public String accSlipF(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".accSlipF");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".accSlipF");
		return "accounting/accslipf";
	}	
	
	@RequestMapping("accslipflist.do")
	public String accslipflist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".accslipflist");
		logger.info("   - paramMap : " + paramMap);
		
		// 1     0
		// 2     10
		// 3     20		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageindex = (cpage - 1) * pageSize;
		
		paramMap.put("pageindex", pageindex);
		paramMap.put("pageSize", pageSize);
		
		System.out.println("pageindex :" +pageindex);
		System.out.println("pageSize :"+pageSize);
		
		List<AccSlipFModel> accslipflist = accslipfService.accslipflist(paramMap);
		

		int countaccslipflist = accslipfService.countaccslipflist(paramMap);
		
		model.addAttribute("accslipflist",accslipflist);
		model.addAttribute("countaccslipflist", countaccslipflist);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cpage", cpage);
		
		logger.info("+ End " + className + ".accslipflist");

		return "accounting/accslipflist";
	}	
	@RequestMapping("accslipfmodal.do")
	public String accslipfmodal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".accSlipModal");
		logger.info("   - paramMap : " + paramMap);
		
		// 목록 조회
		List<AccSlipFModel> accslipfmodal = accslipfService.accslipfmodal(paramMap);
		logger.info("accslipfmodal : " + accslipfmodal );
		
		int countaccslipflist = accslipfService.countaccslipflist(paramMap);
		
		model.addAttribute("countaccslipflist", countaccslipflist);
		model.addAttribute("accslipfmodal",accslipfmodal);
		
		
		logger.info("+ End " + className + ".accSlipModal");
		return "accounting/accslipfmodal";
	}
	
}
