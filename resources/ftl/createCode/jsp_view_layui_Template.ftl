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
	<a href="${r"${pd.FROM_PAGE_HREF"}${r"}"}">${r"${pd.FROM_PAGE_TITLE"}${r"}"}</a>
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
				<#list fieldList as var>
				<tr>
					<td>${var[2] }</td>
					<td>${r"${"}${objectNameLower}.${var[0] }${r"}"}</td>
				</tr>
				</#list>
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