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
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">搜索字段1</label>
					<div class="layui-input-block">
						<input type="text" id="FIELD_1" name="FIELD_1" value="" placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">搜索字段2</label>
					<div class="layui-input-block">
						<select name="SEARCH_FIELD_2">
							<option value="0">请选择</option>
							<option value="1">option1</option>
							<option value="2">option2</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<button class="layui-btn layuiadmin-action-btn" lay-submit lay-filter="LAY-front-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>

		<div class="layui-card-body">
			<div style="padding-bottom: 10px;">
				<c:choose>
					<c:when test="${r"${not empty varList}"}">
						<c:if test="${r"${QX.del == 1}"}">
							<button class="layui-btn layui-btn-danger layuiadmin-action-btn" data-type="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>
						</c:if>
						<c:if test="${r"${QX.add == 1}"}">
							<button class="layui-btn layuiadmin-action-btn" data-type="add"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
						</c:if>
						<c:if test="${r"${QX.cha == 1}"}">
							<button class="layui-btn layuiadmin-action-btn" data-type="exportExcel"><i class="layui-icon layui-icon-export"></i>导出Excel</button>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${r"${QX.add == 1}"}">
							<button class="layui-btn layuiadmin-action-btn" data-type="add">添加</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>

			<table class="layui-table" id="LAY-data-manage" lay-filter="LAY-data-manage">
				<thead>
				<tr>
					<th lay-data="{field:'${objectNameUpper}_ID', type: 'checkbox'}"></th>
					<th lay-data="{field:'index'}">序号</th>
					<#list fieldList as var>
					<th lay-data="{field:'${var[0]}'}">${var[2]}</th>
					</#list>
					<th class="center" lay-data="{field:'ACTION', width:300, toolbar: '#table-tr-action'}">操作</th>
				</tr>
				</thead>

				<tbody>
				<!-- 开始循环 -->
				<c:choose>
					<c:when test="${r"${not empty varList}"}">
						<c:if test="${r"${QX.cha == 1}"}">
							<c:forEach items="${r"${varList}"}" var="var" varStatus="vs">
								<tr>
									<td>${r"${var."}${objectNameUpper}_ID${r"}"}</td>
									<td>${r"${vs.index+1}"}</td>
									<#list fieldList as var>
									<td>${r"${var."}${var[0]}${r"}"}</td>
									</#list>
									<td></td>
								</tr>

							</c:forEach>
						</c:if>
						<c:if test="${r"${QX.cha == 0}"}">
							<tr>
								<td colspan="100" style="text-align: center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" style="text-align: center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			<div id="laypage"></div>
			<script type="text/html" id="table-tr-action">
				<c:if test="${r"${QX.cha == 1}"}">
					<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="view"><i class="layui-icon layui-icon-form"></i>查看详情</a>
				</c:if>
				<c:if test="${r"${QX.edit == 1}"}">
					<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				</c:if>
				<c:if test="${r"${QX.del == 1}"}">
					<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
				</c:if>
			</script>
		</div>
	</div>
