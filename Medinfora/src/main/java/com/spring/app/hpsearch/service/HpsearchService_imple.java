package com.spring.app.hpsearch.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.domain.HospitalDTO;
import com.spring.app.hpsearch.model.HpsearchDAO;
import com.spring.app.main.model.MainDAO;

@Service
public class HpsearchService_imple implements HpsearchService {
	
	//의존객체 주입 DI ----- 
	@Autowired
	private HpsearchDAO hsdao;

	@Override
	public List<HospitalDTO> getHospitalList(Map<String, String> paraMap) {
		return hsdao.getHospitalList(paraMap);
	}

	@Override
	public int getHpListTotalCount(Map<String, String> paraMap) {
		return hsdao.getHpListTotalCount(paraMap);
	}

	@Override
	public HospitalDTO getHpDetail(String hidx) {
		return hsdao.getHpDetail(hidx);
	}

	//시를 넣어서 도 불러오기
	@Override
	public List<String> putSiGetdo(String local) {
		return hsdao.putSiGetdo(local);
	}

	@Override
	public int holidatCheck(String currentDate_str) {
		// TODO Auto-generated method stub
		return hsdao.holidatCheck(currentDate_str);
	}

	@Override
	public List<Map<String, String>> getChartPercentage(Map<String, String> paraMap) {
		return hsdao.getChartPercentage(paraMap);
	}

}
