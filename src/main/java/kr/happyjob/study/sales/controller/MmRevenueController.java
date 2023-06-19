package kr.happyjob.study.sales.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import kr.happyjob.study.sales.service.MRevService;

@Controller
@RequestMapping("/sales")
public class MmRevenueController {

	@Autowired	
	MRevService mRevService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//combox select 값
	private String combo;
	
	//조회 날짜
	private String toDate;
	private String fromDate;

	
	/**
	 * 월별매출관리 초기화면
	 */
	@RequestMapping("/mmRevenue.do")
	public String initmmRevenue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		//날짜 형식 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		//한국 시간 설정
		Calendar ca1 = Calendar.getInstance(Locale.KOREA);
		
        toDate= sdf.format(ca1.getTime());
        ca1.setTime(ca1.getTime());
        
        ca1.add(Calendar.MONTH, -5);
        fromDate = sdf.format(ca1.getTime());

		model.addAttribute("toDate", toDate);
		model.addAttribute("fromDate", fromDate);

		return "/sales/mmRevenue";
	}
	/**
	 * 월별매출관리 초기화면 Vue
	 */
	@RequestMapping("/mmRevenueVue.do")
	public String mmRevenueVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//날짜 형식 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		//한국 시간 설정
		Calendar ca1 = Calendar.getInstance(Locale.KOREA);
		
		toDate= sdf.format(ca1.getTime());
		ca1.setTime(ca1.getTime());
		
		ca1.add(Calendar.MONTH, -5);
		fromDate = sdf.format(ca1.getTime());
		
		model.addAttribute("toDate", toDate);
		model.addAttribute("fromDate", fromDate);
		
		return "/sales/mmRevenueVue";
	}

	
	/**
	 * 월별 손익통계 테이블
	 */
	@RequestMapping("listMSales.do")
	public String listMSales(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".listMSales");
		logger.info("   - paramMap :  " + paramMap);
		
		List<SalesModel> listMSalesUIModel = mRevService.listMSalesUI(paramMap);
		model.addAttribute("listMSalesModel", listMSalesUIModel);
		logger.info("+ End " + className + ".listMSales");

		return "/sales/mRevUI";
	}
	/**
	 * 월별 손익통계 테이블 Vue
	 */
	@RequestMapping("listMSalesVue.do")
	@ResponseBody
	public Map<String, Object> listMSalesVue(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".listMSales");
		logger.info("   - paramMap :  " + paramMap);
		
		List<SalesModel> listMSalesUIModel = mRevService.listMSalesUI(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("listMSalesUIModel", listMSalesUIModel);
		
		logger.info("+ End " + className + ".listMSales");
		
		return resultMap;
	}
	
	/**
	 * 월별 손익통계 차트
	 */
	@RequestMapping("viewmmChart.do")
	public String viewmmChart(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".viewmmChart");
		logger.info("   - paramMap : " + paramMap);
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy");

		List<SalesModel> listMSalesUIModel = mRevService.listMSalesUI(paramMap);
		model.addAttribute("listMSalesModel", listMSalesUIModel);
		logger.info("+ End " + className + ".viewmmChart");

		return "/sales/mRevUIChart";
	}
	/**
	 * 월별 손익통계 차트Vue
	 */
	@RequestMapping("viewmmChartVue.do")
	@ResponseBody
	public Map<String, Object> viewmmChartVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".viewmmChart");
		logger.info("   - paramMap : " + paramMap);
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy");
		
		List<SalesModel> listMSalesUIModel = mRevService.listMSalesUI(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("listMSalesUIModel", listMSalesUIModel);
		
		logger.info("+ End " + className + ".viewmmChart");
		
		return resultMap;
	}
	


}
