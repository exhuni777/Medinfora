package com.spring.app.hpsearch.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.*;
import com.spring.app.hpsearch.service.HpsearchService;

@Controller
public class HpsearchController {

	// 의존객체주입
	@Autowired
	private HpsearchService service;

	@GetMapping("/hpsearch/hospitalSearch.bibo")
	public ModelAndView medistatistic(ModelAndView mav) {
		mav.setViewName("hospitalSearch/hospitalSearch.tiles");
		return mav;
	}

	// 검색 메소드
	@ResponseBody
	@GetMapping(value = "/hpsearch/hpsearchAdd.bibo", produces = "text/plain;charset=UTF-8")
	public String hpsearchAdd(HttpServletRequest request) {

		String addr = request.getParameter("addr"); // 경기도 광명시
		String country = request.getParameter("country"); // 동
		String classcode = request.getParameter("classcode"); // D004
		String agency = request.getParameter("agency"); // 의원
		String hpname = request.getParameter("hpname"); // 병원이름
		String checkStatus = request.getParameter("checkStatus"); 
		String currentShowPageNo = request.getParameter("currentShowPageNo");

		if (currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		int sizePerPage = 10;// 한 페이지당 5개의 병원

		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
		int endRno = startRno + sizePerPage - 1;

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("addr", addr);
		paraMap.put("country", country);
		paraMap.put("classcode", classcode);
		paraMap.put("agency", agency);
		paraMap.put("hpname", hpname);
		paraMap.put("checkStatus", checkStatus);
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		if (hpname == null) {
			hpname = "";
		}
		if (hpname != null) {
			hpname = hpname.trim();
		}

		List<HospitalDTO> hospitalList = service.getHospitalList(paraMap);
		int totalCount = service.getHpListTotalCount(paraMap); // 전체개수
		int totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		// 진료상태 구하기
		LocalDate currentDate = LocalDate.now();

		DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
		String str_dayOfWeek = dayOfWeek.getDisplayName(TextStyle.FULL, Locale.KOREAN);

		LocalTime currentTime = LocalTime.now();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");

		int int_currentTime = Integer.parseInt(currentTime.format(formatter));
		String currentDate_str = String.valueOf(currentDate); 

		int n = service.holidatCheck(currentDate_str);

		if (n > 0) {
			str_dayOfWeek = "공휴일";
		}

		JSONArray jsonArr = new JSONArray();

		String endtime1, endtime2, endtime3, endtime4, endtime5, endtime6, endtime7, endtime8, starttime1, starttime2,
				starttime3, starttime4, starttime5, starttime6, starttime7, starttime8;

		String status = "";

		if (hospitalList != null) {
			for (HospitalDTO hpdto : hospitalList) {
				endtime1 = hpdto.getEndtime1();
				endtime2 = hpdto.getEndtime2();
				endtime3 = hpdto.getEndtime3();
				endtime4 = hpdto.getEndtime4();
				endtime5 = hpdto.getEndtime5();
				endtime6 = hpdto.getEndtime6();
				endtime7 = hpdto.getEndtime7();
				endtime8 = hpdto.getEndtime8();

				starttime1 = hpdto.getStarttime1();
				starttime2 = hpdto.getStarttime2();
				starttime3 = hpdto.getStarttime3();
				starttime4 = hpdto.getStarttime4();
				starttime5 = hpdto.getStarttime5();
				starttime6 = hpdto.getStarttime6();
				starttime7 = hpdto.getStarttime7();
				starttime8 = hpdto.getStarttime8();

				if ("공휴일".equals(str_dayOfWeek) && starttime8.equals(" ") && endtime8.equals(" ")) {
					status = "휴진";
				} else {
					try {
						if ("월요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime1) && !" ".equals(endtime1)
									&& Integer.parseInt(starttime1) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime1)) {
								status = "진료중";
							} else if (starttime1.equals(" ") && endtime1.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}

						if ("화요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime2) && !" ".equals(endtime2)
									&& Integer.parseInt(starttime2) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime2)) {
								status = "진료중";
							} else if (starttime2.equals(" ") && endtime2.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}

						if ("수요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime3) && !" ".equals(endtime3)
									&& Integer.parseInt(starttime3) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime3)) {
								status = "진료중";
							} else if (starttime3.equals(" ") && endtime3.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}

						if ("목요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime4) && !" ".equals(endtime4)
									&& Integer.parseInt(starttime4) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime4)) {
								status = "진료중";
							} else if (starttime4.equals(" ") && endtime4.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}

						if ("금요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime5) && !" ".equals(endtime5)
									&& Integer.parseInt(starttime5) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime5)) {
								status = "진료중";
							} else if (starttime5.equals(" ") && endtime5.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}
						if ("토요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime6) && !" ".equals(endtime6)
									&& Integer.parseInt(starttime6) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime6)) {
								status = "진료중";
							} else if (starttime6.equals(" ") && endtime6.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}
						if ("일요일".equals(str_dayOfWeek)) {
							if (!" ".equals(starttime7) && !" ".equals(endtime7)
									&& Integer.parseInt(starttime7) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime7)) {
								status = "진료중";
							} else if (starttime7.equals(" ") && endtime7.equals(" ")) {
								status = "휴진";
							} else {
								status = "진료종료";
							}
						}
						if ("공휴일".equals(str_dayOfWeek) && (!" ".equals(starttime8)) && (!" ".equals(endtime8))) {
							if (Integer.parseInt(starttime8) < int_currentTime
									&& int_currentTime < Integer.parseInt(endtime8)) {
								status = "진료중";
							} else {
								status = "진료종료";
							}
						}
					} catch (NumberFormatException e) {
						e.printStackTrace();
					}
				}
				
				//만약 체크박스상태(checkStatus)가 진료중인데   현재 병원의 상태 (status)가 "진료중"이 아닌 경우, 
				//해당 병원 정보를 결과 목록에서 제외
				if ("진료중".equals(checkStatus) && !"진료중".equals(status)) {
					continue; 
				}

				JSONObject jsonObj = new JSONObject(); // {}

				jsonObj.put("hidx", hpdto.getHidx());
				jsonObj.put("hptel", hpdto.getHptel());
				jsonObj.put("hpname", hpdto.getHpname());
				jsonObj.put("hpaddr", hpdto.getHpaddr());
				jsonObj.put("classname", hpdto.getClassname());
				jsonObj.put("wgs84lon", hpdto.getWgs84lon());
				jsonObj.put("wgs84lat", hpdto.getWgs84lat());
				jsonObj.put("status", status);
				jsonObj.put("totalCount", totalCount);
				jsonObj.put("totalPage", totalPage);
				
				
				jsonArr.put(jsonObj);
			} // end of for---------------------------
		}


		
		
		
		
		
	     
		return jsonArr.toString();

	}

	// 상세검색 메소드
	@ResponseBody
	@GetMapping(value = "/hpsearch/hpsearchDetail.bibo", produces = "text/plain;charset=UTF-8")
	public String hpsearchDetail(HttpServletRequest request) {

		String hidx = request.getParameter("hidx");

		HospitalDTO hpdetail = null;
		if (hidx != null) {
			hpdetail = service.getHpDetail(hidx);
		}

		String[] startTimes = new String[8];
		String[] endTimes = new String[8];
		String[] timeStrings = new String[8];

		startTimes[0] = hpdetail.getStarttime1();
		startTimes[1] = hpdetail.getStarttime2();
		startTimes[2] = hpdetail.getStarttime3();
		startTimes[3] = hpdetail.getStarttime4();
		startTimes[4] = hpdetail.getStarttime5();
		startTimes[5] = hpdetail.getStarttime6();
		startTimes[6] = hpdetail.getStarttime7();
		startTimes[7] = hpdetail.getStarttime8();

		endTimes[0] = hpdetail.getEndtime1();
		endTimes[1] = hpdetail.getEndtime2();
		endTimes[2] = hpdetail.getEndtime3();
		endTimes[3] = hpdetail.getEndtime4();
		endTimes[4] = hpdetail.getEndtime5();
		endTimes[5] = hpdetail.getEndtime6();
		endTimes[6] = hpdetail.getEndtime7();
		endTimes[7] = hpdetail.getEndtime8();

		for (int i = 0; i < startTimes.length; i++) {
			if (!startTimes[i].equals(" ") && !endTimes[i].equals(" ")) {
				startTimes[i] = startTimes[i].substring(0, 2) + "시 " + startTimes[i].substring(2, 4) + "분";
				endTimes[i] = endTimes[i].substring(0, 2) + "시 " + endTimes[i].substring(2, 4) + "분";
				timeStrings[i] = startTimes[i] + " ~ " + endTimes[i];
			} else {
				timeStrings[i] = "휴진";
			}
		}

		String monTime = timeStrings[0];
		String tueTime = timeStrings[1];
		String wedTime = timeStrings[2];
		String thuTime = timeStrings[3];
		String friTime = timeStrings[4];
		String satTime = timeStrings[5];
		String sunTime = timeStrings[6];
		String holyTime = timeStrings[7];

		JSONObject jsonObj = new JSONObject(); // {}
		if (hpdetail != null) {
			jsonObj.put("hidx", hpdetail.getHidx());
			jsonObj.put("hpname", hpdetail.getHpname());
			jsonObj.put("hpaddr", hpdetail.getHpaddr());
			jsonObj.put("hptel", hpdetail.getHptel());
			jsonObj.put("classname", hpdetail.getClassname());
			jsonObj.put("agency", hpdetail.getAgency());
			jsonObj.put("time1", monTime);
			jsonObj.put("time2", tueTime);
			jsonObj.put("time3", wedTime);
			jsonObj.put("time4", thuTime);
			jsonObj.put("time5", friTime);
			jsonObj.put("time6", satTime);
			jsonObj.put("time7", sunTime);
			jsonObj.put("time8", holyTime);
		}
		return jsonObj.toString();
	}

	// 도를 넣으면 시를 반환하는 메소드
	@ResponseBody
	@RequestMapping(value = "putSiGetdo.bibo", produces = "text/plain;charset=UTF-8")
	public String putSiGetdo(HttpServletRequest request) {

		String local = request.getParameter("local");

		List<String> sidoList = service.putSiGetdo(local);

		if (sidoList == null) {
			sidoList = new ArrayList<>(); // 만약 null이면 빈 리스트로 초기화
		}
		JSONArray jsonArr = new JSONArray();

		for (String sido : sidoList) {
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("sido", sido);
			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();

	}// end of public String getlocalinfo(HttpServletRequest request)


	// 통계 관련 메소드
	@ResponseBody
	@GetMapping(value = "/hpsearch/getChartPercentage.bibo", produces = "text/plain;charset=UTF-8")
	public String getChartPercentage(HttpServletRequest request) {

		String addr = request.getParameter("addr"); // 경기도 광명시
		String country = request.getParameter("country"); // 동
		String classcode = request.getParameter("classcode"); // D004
		String agency = request.getParameter("agency"); // 의원
		String hpname = request.getParameter("hpname"); // 병원이름

	    Map<String, String> paraMap = new HashMap<>();
		paraMap.put("addr", addr);
		paraMap.put("country", country);
		paraMap.put("classcode", classcode);
		paraMap.put("agency", agency);
		paraMap.put("hpname", hpname);
		
		if (hpname == null) {
			hpname = "";
		}
		
		if (hpname != null) {
			hpname = hpname.trim();
		}
	   
		List<Map<String, String>> chartPercentList = service.getChartPercentage(paraMap);
		JSONArray jsonArr = new JSONArray();
		
		if (chartPercentList != null) {
			for (Map<String, String> chart : chartPercentList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("CLASSNAME", chart.get("CLASSNAME"));
				jsonObj.put("CNT", chart.get("CNT"));
				jsonObj.put("PERCNTAGE", chart.get("PERCNTAGE"));
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}

}
