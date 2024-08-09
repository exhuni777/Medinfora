<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style>
	.sidebar_list_title{
		cursor: pointer;
	}
</style>

   <div id="info_sidebar">
       <div class="sidebar_title">
           <i class="fa-regular fa-compass"></i>&nbsp;메뉴
       </div>
       <hr class="sidebar_divideline">
       <div class="sidebar_list">
           <div class="sidebar_list_title" onclick="location.href='<%=ctxPath%>/status/serviceUtilization.bibo'">
 				의료서비스 이용률
           </div>
           <div class="sidebar_list_title" onclick="location.href='<%=ctxPath%>/status/facilities.bibo'">
 				시도별 일반 입원실 시설 현황
           </div>
           <div class="sidebar_list_title" onclick="location.href='<%=ctxPath%>/status/cancerincidence.bibo'">
 				연도별 암발생자현황
           </div>
       </div>
   </div>