package kr.happyjob.study.employee.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.employee.model.EmpPaymentModel;
import kr.happyjob.study.employee.model.empMgtModel;
import kr.happyjob.study.employee.service.EmpPaymentService;
import kr.happyjob.study.employee.service.empMgtService;

import javax.servlet.http.HttpSession;

/**
 * @author 송학관
 * 급여조회
 */
@Controller
@RequestMapping("/employee/")
public class EmpPaymentController {
	
	@Autowired
	private empMgtService empMgtService;
	
	@Autowired
	private EmpPaymentService service;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 급여관리 페이지로 이동
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("empPayment.do")
	public String empPayment(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".empPayment");
		logger.info("   - paramMap : " + paramMap);
		
        LocalDate ld = null;

        int date = LocalDate.now().getDayOfMonth();

        if(date >= 10) {
            ld = LocalDate.now().minusMonths(1);
        }
        else {
            ld = LocalDate.now().minusMonths(2);
        }

        // model.addAttribute("maxDate", ld.toString().substring(0, 7));
		
		logger.info("+ End " + className + ".empPayment");
		return "employee/empPayment";
	}

	/**
	 * 급여 지급 내역 조회 리스트
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("empPaymentList.do")
	public String empPaymentList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".empPayment");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<EmpPaymentModel> lists = service.getPaymentList(paramMap);
		model.addAttribute("lists", lists);
		
		int count = service.getPaymentListCount(paramMap);
		model.addAttribute("totalcnt", count);

		model.addAttribute("currentPage", paramMap.get("currentPage"));
		
		logger.info("+ End " + className + ".empPayment");
		return "employee/empPaymentList";
	}

	/**
	 * 급여 선택 지급
	 * @param model
	 * @param paramMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("addEmpPayment.do")
	public Map<String, Object> addEmpPayment(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".empPayment");
		logger.info("   - paramMap : " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		Map<String, Object> resultMap = new HashMap<>();
		
		int status = service.addEmpPayment(paramMap);
		resultMap.put("status", status);

		resultMap.put("currentPage", paramMap.get("currentPage"));
		
		logger.info("+ End " + className + ".empPayment");
		return resultMap;
	}

	/**
	 * 급여 일괄 지급
	 * @param model
	 * @param paramMap
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("addAllEmpPayment.do")
	public Map<String, Object> addAllEmpPayment(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".empPayment");
		logger.info("   - paramMap : " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		Map<String, Object> resultMap = new HashMap<>();
		
		int status = service.addAllEmpPayment(paramMap);
		resultMap.put("status", status);
		
		logger.info("+ End " + className + ".empPayment");
		return resultMap;
	}

	/**
	 * 급여 지급 내역 상세 조회 리스트
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("empPaymentDetailList.do")
	public String empPaymentDetailList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".empPayment");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<EmpPaymentModel> lists = service.empPaymentDetailList(paramMap);
		model.addAttribute("lists", lists);
		
		int totalcnt = service.empPaymentDetailListCount(paramMap);
		model.addAttribute("totalcnt", totalcnt);
		
		empMgtModel emp = empMgtService.empSelect(paramMap);
		model.addAttribute("emp", emp);
		
		logger.info("+ End " + className + ".empPayment");
		return "employee/empPaymentDetailList";
	}
}
