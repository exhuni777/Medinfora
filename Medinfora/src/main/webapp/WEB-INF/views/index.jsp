<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%String ctxPath = request.getContextPath();%>

<style>

	.choveritem:hover{
		cursor: pointer;
	}
	
	.icconfig{
		background-color: black !important;
    	transition: all 0.3s;
	}
	
	#carouselExampleIndicators{
		margin-bottom: 100px;
	}
	
	.sh_section{
		margin-bottom: 100px;
	}

</style>

	<%-- stylesheet --%>
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/index.css"> <%-- 기본 --%>
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/indexMedia.css"> <%-- 반응형 --%>

  <section class="sim_promo_section">
    <div class="sim_promo_section_banner">
      	<a href="https://github.com/jjoung-2j/Medinfora">
      		<img src="<%=ctxPath %>/resources/img/BannerIcon.png" class="linkgithub"/>
      	</a>
    </div>
    <div class="sim_promo_section_services">
      <h3 class="nanum-b size-n">Quick Menu</h3>
      <div class="sim_promo_section_service_links">
        <a href="<%=ctxPath%>/hpsearch/hospitalSearch.bibo">
          <div class="icon"><span>🏥</span></div>
          <span class="nanum-b size-s">병원 찾기</span>
        </a>
        <a href="<%=ctxPath %>/reserve/choiceDr.bibo">
          <div class="icon"><span>🖊️</span></div>
          <span class="nanum-b size-s">진료 예약</span>
        </a>
        <a href="<%=ctxPath %>/commu/commuList.bibo">
          <div class="icon"><span>👪</span></div>
          <span class="nanum-b size-s">커뮤니티</span>
        </a>
      </div>
      <div class="sim_promo_section_banner_notice">
        <div class="sim_promo_section_banner_notice_flexbox">
          <h1>🔔</h1>
          <h4 class="nanum-b size-n">알려드립니다</h4>
          <c:choose>
          	<c:when test="${sessionScope.loginuser.mIdx==1}">
          		<a href="<%=ctxPath%>/mypage/myreserve.bibo">더보기 →</a>
          	</c:when>
          	<c:when test="${sessionScope.loginuser.mIdx==2}">
          		<a href="<%=ctxPath%>/mypage/reserveSchedule.bibo">더보기 →</a>
          	</c:when>
          	<c:otherwise>
          		<a href="<%=ctxPath%>/notice/noticeList.bibo">더보기 →</a>
          	</c:otherwise>
          </c:choose>
        </div>
        <ul class="nanum-n size-n">
        	<c:choose>
        		<c:when test="${sessionScope.loginuser.mIdx==1}">
        			<li class="pango">
        				<c:if test="${not empty requestScope.hpname}">
		        			${requestScope.hpname}
		        			<span>${requestScope.checkin}</span>
	        			</c:if>
	        			<c:if test="${empty requestScope.hpname}">
	        				현재 진료예약이 존재하지 않습니다.
	        			</c:if>
        			</li>
        		</c:when>
        		<c:when test="${sessionScope.loginuser.mIdx==2}">
        			<li class="pango">
        				<c:if test="${not empty requestScope.patientInfo}">
		        			${requestScope.patientInfo}
		        			<span>${requestScope.checkin}</span>
	        			</c:if>
	        			<c:if test="${empty requestScope.patientInfo}">
	        				현재 진료예약이 존재하지 않습니다.
	        			</c:if>
        			</li>
        		</c:when>
        		<c:otherwise>
        			<c:if test="${not empty requestScope.ndtoList}">
	        			<li class="pango" onclick="location.href='<%=ctxPath %>/notice/view.bibo?nidx=${requestScope.ndtoList[0].nidx}'">
	        				${requestScope.ndtoList[0].title}
	        				<span>${requestScope.ndtoList[0].writeday}</span>
	        			</li>
        			</c:if>
        		</c:otherwise>
        	</c:choose>
        </ul>
      </div>
    </div>
  </section> 
<!-- 성심 작업 영역 끝 -->
 
