package com.spring.app.commu.model;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.domain.HospitalDTO;
import com.spring.app.domain.commu.CommuBoardDTO;
import com.spring.app.domain.commu.CommuFilesDTO;


@Mapper
public interface CommuDAO {

	String getSeqCommu();

	int add(CommuBoardDTO cbdto);

	void add_File(CommuFilesDTO cfdto);

	List<CommuBoardDTO> getCommuBoardList(Map<String, String> paraMap);

	int getCBListTotalCount(Map<String, String> paraMap);

	List<String> getfileSeqList();

	CommuBoardDTO getCommuDetail(String cidx);
	
	int viewCntIncrease(String cidx);

	List<CommuFilesDTO> getAttachfiles(String cidx);

	CommuBoardDTO getCommuDetail_no_increase_viewCnt(String cidx);
	



}
