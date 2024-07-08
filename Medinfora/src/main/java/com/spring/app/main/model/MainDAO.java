package com.spring.app.main.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.ClasscodeDTO;
import com.spring.app.domain.HolidayVO;
import com.spring.app.domain.HospitalDTO;
import com.spring.app.domain.KoreaAreaVO;
import com.spring.app.domain.MemberDTO;

public interface MainDAO {

	// DAO 테스트용 메소드
	public String daotest();
	
	// 병원정보 API 입력용 메소드 
	public int hpApiInputer(HospitalDTO hospitalDTO);

	// 대한민국 행정구역정보 입력용
	public int areaInputer(KoreaAreaVO koreaAreaVO);

	// 회원가입(중복체크)
	public MemberDTO isExistCheck(Map<String, String> paraMap);
	
	// 회원가입(병원찾기 자동검색)
	public List<String> autoWord(Map<String, String> paraMap);
	
	// 회원가입(병원찾기 검색)
	public List<HospitalDTO> hpSearch(Map<String, String> paraMap);
	
	// 회원가입(병원찾기 병원정보 입력)
	public HospitalDTO searchMedicalEnd(Map<String, String> paraMap);

	// 로그인 유저 정보 가져오기
	public MemberDTO getLoginuser(Map<String, String> paraMap);

	// 회원코드 변경 (휴먼처리)
	public void updatemIdx(String userid, String idx);

	// 로그인 유저 ip 기록
	public void insert_log(Map<String, String> paraMap);

	// 행정구역 리스트 추출
	public List<String> getcityinfo();

	// 시/군/구 리스트 추출
	public List<String> getlocalinfo(String city);

	// 읍/면/동 리스트 추출
	public List<String> getcountryinfo(KoreaAreaVO inputareavo);

	// 병원 진료과 리스트 추출
	public List<ClasscodeDTO> getclasscode();
	
	// 회원가입(병원찾기 병원리스트(전체개수))
	public int totalhospital(Map<String, String> paraMap);

	// 공휴일 입력용
	public int holidayInputer(HolidayVO holidayVO);
	
	
	
	


	

	
	
}
