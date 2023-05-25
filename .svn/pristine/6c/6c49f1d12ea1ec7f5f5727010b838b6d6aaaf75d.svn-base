package kr.happyjob.study.sales.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import kr.happyjob.study.sales.model.SalesModel;
import kr.happyjob.study.sales.service.YRevService;

@Controller
@RequestMapping("/sales")
public class YyRevenueController {

	@Autowired	
	YRevService yRevService;

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
	 * 년도별매출관리 초기화면
	 */
	@RequestMapping("/yyRevenue.do")
	public String inityyRevenue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		//날짜 형식 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		//한국 시간 설정
		Calendar ca1 = Calendar.getInstance(Locale.KOREA);
		
        String toDate= sdf.format(ca1.getTime());
        ca1.setTime(ca1.getTime());
        
        ca1.add(Calendar.YEAR, -2);
        String fromDate = sdf.format(ca1.getTime());

		model.addAttribute("toDate", toDate);
		model.addAttribute("fromDate", fromDate);

		return "/sales/yyRevenue";
	}

	
	/**
	 * 년도별 손익통계 테이블
	 */
	@RequestMapping("listYSales.do")
	public String listYSales(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".listYSales");
		logger.info("   - paramMap :  " + paramMap);
		
		//콤보박스 값
		combo = (String) paramMap.get("searchKey");
		
		/** 사용자 직접 입력 조회(combo:user_input) */
		if(combo.equals("user_input")) {
			
			List<SalesModel> listYSalesUIModel = yRevService.listYSalesUI(paramMap);
			model.addAttribute("listYSalesModel", listYSalesUIModel);
			
			logger.info("+ End " + className + ".listYSales");

			return "/sales/yRevUIList";
			
		} 
		
		/** 상/하반기 조회(combo:half) */
		else if(combo.equals("half")) {
			List<SalesModel> listYSalesHalfModel = yRevService.listYSalesHalf(paramMap);
			model.addAttribute("listYSalesModel", listYSalesHalfModel);
			
			logger.info("+ End " + className + ".listYSales");

			return "/sales/yRevQuartList";
			
		}
		/** 1-4분기 조회(combo:quarter) */
		else {
			List<SalesModel> listYSalesQuartModel = yRevService.listYSalesQuart(paramMap);
			model.addAttribute("listYSalesModel", listYSalesQuartModel);
			
			logger.info("+ End " + className + ".listYSales");
			
			return "/sales/yRevQuartList";
		}

		
		
	}
	
	/**
	 * 년도별 손익통계 차트
	 */
	@RequestMapping("viewyyChart.do")
	public String viewYSales(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".viewYSales");
		logger.info("   - paramMap :  " + paramMap);
		
		/** 사용자 직접 입력 조회(combo:user_input) */
		if(combo.equals("user_input")) {
			
			// 월별매출 목록 조회
			List<SalesModel> listYSalesUIModel = yRevService.listYSalesUI(paramMap);
			model.addAttribute("listYSalesModel", listYSalesUIModel);
			logger.info(listYSalesUIModel);
			
			logger.info("+ End " + className + ".viewyyChart");

			return "/sales/yRevUIChart";
			
		} 
		
		/** 상/하반기 조회(combo:half) */
		else if(combo.equals("half")) {
			List<SalesModel> listYSalesHalfModel = yRevService.listYSalesHalf(paramMap);
			model.addAttribute("listYSalesModel", listYSalesHalfModel);
			
			logger.info("+ End " + className + ".viewyyChart");
			
			return "/sales/yRevHalfChart";
			
		}
		/** 1-4분기 조회(combo:quarter) */
		else {
			List<SalesModel> listYSalesModel = yRevService.listYSalesQuart(paramMap);
			model.addAttribute("listYSalesModel", listYSalesModel);
			
			logger.info("+ End " + className + ".viewyyChart");
			
			return "/sales/yRevQuartChart";
		}

		
		
	}
	

	


	
	

}
