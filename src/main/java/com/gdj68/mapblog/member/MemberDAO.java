package com.gdj68.mapblog.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gdj68.mapblog.file.FileDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.gdj68.mapblog.member.MemberDAO.";
	
	public int setJoin(MemberDTO memberDTO)throws Exception{
		return sqlSession.insert(NAMESPACE+"setJoin", memberDTO);
	}

	public MemberDTO getLogin(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"getLogin", memberDTO);
	}

	public int setMemberUpdate(MemberDTO memberDTO) {
		return sqlSession.update(NAMESPACE+"setMemberUpdate", memberDTO);
	}

	public int deleteMember(MemberDTO memberDTO) {
		return sqlSession.delete(NAMESPACE+"deleteMember", memberDTO);
	}

	public MemberDTO getIdCheck(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"getIdCheck", memberDTO);
	}

	public MemberDTO getUrlCheck(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"getUrlCheck", memberDTO);
	}

	public int setFileAdd(MemberFileDTO memberFileDTO) {
		return sqlSession.insert(NAMESPACE+"setFileAdd", memberFileDTO);
	}

	public MemberFileDTO getMemberFile(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"getMemberFile", memberDTO);
	}

	public int deleteMemberFile(FileDTO fileDTO) {
		return sqlSession.delete(NAMESPACE+"deleteMemberFile", fileDTO);
	}

	public MemberDTO getNickNameCheck(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"getNickNameCheck", memberDTO);
	}

	public MemberDTO findIdPw(MemberDTO memberDTO) {
		return sqlSession.selectOne(NAMESPACE+"findIdPw", memberDTO);
	}

	public List<MemberDTO> searchMember(MemberSearchDTO memberSearchDTO) {
		return sqlSession.selectList(NAMESPACE+"searchMember", memberSearchDTO);
	}
	
	public List<MemberDTO> searchMember2(MemberSearchDTO memberSearchDTO) {
		return sqlSession.selectList(NAMESPACE+"searchMember2", memberSearchDTO);
	}

	public List<IgnoreDTO> didYouIgnore(MemberDTO memberDTO) {
		return sqlSession.selectList(NAMESPACE+"didYouIgnore", memberDTO);
	}

	public int ignoreCancle(IgnoreDTO ignoreDTO) {
		return sqlSession.delete(NAMESPACE+"ignoreCancle", ignoreDTO);
	}

	public int ignore(IgnoreDTO ignoreDTO) {
		return sqlSession.insert(NAMESPACE+"ignore", ignoreDTO);
	}

	public int setAgree(AgreeDTO agreeDTO) {
		return sqlSession.insert(NAMESPACE+"setAgree", agreeDTO);
	}
}
