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

import kr.happyjob.study.accounting.model.DvModel;
import kr.happyjob.study.accounting.service.DvService;

@Controller
@RequestMapping("accounting")
public class DvController {
	
	@Autowired
	DvService dvService;
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("empDv.do")
	public String initEmpDv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
								HttpServletResponse response, HttpSession session) throws Exception {
		String userType = (String) session.getAttribute("userType");
		String loginID	= (String) session.getAttribute("loginId");
		
		paramMap.put("loginID", loginID);
		
		String name = dvService.getName(paramMap);
		
		model.addAttribute("name",name);
		model.addAttribute("userType",userType);
		model.addAttribute("loginID",loginID);

		return "accounting/DVApply";
	}	
	
	@RequestMapping("Dvlist.do")
	public String Dvlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEmpDv");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int cpage = Integer.parseInt((String) paramMap.get("cpage"));
		int pageindex = (cpage - 1) * pageSize;
		
		String loginID	= (String) session.getAttribute("loginId");
		model.addAttribute("loginID",loginID);

		paramMap.put("pageindex", pageindex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginID", loginID);
		
		
		List<DvModel> dvList = dvService.dvList(paramMap);
		model.addAttribute("dvList", dvList);

		int dvListcnt = dvService.dvListcnt(paramMap);
		model.addAttribute("dvListcnt", dvListcnt);
		
		
		return "accounting/DVApplylist";
	}
	
	@RequestMapping("dvDetail.do")
	@ResponseBody
	public Map<String, Object> dvDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
	
		logger.info("+ Start " + className + ".detailone");
		logger.info("   - paramMap : " + paramMap);	
		
		DvModel dvDetail = dvService.dvDetail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("result", "SUCCESS");
		resultMap.put("dvDetail", dvDetail);
		
		logger.info("+ End " + className + ".detailone");
		
		return resultMap;
	}
	
	@RequestMapping("dvSave.do")
	@ResponseBody
	public Map<String, Object> dvSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		String action = (String) paramMap.get("action");
		
		if ("I".equals(action)) {
			dvService.dvFile(paramMap, request);
			dvService.dvSave(paramMap);
		}else if ("U".equals(action)) {
			dvService.dvFileUpdate(paramMap, request);
			dvService.dvUpdate(paramMap);
		}else if ("D".equals(action)) {
			dvService.dvFileDelete(paramMap, request);
			dvService.dvDelete(paramMap);
		}
		
		Map<String, Object> resultMap =new HashMap<String,Object>();
		
		resultMap.put("result", "SUCCESS");
		
		return resultMap;
	}
	@RequestMapping("dvFileDownload.do")
	public void dvFileDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".hnoticefiledownaload");
		logger.info("   - paramMap : " + paramMap);	
		
		DvModel dvDetail =dvService.dvDetail(paramMap);
		
		String fileName =dvDetail.getFile_name();
		String filemadd =dvDetail.getFile_madd();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(filemadd));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		logger.info("+ End " + className + ".dvFileDownload");
		
		return;
	}
}
