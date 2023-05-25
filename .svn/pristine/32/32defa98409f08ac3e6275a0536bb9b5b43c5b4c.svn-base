package kr.happyjob.study.accounting.controller;

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

import kr.happyjob.study.accounting.model.AccTitleModel;
import kr.happyjob.study.accounting.service.AccTitleService;
import kr.happyjob.study.adm.model.ApprovalModel;
import kr.happyjob.study.hwang.model.HnoticeModel;

@Controller     
@RequestMapping("/accounting/")
public class AcctitleController {
	
	@Autowired
	AccTitleService AccTitleService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 회계 연결
	@RequestMapping("acctitle.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		model.addAttribute("loginId", (String) session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".acctitile");
		
		return "accounting/accTitle";
	}
	
	
	
	
	@RequestMapping("listAccTitle.do")
	public String listAccTitleModel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listAccTitle");
		logger.info("   - paramMap : " + paramMap);
		

	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageIndex = (cpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<AccTitleModel> listAccTitle = AccTitleService.listAccTitle(paramMap);
		
		int counthnoticelist = AccTitleService.counthnoticelist(paramMap);
		
		model.addAttribute("listAccTitle", listAccTitle);
		model.addAttribute("counthnoticelist", counthnoticelist);
		
		logger.info("+ End " + className + ".listAccTitle");
		
		return "accounting/accTitleList";
	}	
		
		
	@RequestMapping("selectAccTitle.do")
	@ResponseBody
	public Map<String, Object> selectAccTitle(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		AccTitleModel selectAccTitle = AccTitleService.selectAccTitle(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCCESS");
		returnmap.put("selectAccTitle", selectAccTitle);
		
		logger.info("+ End " + className + ".selectAccTitle");

		return returnmap;
		
	}	
	
	
	@RequestMapping("saveAccTitle.do")
	@ResponseBody
	public Map<String, Object> saveAccTitle(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		
		String action = (String) paramMap.get("action");
		
		if("I".equals(action)) {
			AccTitleService.saveAccTitle(paramMap);
		} else if("U".equals(action)) {
			AccTitleService.updateAccTitle(paramMap);
		} else if("D".equals(action)) {
			AccTitleService.deleteAccTitle(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCCESS");
		
		logger.info("+ End " + className + ".saveAccTitle");

		return returnmap;
	}		
	
}
