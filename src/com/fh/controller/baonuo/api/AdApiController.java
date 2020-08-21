package com.fh.controller.baonuo.api;

import com.fh.controller.base.BaseController;
import com.fh.service.baonuo.ad.AdService;
import com.fh.util.AppUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value="api/ad")
public class AdApiController extends BaseController {
    @Resource(name="adService")
    private AdService adService;

    @RequestMapping(value="/getAdList")
    @ResponseBody
    public Object getAdList(){
        PageData resultPageData = new PageData();
        PageData pd = this.getPageData();
        pd.put("IS_INVALID", "0");
        pd.put("CURRENT_TIME", Tools.date2Str(new Date()));
        try {
            List<PageData> adList = adService.api_getAdList(pd);
            resultPageData.put("code", 0);
            resultPageData.put("message", "OK");
            resultPageData.put("data", adList);
            AppUtil.returnObject(resultPageData, resultPageData);
        } catch (Exception e) {
            resultPageData.put("code", -1);
            resultPageData.put("message", e.getLocalizedMessage());
            e.printStackTrace();
        }
        return AppUtil.returnObject(resultPageData, resultPageData);
    }
}
