<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top_layui.jsp" %>
</head>
<body>

<div class="layui-form" wid100 lay-filter="layuiadmin-form-admin" id="layuiadmin-form-admin" style="padding: 20px 30px 0 0;">
	<input type="hidden" name="AD_ID" value="${pd.AD_ID}">

	<div class="layui-form-item">
		<label class="layui-form-label">广告名称</label>
		<div class="layui-input-inline">
			<input type="text" name="NAME" id="NAME" value="${pd.NAME}" lay-verify="required" placeholder="请输入广告名称" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">广告类型</label>
		<div class="layui-input-inline">
			<input type="number" name="TYPE" id="TYPE" value="${pd.TYPE}" lay-verify="number" placeholder="请输入广告类型" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">广告图片</label>
		<div class="layui-input-inline">
			<input type="text" name="IMG_URL" id="IMG_URL" value="${pd.IMG_URL}" lay-verify="required" placeholder="请输入广告图片" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">广告链接</label>
		<div class="layui-input-inline">
			<input type="text" name="LINK" id="LINK" value="${pd.LINK}" lay-verify="required" placeholder="请输入广告链接" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">广告排序</label>
		<div class="layui-input-inline">
			<input type="number" name="SORT" id="SORT" value="${pd.SORT}" lay-verify="number" placeholder="请输入广告排序" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">生效时间</label>
		<div class="layui-input-inline">
			<input type="text" name="START_TIME" id="START_TIME" value="${pd.START_TIME}" lay-verify="required" placeholder="请输入生效时间" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">失效时间</label>
		<div class="layui-input-inline">
			<input type="text" name="END_TIME" id="END_TIME" value="${pd.END_TIME}" lay-verify="required" placeholder="请输入失效时间" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<button lay-submit lay-filter="LAY-front-submit" id="LAY-front-submit">确认</button>
	</div>
</div>
<script src="static/layuiadmin/layui/layui.js"></script>
<script>

	layui.config({
		base: 'static/layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form', 'laydate'], function(){
		var form = layui.form, laydate = layui.laydate;
		laydate.render({
			elem: '#DATE_FIELD_ELE_ID'
		});
	})

</script>
</body>
</html>