package com.gdj68.mapblog.follow;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj68.mapblog.member.MemberDTO;

@Service
public class FollowService {
	@Autowired
	private FollowDAO followDAO;
	
	public List<FollowDTO> selectFollowList(FollowDTO followDTO,HttpSession session) throws Exception{
		
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		return followDAO.selectFollowList(followDTO);
	}
	
	public long selectFollowTotal(FollowDTO followDTO, HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		return followDAO.selectfFollowTotal(followDTO);
	}
	public long selectFollowerTotal(FollowDTO followDTO, HttpSession session) throws Exception{
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		return followDAO.selectFollowerTotal(followDTO);
	}
	public List<FollowDTO> selectFollowerList(FollowDTO followDTO,HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		
		return followDAO.selectFollowerList(followDTO);
	}
	public int insertFollowAdd(FollowDTO followDTO, HttpSession session) throws Exception{
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		
		

		return followDAO.insertFollowAdd(followDTO);
	}
	public int deleteFollow(FollowDTO followDTO,HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		followDTO.setFromUser(memberDTO.getNickName());
		
		return followDAO.deleteFollow(followDTO);
	}
}