</div>
</body>
<script src="static/layuiadmin/layui/layui.js"></script>
<script>
	layui.config({
		base: 'static/layuiadmin/' //静态资源所在路径
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index', 'table', 'laypage', 'common'], function () {
		var $ = layui.$;
		var form = layui.form;
		var table = layui.table;
		var laypage = layui.laypage;
		var commonUtils = layui.common;

	<c:choose>
		<c:when test="${r"${not empty varList}"}">
		<c:if test="${r"${QX.cha == 1}"}">
		table.init('LAY-data-manage', {
			limit: ${r"${pd.pageCount}"}//注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
		});
		laypage.render({
			elem: 'laypage', //注意，这里的 test1 是 ID，不用加 # 号
			count: ${r"${pd.totalCount}"}, // 数据总数，从服务端得到
			limit: ${r"${pd.pageCount}"},
			limits: [20, 40, 60, 80, 100],
			curr: ${r"${pd.currentPage}"}, // 服务器端回传当前页,
			layout: ['prev', 'page', 'next','limit','skip'],
			jump: function(obj, first){
				if(!first){
					var pageParams = {
						currentPage: obj.curr,
						showCount: obj.limit,
						FIELD_1: $("#FIELD_1").val()
					}
					commonUtils.redirectTo('${objectNameLower}/list.do', pageParams);
				}
			}
		});
	</c:if>
		</c:when>
		</c:choose>

		//监听搜索
		form.on('submit(LAY-front-search)', function (data) {
			var field = data.field;
			//执行search
			commonUtils.redirectTo('${objectNameLower}/list.do', field);
		});

		//事件
		var active = {
			/**
			 * 删除
			 * @returns {*}
			 */
			batchdel: function () {
				var checkStatus = table.checkStatus('LAY-data-manage'), checkData = checkStatus.data; //得到选中的数据
				if (checkData.length === 0) {
					return layer.msg('请选择数据');
				}
				var dataIDs = "";
				for(var i = 0; i < checkData.length; i++){
					if(dataIDs == ""){
						dataIDs += checkData[i].${objectNameUpper}_ID;
					}else {
						dataIDs += "," + checkData[i].${objectNameUpper}_ID;
					}
				}
				layer.confirm('确定删除吗？', function (index) {
					var loadIndex = layer.load(0);
					$.ajax({
						type: "POST",
						url: '<%=basePath%>${objectNameLower}/deleteAll.do?tm=' + new Date().getTime(),
						data: {DATA_IDS:dataIDs},
						dataType:'json',
						cache: false,
						success: function(result){
							if(result.code == 0){
								layer.msg('已删除');
								window.location.reload()
							}else {
								layer.msg(result.message);
								layer.close(loadIndex);
							}
						}
					});
				});
			},

			/**
			 * 添加
			 * @returns {*}
			 */
			add: function () {
				layer.open({
					type: 2,
					title: '添加数据',
					content: '<%=basePath%>${objectNameLower}/goAdd.do',
					maxmin: true,
					area: ['80%', '90%'],
					btn: ['确定', '取消'],
					yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
						var submitID = 'LAY-front-submit';
						var submit = layero.find('iframe').contents().find('#' + submitID);
						//监听提交
						iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
							var field = data.field; //获取提交的字段
							var loadIndex = layer.load(0);
							$.ajax({
								type: "POST",
								url: '<%=basePath%>${objectNameLower}/save.do?tm=' + new Date().getTime(),
								data: field,
								dataType:'json',
								cache: false,
								success: function(result){
									if(result.code == 0){
										layer.close(index); //关闭弹层
										window.location.reload()
									}else {
										layer.msg(result.message);
										layer.close(loadIndex);
									}
								}
							});
						});

						submit.trigger('click');
					}
				});
			},

			/**
			 * 导出Excel
			 * @returns {*}
			 */
			exportExcel: function () {
				var pageParams = {
					FIELD_1: $("#FIELD_1").val()
				}
				commonUtils.redirectTo('<%=basePath%>${objectNameLower}/excel.do', pageParams);
			}
		};

		table.on('tool(LAY-data-manage)', function (e) {
			var targetData = e.data;

			// 操作栏-查看详情
			if ("view" === e.event){
				var pageParams = {
					FROM_PAGE_HREF: window.location.href,
					FROM_PAGE_TITLE: "FROM_PAGE_TITLE",
					${objectNameUpper}_ID: targetData.${objectNameUpper}_ID
				}
				commonUtils.redirectTo('<%=basePath%>${objectNameLower}/goView.do', pageParams);
			}

			// 操作栏-编辑
			if ("edit" === e.event){
				layer.open({
					type: 2,
					title: '修改数据',
					content: '<%=basePath%>${objectNameLower}/goEdit.do?${objectNameUpper}_ID=' + targetData.${objectNameUpper}_ID,
					maxmin: true,
					area: ['80%', '90%'],
					btn: ['确定', '取消'],
					yes: function (index, layero) {
						var iframeWindow = window['layui-layer-iframe' + index]
						var submitID = 'LAY-front-submit';
						var submit = layero.find('iframe').contents().find('#' + submitID);
						//监听提交
						iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
							var field = data.field; //获取提交的字段
							var loadIndex = layer.load(0);
							$.ajax({
								type: "POST",
								url: '<%=basePath%>${objectNameLower}/edit.do?tm=' + new Date().getTime(),
								data: field,
								dataType:'json',
								cache: false,
								success: function(result){
									if(result.code == 0){
										layer.close(index); //关闭弹层
										window.location.reload()
									}else {
										layer.msg(result.message);
										layer.close(loadIndex);
									}
								}
							});
						});

						submit.trigger('click');
					}
				});
			}
			// 操作栏-删除
			if ("del" === e.event){
				layer.confirm('确定删除吗？', function (index) {
					var loadIndex = layer.load(0);
					$.ajax({
						type: "POST",
						url: '<%=basePath%>${objectNameLower}/delete.do?tm=' + new Date().getTime(),
						data: {${objectNameUpper}_ID : targetData.${objectNameUpper}_ID},
						dataType:'json',
						cache: false,
						success: function(result){
							if(result.code == 0){
								layer.msg('已删除');
								window.location.reload()
							}else {
								layer.msg(result.message);
								layer.close(loadIndex);
							}
						}
					});
				});
			}
		})

		$('.layui-btn.layuiadmin-action-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});
	});
</script>
</html>