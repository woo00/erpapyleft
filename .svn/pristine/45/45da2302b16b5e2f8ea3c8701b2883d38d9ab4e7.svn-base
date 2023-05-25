package kr.happyjob.study.accounting.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.accounting.model.BmDvModel;
import kr.happyjob.study.accounting.model.DvModel;
import kr.happyjob.study.accounting.service.BmDvDaoService;

@Controller
@RequestMapping("/accounting/")
public class BmDvController {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BmDvDaoService service;
	
	@RequestMapping("bmDv.do")
	public String initBmDv(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".bmDv");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".bmDv");
		return "accounting/bmDv";
	}
	@RequestMapping("bmDvlist.do")
	public String bmDvlist(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request ,HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".bmDvlist");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.parseInt((String)paramMap.get("cpage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		
		int pageindex = (cpage-1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("pageindex", pageindex);
		
		List<BmDvModel> bmDvlist = service.list(paramMap);
		int totalcnt = service.dvtotalcnt(paramMap);
		
		logger.info("totalcnt : " + totalcnt);
		
		model.addAttribute("bmDvlist", bmDvlist);
		model.addAttribute("dvtotalcnt", totalcnt);
		
		logger.info("+ End " + className + ".bmDvlist");
		return "accounting/bmDvlist";
	}
	
	@RequestMapping("detail.do")
	@ResponseBody
	public Map<String, Object> detail(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request ,HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".detail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		logger.info("num : " + paramMap.get("num"));
		
		paramMap.put("dv_code",paramMap.get("num"));
		paramMap.put("dv_signUser", session.getAttribute("loginId"));
		
		
		resultMap.put("dv_signUser", session.getAttribute("loginId"));
		resultMap.put("result",service.detail(paramMap));
		
		logger.info("+ End " + className + ".detail");
		return resultMap;
	}
	 
	@RequestMapping("bmdvSave.do")
	@ResponseBody
	public Map<String, Object> dvSave(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request ,HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".dvSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		paramMap.put("dv_signUser", session.getAttribute("loginId"));
		paramMap.put("dv_code", Integer.parseInt((String)paramMap.get("dv_code")));
	
		String action = (String) paramMap.get("action");
		
		if("I".equals(action)){
		resultMap.put("result", service.dvSave(paramMap));
		}
		
		
		logger.info("+ End " + className + ".dvSave");
		return resultMap;
	}
	@RequestMapping("bmDvFileDownload.do")
	public void bmDvFileDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".bmDvFileDownload");
		logger.info("   - paramMap : " + paramMap);	
		
		BmDvModel dvDetail =service.detail(paramMap);
		
		String fileName =dvDetail.getFile_name();
		String filemadd =dvDetail.getFile_madd();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(filemadd));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		logger.info("+ End " + className + ".bmDvFileDownload");
		
		return;
	}
	
	
	
}
