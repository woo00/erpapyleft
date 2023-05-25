package kr.happyjob.study.system.controller;

import kr.happyjob.study.system.model.PrdComcomboModel;
import kr.happyjob.study.system.service.PrdComcomboService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/system/")
public class PrdComcomboController {

    @Autowired
    private PrdComcomboService service;

    // Set logger
    private final Logger logger = LogManager.getLogger(this.getClass());

    // Get class name for logger
    private final String className = this.getClass().toString();

    @ResponseBody
    @RequestMapping("prdComcombo.do")
    public Map<String, Object> prdComcombo(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
        logger.info("+ Start " + className + ".product");
        logger.info("   - paramMap : " + paramMap);

        Map<String, Object> resultMap = new HashMap<String, Object>();

        PrdComcomboModel prdComcomboModel = service.prdComcombo(paramMap);
        resultMap.put("prd", prdComcomboModel);

        logger.info("+ End " + className + ".product");
        return resultMap;
    }
}
