package com.spring.app.hpsearch.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.spring.app.domain.HospitalDTO;

public interface HpsearchService {

	List<HospitalDTO> getHospitalList(Map<String, String> paraMap);

	int getHpListTotalCount(Map<String, String> paraMap);

	HospitalDTO getHpDetail(String hidx);

	List<String> putSiGetdo(String local);

	int holidatCheck(String currentDate_str);

	List<Map<String, String>> getChartPercentage(Map<String, String> paraMap);
	
}
