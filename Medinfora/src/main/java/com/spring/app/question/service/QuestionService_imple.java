package com.spring.app.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.domain.AddQnADTO;
import com.spring.app.domain.MediADTO;
import com.spring.app.domain.MediQDTO;
import com.spring.app.domain.MemberDTO;
import com.spring.app.question.model.QuestionDAO;

@Service
public class QuestionService_imple implements QuestionService {
	
	@Autowired
	private QuestionDAO qdao;
	
	@Autowired
	private AES256 aes;
	
	// 질문등록
	@Override
	public int questionWriteEnd(MediQDTO qdto) {
		int n = qdao.questionWriteEnd(qdto);
		return n;
	}
	
	// 전체 수(검색포함)
	@Override
	public int totalquestion(Map<String, String> paraMap) {
		int totalquestion = qdao.totalquestion(paraMap);
		return totalquestion;
	}
	
	
	// 전체 리스트(검색포함?)
	@Override
	public List<MediQDTO> totalquestionList(Map<String, String> paraMap) {
		List<MediQDTO> qList = qdao.totalquestionList(paraMap);
		return qList;
	}
	
	// 글 조회
	@Override
	public MediQDTO questionView(int qidx) {
		MediQDTO qdto = null;
		
		qdto = qdao.questionView(qidx);
		
		String name = qdao.getwriterName(qdto.getUserid());
		qdto.setName(name);
		
		return qdto;
	}
	
	// 답변 조회
	@Override
	public List<MediADTO> answerView(int qidx) {
		List<MediADTO> adtoList = null;
		
		adtoList = qdao.answerView(qidx);
		
		// 가정은 다음과 같다.
		// 먼저 답변리스트를 받아온 후 답변 수 만큼 포문을 돌려서 답변에 추가질답이 있는지 확인 후 
		// 있다면, 추가질문을 받아온 후 셋팅해준다.
		try {
			if(adtoList.size() > 0 ) {
				
				for(int i=0; i<adtoList.size(); i++) {
					MediADTO adto = adtoList.get(i);
					
					List<AddQnADTO> addqnadtoList = qdao.addquestionView(adto.getAidx());

					adto.setAddqnadtoList(addqnadtoList);
					
					List<MemberDTO> memberList = qdao.memberView(adto.getUserid());
					
					for(MemberDTO member : memberList) {
						member.setMobile(aes.decrypt(member.getMobile()));
					}
					
					// 병원정보 넣어줌
					adto.setMemberList(memberList);
					
					// 진료과목 구해오기
					List<String> classList = qdao.getClassSize(adto.getUserid());
					
					String classname = "";
					for(String code : classList) {
						String classcode = qdao.getClasscode(code);
						// System.out.println(classcode);
						
						classname += classcode+"/";
					}
					
					classname = classname.substring(0, classname.length()-1);
					
					adto.setClasscode(classname);
					
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("서비스에서 널포인트 발생");
		}
		return adtoList;
	}
	
	
	@Override
	public int answerWrite(MediADTO mdto) {
		
		int result = 0;
		
		// 답변등록
		result = qdao.answerWrite(mdto);
		
		// 질문답변수 증가
		result = qdao.qacountplus(mdto);
		
		return result;
	}
	
	
	@Override
	public int addqaUpload(AddQnADTO addqadto) {
		
		String qnastatus = addqadto.getQnastatus();
		
		int result = qdao.addqaUpload(addqadto);
		
		if("0".equals(qnastatus)) {
			qdao.updateqnanum(addqadto.getAidx());
		}
		
		return result;
	}
	
	
	@Override
	public int addqaUpdate(AddQnADTO addqadto) {
		
		int result = qdao.addqaUpdate(addqadto);
		return result;
	}

	@Override
	public int addqaDelete(AddQnADTO addqadto) {
		int result = qdao.addqaDelete(addqadto);
		return result;
	}
	
	
	@Override
	public int answerUpdate(MediADTO adto) {
		int result = qdao.answerUpdate(adto);
		return result;
	}

	@Override
	public int answerDelete(MediADTO adto) {
		int result = qdao.answerDelete(adto);
		return result;
	}

	@Override
	public int questionDelete(String qdto) {
		int result = qdao.questionDelete(qdto);
		return result;
	}

	@Override
	public int questionUpdate(MediQDTO qdto) {
		int result = 0;
		
		result = qdao.questionUpdate(qdto);
		
		return result;
	}
	
	
	@Override
	public void viewCountIncrease(int qidx) {
		qdao.viewCountIncrease(qidx);
	}

	@Override
	public List<MediQDTO> getQuestion() {
		List<MediQDTO> qdtoList = qdao.qdtoFAQ();
		return qdtoList;
	}

	@Override
	public String getAnswer(String qidx) {
		String answer = qdao.answerFAQ(qidx);
		return answer;
	}
	
	
	
	
	
	

}
