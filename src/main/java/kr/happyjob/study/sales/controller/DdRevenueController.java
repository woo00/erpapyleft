package kr.happyjob.study.sales.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import kr.happyjob.study.sales.model.SalesModel;
import kr.happyjob.study.sales.service.DRevService;

@Controller
@RequestMapping("/sales")
public class DdRevenueController {

	@Autowired	
	DRevService dRevService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 일별매출관리 초기화면
	 */
	
	@RequestMapping("/ddRevenue.do")
	public String initddRevenue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());

		model.addAttribute("today", strToday);
		
		return "sales/ddRevenue";
	}
	@RequestMapping("/ddRevenueVue.do")
	public String ddRevenueVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar c1 = Calendar.getInstance();
		
		String strToday = sdf.format(c1.getTime());
		
		model.addAttribute("today", strToday);
		
		return "sales/ddRevenueVue";
	}

	/**
	 * 일별매출목록 조회
	 */
	@RequestMapping("listDaySales.do")
	public String listDaySales(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listDaySales");
		logger.info("   - paramMap : " + paramMap);


		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("currentPage", currentPage);
		paramMap.put("pageSize", pageSize);
		
		// 일별주문조회 테이블
		List<SalesModel> listDSalesModel = dRevService.listDSales(paramMap);
		model.addAttribute("listDSalesModel", listDSalesModel);

		// 일별주문 목록 카운트 조회
		int totalCount = dRevService.countListddRevenue(paramMap);
		model.addAttribute("totalCntddRevenue", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageddRevenue",currentPage);

		logger.info("+ End " + className + ".listDaySales");


		return "/sales/ddRevenueList";
	}	
	@RequestMapping("listDaySalesVue.do")
	@ResponseBody
	public Map<String, Object> listDaySalesVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listDaySales");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("currentPage", currentPage);
		paramMap.put("pageSize", pageSize);
		
		// 일별주문조회 테이블
		List<SalesModel> listDSalesModel = dRevService.listDSales(paramMap);
		
		// 일별주문 목록 카운트 조회
		int totalCount = dRevService.countListddRevenue(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("listDSalesModel", listDSalesModel);
		resultMap.put("totalCount", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage", currentPage);
		
		
		logger.info("+ End " + className + ".listDaySales");
		
		
		return resultMap;
	}	
	
	/**
	 * 검색날짜 손익통계
	 */
	@RequestMapping("listDaySalesSum.do")
	public String listDaySalesSum(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listDaySalesSum");
		logger.info("   - paramMap : " + paramMap);

		List<SalesModel> listDaySalesSumModel = dRevService.listDaySalesSum(paramMap);
		model.addAttribute("listDaySalesSumModel", listDaySalesSumModel);

		logger.info("+ End " + className + ".listDaySalesSum");

		return "/sales/ddRevenueSumList";
	}	
	/**
	 * 검색날짜 손익통계 Vue
	 */
	@RequestMapping("listDaySalesSumVue.do")
	@ResponseBody
	public Map<String, Object> listDaySalesSumVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listDaySalesSum");
		logger.info("   - paramMap : " + paramMap);
		
		List<SalesModel> listDaySalesSumModel = dRevService.listDaySalesSum(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		resultMap.put("listDaySalesSumModel", listDaySalesSumModel);
		
		logger.info("+ End " + className + ".listDaySalesSum");
		
		return resultMap;
	}	
	
	/**
	 * 검색날짜 기준 한달간 매출 차트
	 */
	@RequestMapping("viewDaySalesChart.do")
	public String viewDaySalesChart(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".viewDaySalesChart");
		logger.info("   - paramMap : " + paramMap);

		List<SalesModel> listDaySalesChartModel = dRevService.listDaySalesChart(paramMap);
		model.addAttribute("listDaySalesChartModel", listDaySalesChartModel);

		logger.info("+ End " + className + ".viewDaySalesChart");

		return "/sales/ddRevenueSumChart";
	}
	/**
	 * 검색날짜 기준 한달간 매출 차트 Vue
	 */
	@RequestMapping("viewDaySalesChartVue.do")
	@ResponseBody
	public Map<String, Object> viewDaySalesChartVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".viewDaySalesChart");
		logger.info("   - paramMap : " + paramMap);
		
		List<SalesModel> listDaySalesChartModel = dRevService.listDaySalesChart(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		resultMap.put("listDaySalesChartModel", listDaySalesChartModel);
		
		logger.info("+ End " + className + ".viewDaySalesChart");
		
		return resultMap;
	}

}