<!-- 승혜 작업 영역 시작 --> 
<div class="sh_section section_container_info" >
  <div class="sh_subpage">
    <h1 class="sh_title nanum-b size-b">Infora</h1>

    <div class="sh_card-inner card-inner first">
		<a href="<%=ctxPath %>/status/serviceUtilization.bibo" class="sh-card">
        	<div class="sh_card-front">
          		<img src="<%=ctxPath %>/resources/img/sh_hospital.png" />
         		<h4 class="nanum-n sh_font" style="font-weight: bold;">의료서비스 이용률</h4>
        	</div>
        	<div class="sh_card-text">
          		<h4 class="sh_card-title">
          			의료서비스 이용률 
          			<i class="bi bi-arrow-right"></i>
          		</h4>
          		<p class="sh_text">
			 		특정연도의 연령별 입원 비율
			 		<br>
			 		개인 연령(15세 이상), 성별에 해당하는 의료서비스 이용률을 확인하실 수 있습니다.
          		</p>
	          	<div class="img-content">
	            	<img src="<%=ctxPath %>/resources/img/sh_hospital.png" />
	          	</div>
        	</div>
      	</a>
      	
      	<a href="<%=ctxPath %>/status/facilities.bibo" class="sh-card">
        	<div class="sh_card-front">
          		<img src="<%=ctxPath %>/resources/img/hospitalisationPatient.png" />
         		<h4 class="nanum-n sh_font" style="font-weight: bold;">시도별 일반입원실<br>시설 현황</h4>
        	</div>
        	<div class="sh_card-text">
          		<h4  class="sh_card-title">
          			시도별 일반입원실 시설 현황 
          			<i class="bi bi-arrow-right"></i>
          		</h4>
          		<p class="sh_text">
           			시도별 일반입원실 시설 현황
           			<br>
           			실거주 지역 보건의료기관 현황을 확인하실 수 있습니다.
         		</p>
          		<div class="img-content">
            		<img src="<%=ctxPath %>/resources/img/hospitalisationPatient.png" />
          		</div>
        	</div>
      	</a>
      	
      	<a href="<%=ctxPath %>/status/cancerincidence.bibo" class="sh-card">
        	<div class="sh_card-front">
          		<img src="<%=ctxPath %>/resources/img/hospitalisation_icon.png" />
          		<h4 class="nanum-n sh_font" style="font-weight: bold;">연도별 암발생률</h4>
        	</div>
        	<div class="sh_card-text">
	          	<h4 class="sh_card-title">
	          		연도별 암발생률 
	          		<i class="bi bi-arrow-right"></i>
	          	</h4>
	          	<p class="sh_text">
			 		연도별, 종류별, 연령대별<br>암발생현황
			 		검색 결과를 통해 나온 데이터를 다운받으실 수 있습니다.
	          	</p>
	          	<div class="img-content">
	            	<img src="<%=ctxPath %>/resources/img/hospitalisation_icon.png" />
	          	</div>
	        </div>
      	</a>
      	
      <a href="<%=ctxPath %>/news/main.bibo" class="sh-card">
        	<div class="sh_card-front">
	          	<img src="<%=ctxPath %>/resources/img/sh_tongae.png" />
	          	<h4 class="nanum-n sh_font" style="font-weight: bold;">의료뉴스</h4>
        	</div>
        	<div class="sh_card-text">
          		<h4 class="sh_card-title">
          			의료뉴스
          			 <i class="bi bi-arrow-right"></i>
          		</h4>
          		<p class="sh_text">
					전문적인 의료뉴스의 정보를 확인하실 수 있습니다.
          		</p>
          		<div class="img-content">
            		<img src="<%=ctxPath %>/resources/img/sh_tongae.png" />
          		</div>
        	</div>
      	</a>
    </div> 
