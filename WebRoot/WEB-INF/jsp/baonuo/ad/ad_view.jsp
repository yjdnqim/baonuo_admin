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
<div class="layui-nav layui-bg-gray layui-breadcrumb" lay-filter="breadcrumb" lay-separator="»">
	<a href="${pd.FROM_PAGE_HREF}">${pd.FROM_PAGE_TITLE}</a>
	<a><cite>【】详情</cite></a>
</div>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-card-header">基本信息</div>
		<div class="layui-card-body layui-text">
			<table class="layui-table">
				<colgroup>
					<col width="150">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<td>广告名称</td>
					<td>${ad.NAME}</td>
				</tr>
				<tr>
					<td>广告类型</td>
					<td>${ad.TYPE}</td>
				</tr>
				<tr>
					<td>广告图片</td>
					<td>${ad.IMG_URL}</td>
				</tr>
				<tr>
					<td>广告链接</td>
					<td>${ad.LINK}</td>
				</tr>
				<tr>
					<td>广告排序</td>
					<td>${ad.SORT}</td>
				</tr>
				<tr>
					<td>生效时间</td>
					<td>${ad.START_TIME}</td>
				</tr>
				<tr>
					<td>失效时间</td>
					<td>${ad.END_TIME}</td>
				</tr>
				<tr>
					<td>扩展字段1</td>
					<td>${ad.EXT_FIELD_1}</td>
				</tr>
				<tr>
					<td>扩展字段2</td>
					<td>${ad.EXT_FIELD_2}</td>
				</tr>
				<tr>
					<td>扩展字段3</td>
					<td>${ad.EXT_FIELD_3}</td>
				</tr>
				<tr>
					<td>创建时间</td>
					<td>${ad.CREATE_TIME}</td>
				</tr>
				<tr>
					<td>修改时间</td>
					<td>${ad.EDIT_TIME}</td>
				</tr>
				<tr>
					<td>操作人</td>
					<td>${ad.OPTION_PERSON}</td>
				</tr>
				<tr>
					<td>是否已删除</td>
					<td>${ad.IS_DELETED}</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script src="static/layuiadmin/layui/layui.js"></script>
<script>

	layui.config({
		base: 'static/layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'form'])

</script>
</body>
</html>