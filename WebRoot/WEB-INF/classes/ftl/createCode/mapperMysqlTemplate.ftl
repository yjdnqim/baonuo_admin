<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${objectName}Mapper">
	
	
	<!-- 新增-->
	<insert id="save" parameterType="pd">
		insert into ${tablePrefixName}_${objectNameUpper}(
	<#list fieldList as var>
			${var[0]},	
	</#list>
			${objectNameUpper}_ID
		) values (
	<#list fieldList as var>
			${r"#{"}${var[0]}${r"}"},	
	</#list>
			${r"#{"}${objectNameUpper}_ID${r"}"}
		)
	</insert>
	
	
	<!-- 删除-->
	<delete id="delete" parameterType="pd">
		update  ${tablePrefixName}_${objectNameUpper}
		set
			IS_DELETED = 1
		where 
			${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</delete>
	
	
	<!-- 修改 -->
	<update id="edit" parameterType="pd">
		update  ${tablePrefixName}_${objectNameUpper}
			set 
	<#list fieldList as var>
		<#if var[3] == "是">
				${var[0]} = ${r"#{"}${var[0]}${r"}"},
		</#if>
	</#list>
				EDIT_TIME = ${r"#{"}EDIT_TIME${r"}"},
			${objectNameUpper}_ID = ${objectNameUpper}_ID
			where 
				${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</update>
	
	
	<!-- 通过ID获取数据 -->
	<select id="findById" parameterType="pd" resultType="pd">
		select 
	<#list fieldList as var>
			${var[0]},	
	</#list>
			${objectNameUpper}_ID
		from 
			${tablePrefixName}_${objectNameUpper}
		where 
			${objectNameUpper}_ID = ${r"#{"}${objectNameUpper}_ID${r"}"}
	</select>
	
	
	<!-- 列表 -->
	<select id="datalistPage" parameterType="page" resultType="pd">
		select
		<#list fieldList as var>
				a.${var[0]},	
		</#list>
				a.${objectNameUpper}_ID
		from 
				${tablePrefixName}_${objectNameUpper} a
		where
				a.IS_DELETED = 0
		order by a.CREATE_TIME desc
	</select>
	
	<!-- 列表(全部) -->
	<select id="listAll" parameterType="pd" resultType="pd">
		select
		<#list fieldList as var>
				a.${var[0]},	
		</#list>
				a.${objectNameUpper}_ID
		from 
				${tablePrefixName}_${objectNameUpper} a
		where
				a.IS_DELETED = 0
		order by a.CREATE_TIME desc
	</select>
	
	<!-- 批量删除 -->
	<delete id="deleteAll" parameterType="String">
		update  ${tablePrefixName}_${objectNameUpper}
			set
			IS_DELETED = 1
		where 
			${objectNameUpper}_ID in
		<foreach item="item" index="index" collection="array" open="(" separator="," close=")">
                 ${r"#{item}"}
		</foreach>
	</delete>
	
</mapper>