</div>
    
    <div id="carouselExampleIndicators" class="sh_car carousel slide" data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="plz carousel-item active gohpsearch">
            	<img src="<%=ctxPath %>/resources/img/sh_hospital.png" class="d-block w-25 img-fluid mx-auto choveritem" alt="...">
          	</div>
          	<div class="carousel-item">
              	<img src="<%=ctxPath %>/resources/img/sh_medi.png" class="d-block w-25 img-fluid mx-auto choveritem" alt="...">
          	</div>
          	<div class="carousel-item">
              	<img src="<%=ctxPath %>/resources/img/sh_emer.png" class="d-block w-25 img-fluid mx-auto choveritem" alt="...">
            </div>
          	<div class="carousel-item">
            	<img src="<%=ctxPath %>/resources/img/sh_findcl.png" class="d-block w-25 img-fluid mx-auto choveritem" alt="...">
          	</div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
          <span class="carousel-control-prev-icon icconfig" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
          <span class="carousel-control-next-icon icconfig" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
      </button>
  </div>

    </div>

<!--  승혜 작업 영역 끝 --> 
<!-- 동혁 작업 영역 시작 -->
<div id="FAQ" class="mb-5 sizearr">
  <h2 class="nanum-eb size-n mb-4">FAQ & 묻고 답하기</h2>
  <c:set var="question"  value="${requestScope.qdtoList}" />
  <c:set var="answer"  value="${requestScope.answerList}" />
    <div class="accordion" id="accordionExample">
      <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
              <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                  <span class="nanum-b">Q1.</span>&nbsp;
                  <span class="nanum-n">${question[0].title}</span>
              </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                  <i class="fa-regular fa-hand-point-right"></i>
                  <span class="nanum-b">A.&nbsp;${answer[0]}</span>
              </div>
          </div>
      </div>
      <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                  <span class="nanum-b">Q2.</span>&nbsp;
                  <span class="nanum-n">${question[1].title}</span>
              </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                  <i class="fa-regular fa-hand-point-right"></i>
                  <span class="nanum-b">A.&nbsp;${answer[1]}</span>
              </div>
          </div>
      </div>
      <div class="accordion-item">
          <h2 class="accordion-header" id="headingThree">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                  <span class="nanum-b">Q3.</span>&nbsp;
                  <span class="nanum-n">${question[2].title}</span>
              </button>
          </h2>
          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                  <i class="fa-regular fa-hand-point-right"></i>
                  <span class="nanum-b">A.&nbsp;${answer[2]}</span>
              </div>
          </div>
      </div>
    </div>
  <div class="lookupdiv">
    <h3 class="nanum-n nanum-b lookupfnq" onclick='location.href="<%=ctxPath%>/questionList.bibo"'>더보기</h3>
  </div>
</div>
<!-- 동혁 작업 영역 끝 -->

<!-- 혜정 작업 영역 시작 -->
<session class="hj_section row my-5 py-3 justify-content-center sizearr">
  <div class="hj_section_notice col-lg-2 mb-3">
    <div>
      <h2 class="nanum-b hj_h2_flex">
        공지사항&nbsp;
        <a href= "<%=ctxPath%>/notice/noticeList.bibo" class="hj_notice_plusicon">
          <i class="fa-solid fa-plus hj_plusicon"></i>
        </a>
      </h2>
      <p class="nanum-n size-s">Mediinfora의&nbsp;
        <span>최근소식을</span>&nbsp;
        <span>전해드립니다.</span>
      </p>
    </div>
    <a href= "<%=ctxPath%>/notice/noticeList.bibo" class="hj_notice_plus nanum-n size-s">더 많은 소식 보기
        <i class="fa-solid fa-plus hj_plusicon"></i>
    </a>
  </div>
  <div class="hj_section_noticelist row row-cols-1 row-cols-md-3 col-lg-10">
  
	<c:forEach var="ndto" items="${requestScope.ndtoList}">
		
		<div class="col hj_cardMb">
			<div class="hj_noticeitem card">
				<div class="noticeurl" style="display: none; margin: 0;"><%=ctxPath %>/notice/view.bibo?nidx=${ndto.nidx}</div>
				<div class="card-body">
		            <h5 class="card-title nanum-b">
	            		${ndto.title}
		        	</h5>
            		<p class="card-text hj_notice_content nanum-n">
            			${ndto.content}
            		</p>
            <span>${ndto.writeday}</span>
          </div>
      </div>
    </div>
	</c:forEach>
    
  </div>
</session>