package com.gdj68.mapblog.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gdj68.mapblog.file.FileDTO;
import com.gdj68.mapblog.util.FileManager;
import com.gdj68.mapblog.util.Pager;


@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private FileManager fileManager;
	
	public int setJoin(MemberDTO memberDTO, MultipartFile photo, HttpSession session) throws Exception{
		
		String path="/resources/upload/member/";
		int result = memberDAO.setJoin(memberDTO);
		
		String fileName = fileManager.fileSave(path, session, photo);
		MemberFileDTO memberFileDTO = new MemberFileDTO();
		memberFileDTO.setOriginalName(photo.getOriginalFilename());
		memberFileDTO.setFileName(fileName);
		memberFileDTO.setId(memberDTO.getId());
		result = memberDAO.setFileAdd(memberFileDTO);
		
		return result;
	}

	public MemberDTO getLogin(MemberDTO memberDTO) {
		return memberDAO.getLogin(memberDTO);
	}

	public int setMemberUpdate(MemberDTO memberDTO) {
		return memberDAO.setMemberUpdate(memberDTO);
	}

	public int deleteMember(MemberDTO memberDTO) {
		return memberDAO.deleteMember(memberDTO); 
	}

	public MemberDTO getIdCheck(MemberDTO memberDTO) {
		return memberDAO.getIdCheck(memberDTO);
	}

	public MemberDTO getUrlCheck(MemberDTO memberDTO) {
		return memberDAO.getUrlCheck(memberDTO);
	}

	public MemberFileDTO getMemberFile(MemberDTO memberDTO) {
		return memberDAO.getMemberFile(memberDTO);
	}

	public MemberFileDTO setUpdateImg(MultipartFile photo, MemberFileDTO memberFileDTO, FileDTO fileDTO, HttpSession session) throws Exception {
		String path="/resources/upload/member/";
		boolean deleteResult = fileManager.fileDelete(fileDTO, path, session);
		
		if(deleteResult){
			memberDAO.deleteMemberFile(fileDTO);
			// 여기 까지 ok
			
			String fileName = fileManager.fileSave(path, session, photo);
			MemberFileDTO memberFileDTO2 = new MemberFileDTO();
			memberFileDTO2.setOriginalName(photo.getOriginalFilename());
			memberFileDTO2.setFileName(fileName);
			memberFileDTO2.setId(memberFileDTO.getId());
			int result = memberDAO.setFileAdd(memberFileDTO2);
			return memberFileDTO2;
		}
		return null;
	}

	public MemberDTO getNickNameCheck(MemberDTO memberDTO) {
		return memberDAO.getNickNameCheck(memberDTO);
	}

	public MemberDTO findIdPw(MemberDTO memberDTO) {
		return memberDAO.findIdPw(memberDTO);
	}

	public List<MemberDTO> searchMember(MemberSearchDTO memberSearchDTO) {
		return memberDAO.searchMember(memberSearchDTO);	
	}
	
	public List<MemberDTO> searchMember2(MemberSearchDTO memberSearchDTO) {
		return memberDAO.searchMember2(memberSearchDTO);	
	}
	

	public List<IgnoreDTO> didYouIgnore(MemberDTO memberDTO) {
		return memberDAO.didYouIgnore(memberDTO);	
	}

	public int ignoreCancle(IgnoreDTO ignoreDTO) {
		return memberDAO.ignoreCancle(ignoreDTO);
	}

	public int ignore(IgnoreDTO ignoreDTO) {
		return memberDAO.ignore(ignoreDTO);
	}

	public int setAgree(AgreeDTO agreeDTO) {
		return memberDAO.setAgree(agreeDTO);
	}
}
