package com.fh.controller.baonuo;

import com.fh.controller.base.BaseController;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/statistics")
public class StatisticsController extends BaseController {

    @RequestMapping(value="/index")
    public ModelAndView index() throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("baonuo/statistics/index");
        mv.addObject("pd", pd);
        return mv;
    }
}
