<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/commu/commuView.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/js/commu/commuView.js"></script>

<div class="commu-container">

    <div class="title_area">
        <span class="nanum-eb">${cbdto.title}</span>
        <span class="nanum-eb">🕛${cbdto.writeday}</span>
    </div>

    <div class="idDayCnt_erea">
        <span class="commu-userid">${cbdto.userid}</span>
        <div class="idDayCnt_erea_right">
	        <span class="commu-date">수정일자: ${cbdto.updateday}</span>
	        <c:if test="${cbdto.writeday != cbdto.updateday}">
	        </c:if>
	        <span class="commu-viewcount">👁️‍🗨️${cbdto.viewcnt}</span>
        </div>
    </div>
     <div>
        <div class="commu-info2">
			<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid == requestScope.cbdto.userid}">
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/commu/commuEdit.bibo?cidx=${requestScope.cbdto.cidx}&currentShowPageNo=${requestScope.currentShowPageNo}&category=${requestScope.category}&type=${requestScope.type}&word=${requestScope.word}'">
					글수정하기
				</button>
				<button type="button" class="btn btn-secondary btn-sm" onclick="del('${requestScope.cbdto.cidx}')">삭제하기</button>
			</c:if>        
        </div>
         <div class="commu-attachment">
         	<c:if test="${not empty requestScope.fileList}">
                <span class="attach-file">
                    <img src="<%= ctxPath %>/resources/img/sh_attach.png" style="width: 20px; height: 20px;">
                    	첨부파일 : 
                </span>
				<c:forEach var="cfdto" items="${requestScope.fileList}" varStatus="status">
                <a href="<%= ctxPath %>/commu/download.bibo?cidx=${cbdto.cidx}&originFilename=${cfdto.orgname}&filename=${cfdto.fileName}" class="attachment-filename">
				    ${cfdto.orgname}<c:if test="${!status.last}">,</c:if>                
                </a>
				</c:forEach>
            </c:if>
        </div>
    </div>
    
    <div class="nanum-n commu-content" style="height: auto;">
        <p>${cbdto.content}</p>
    </div>
    
	<div class="button-list-area">
	<!-- 목록으로 돌아가기 버튼 -->
		<button type="button" class="commu-button nanum-b" 
		    onclick="location.href='<%= ctxPath %>/commu/commuList.bibo?currentPageNo=${requestScope.currentShowPageNo}&category=${requestScope.category}&type=${requestScope.type}&word=${requestScope.word}'">
		    목록
		</button>
		<button type="button" class="commu-button nanum-b" onclick="location.href='<%= ctxPath %>${requestScope.goBackURL}'">🌟추천</button>
		<button type="button" class="commu-button nanum-b" onclick="location.href='<%= ctxPath %>${requestScope.goBackURL}'">🔖북마크 </button>
	</div>
    <!-- 댓글이 보여짐 , 대댓글 까지만 되고 대댓글 한 경우 아이디가 @아이디 되도록? -->
    <ul id="commentDisplay"></ul>

	<div class="pagination" id="rpageNumber"></div>
	<%-- 댓글쓰기 --%>
	
	<c:if test="${not empty sessionScope.loginuser}">
		<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
			<div id="commentArea">
				<textarea class="form-control" name="content"
					placeholder="댓글 내용을 입력하세요." maxlength="150"></textarea>
				<div style="text-align: right;">
					<button class="nanum-b commu-button" type="button" onclick="goAddWrite()">등록</button>
					<button class="nanum-b commu-button" type="button" onclick="answercanle()">취소</button>
				</div>
				<%--
				<button type="button" class="btn btn-secondary btn-sm mr-3"
				 onclick="javascript:location.href='<%= ctxPath%>/commu/addComment.bibo?groupno=${requestScope.boardvo.groupno}&fk_seq=${requestScope.boardvo.seq}&depthno=${requestScope.boardvo.depthno}'"
				>
					답댓글쓰기
				</button>
				 댓글쓰기 --%>
			</div>
		</form>
	</c:if>
</div>

<input type="hidden" value="${requestScope.cbdto.cidx}" name="cidx" id="cidx" /> <%-- 원글번호 --%>
<input type="hidden" value="${sessionScope.loginuser.userid}" name="userid" id="loginuserid"/>  <%-- 로그인하고있는내아이디 --%>
<input type="hidden" value="${sessionScope.cbdto.commentCount}" name="commentCount" id="commentCount" />  <%-- 댓글여부 --%>
	


<%--
<div id="deleteModal" class="modal modal-dialog">
    <div class="modal-content nanum-n">
        <span class="close nanum-n" style="text-align: right;">&times;</span>
        <h2>정말로 글을 삭제하시겠습니까?</h2>
        <form name="delFrm" style=" display: inline-block; text-align: center;">
            <div>
          		<input type="hidden" name="cidx" value="${cbdto.cidx}" />
	            <div class="nanum-n commu-buttons">
	               <button type="button" class="btn btn-secondary" id="btnDelete">삭제</button>
	               <button type="button" class="btn btn-secondary" id="btnCancel">취소</button>
	            </div>
            </div>
        </form>
    </div>
</div>
--%>


</body>