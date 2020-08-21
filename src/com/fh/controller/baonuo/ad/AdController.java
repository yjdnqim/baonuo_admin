package com.fh.controller.baonuo.ad;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import com.fh.util.*;
import org.apache.http.util.TextUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.service.baonuo.ad.AdService;

/** 
 * 类名称：AdController
 * 创建人：Lcs-Admin
 * 创建时间：2020-08-20
 */
@Controller
@RequestMapping(value="ad")
public class AdController extends BaseController {
	
	@Resource(name="adService")
	private AdService adService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save(){
		logBefore(logger, "新增Ad");
		PageData resultPageData = new PageData();
		PageData pd = this.getPageData();
		pd.put("AD_ID", this.get32UUID());	//主键
		pd.put("EXT_FIELD_1", "");	//扩展字段1
		pd.put("EXT_FIELD_2", "");	//扩展字段2
		pd.put("EXT_FIELD_3", "");	//扩展字段3
		pd.put("CREATE_TIME", Tools.date2Str(new Date()));	//创建时间
		pd.put("EDIT_TIME", Tools.date2Str(new Date()));	//修改时间
		pd.put("OPTION_PERSON", getCurrentUser().getNAME());	//操作人
		pd.put("IS_DELETED", "0");	//是否已删除

		try {
			adService.save(pd);
			resultPageData.put("code", 0);
			resultPageData.put("message", "OK");
		} catch (Exception e) {
			resultPageData.put("code", -1);
			resultPageData.put("message", e.getLocalizedMessage());
		}
		return AppUtil.returnObject(resultPageData, resultPageData);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(){
		logBefore(logger, "删除Ad");
		PageData resultPageData = new PageData();
		PageData pd = this.getPageData();
		try{
			adService.delete(pd);
			resultPageData.put("code", 0);
			resultPageData.put("message", "OK");
		} catch(Exception e){
			resultPageData.put("code", -1);
			resultPageData.put("message", e.getLocalizedMessage());
		}
		return AppUtil.returnObject(resultPageData, resultPageData);
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public Object edit(){
		logBefore(logger, "修改Ad");
		PageData resultPageData = new PageData();
		PageData pd = this.getPageData();
		try{
			pd.put("EDIT_TIME", Tools.date2Str(new Date()));	//修改时间
			adService.edit(pd);
			resultPageData.put("code", 0);
			resultPageData.put("message", "OK");
		} catch(Exception e){
			resultPageData.put("code", -1);
			resultPageData.put("message", e.getLocalizedMessage());
		}
		return AppUtil.returnObject(resultPageData, resultPageData);
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表Ad");
		ModelAndView mv = this.getModelAndView();
		try{
			PageData pd = this.getPageData();
			if(pd.get("IS_INVALID") != null && !TextUtils.isEmpty(pd.get("IS_INVALID").toString())){
				pd.put("CURRENT_TIME", Tools.date2Str(new Date()));
			}

			page.setPd(pd);

			List<PageData>	varList = adService.list(page);	//列出Ad列表
			mv.setViewName("baonuo/ad/ad_list");
			mv.addObject("varList", varList);

			pd.put("totalCount", page.getTotalResult());
			pd.put("pageCount", page.getShowCount());
			pd.put("currentPage", page.getCurrentPage());
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增Ad页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			mv.setViewName("baonuo/ad/ad_edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改Ad页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = adService.findById(pd);	//根据ID读取
			mv.setViewName("baonuo/ad/ad_edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}

	/**
	* 去查看页面
	*/
	@RequestMapping(value="/goView")
	public ModelAndView goView(){
		logBefore(logger, "去修改Ad页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			PageData adPd = adService.findById(pd);	//根据ID读取
			mv.setViewName("baonuo/ad/ad_view");
			mv.addObject("pd", pd);
			mv.addObject("ad", adPd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除Ad");
		PageData resultPageData = new PageData();
		try {
			PageData pd = this.getPageData();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				adService.deleteAll(ArrayDATA_IDS);
				resultPageData.put("code", 0);
				resultPageData.put("message", "OK");
			}else{
				resultPageData.put("code", -2);
				resultPageData.put("message", "缺少参数");
			}
		} catch (Exception e) {
			resultPageData.put("code", -1);
			resultPageData.put("message", e.getLocalizedMessage());
		}
		return AppUtil.returnObject(resultPageData, resultPageData);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出Ad到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("广告名称");	//1
			titles.add("广告类型");	//2
			titles.add("广告图片");	//3
			titles.add("广告链接");	//4
			titles.add("广告排序");	//5
			titles.add("生效时间");	//6
			titles.add("失效时间");	//7
			titles.add("扩展字段1");	//8
			titles.add("扩展字段2");	//9
			titles.add("扩展字段3");	//10
			titles.add("创建时间");	//11
			titles.add("修改时间");	//12
			titles.add("操作人");	//13
			titles.add("是否已删除");	//14
			dataMap.put("titles", titles);
			List<PageData> varOList = adService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("NAME"));	//1
				vpd.put("var2", varOList.get(i).get("TYPE").toString());	//2
				vpd.put("var3", varOList.get(i).getString("IMG_URL"));	//3
				vpd.put("var4", varOList.get(i).getString("LINK"));	//4
				vpd.put("var5", varOList.get(i).get("SORT").toString());	//5
				vpd.put("var6", varOList.get(i).getString("START_TIME"));	//6
				vpd.put("var7", varOList.get(i).getString("END_TIME"));	//7
				vpd.put("var8", varOList.get(i).getString("EXT_FIELD_1"));	//8
				vpd.put("var9", varOList.get(i).getString("EXT_FIELD_2"));	//9
				vpd.put("var10", varOList.get(i).getString("EXT_FIELD_3"));	//10
				vpd.put("var11", varOList.get(i).getString("CREATE_TIME"));	//11
				vpd.put("var12", varOList.get(i).getString("EDIT_TIME"));	//12
				vpd.put("var13", varOList.get(i).getString("OPTION_PERSON"));	//13
				vpd.put("var14", varOList.get(i).get("IS_DELETED").toString());	//14
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
