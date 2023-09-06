package com.gdj68.mapblog.member;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import com.gdj68.mapblog.file.FileDTO;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	// 회원가입을 위한 필수 동의 사항
	@RequestMapping(value = "beforeJoin", method = RequestMethod.GET)
	public String beforeJoin() throws Exception{
		return "member/beforeJoin";
	}
	
	// 회원가입(모델은 동의 사항 데이터 전달을 위해 필요) 
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String midJoin(AgreeDTO agreeDTO, Model model) throws Exception{
		model.addAttribute("agree", agreeDTO);
		
		return "member/join";
	}
	
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String setJoin(AgreeDTO agreeDTO, MemberDTO memberDTO, MultipartFile photo, HttpSession session) throws Exception{
			
		System.out.println(photo);
		memberService.setJoin(memberDTO, photo, session);
		memberService.setAgree(agreeDTO);
			
		return "redirect:./login";
	}

	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String getLogin(HttpSession session) throws Exception{
		return "member/login";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String getLogin(MemberDTO memberDTO, HttpSession session, Model model)throws Exception{
		
		MemberFileDTO memberFileDTO;
		memberFileDTO = memberService.getMemberFile(memberDTO);
		memberDTO = memberService.getLogin(memberDTO);
		
		if(memberDTO != null) {
			session.setAttribute("member", memberDTO);
			session.removeAttribute("loginFailed");
			session.removeAttribute("updateResult");
		}else {
			session.setAttribute("loginFailed", "1");
			session.removeAttribute("updateResult");
			return "redirect:./login";
		}
		if(memberFileDTO != null) {
			session.setAttribute("memberFile", memberFileDTO);
		}
		
		String userUrl = memberDTO.getUrl();
		
		return "redirect:../feed/list/"+userUrl;	
	}
	
	// 로그아웃
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String getLogout(HttpSession session)throws Exception{
		session.invalidate();
		
		return "redirect:../";
	}
	
	// 마이페이지
	@RequestMapping(value = "mypage", method = RequestMethod.GET)
	public String MyPage()throws Exception{
		return "member/mypage";
	}
	
	// 회원정보 수정
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String setMemberUpdate()throws Exception{
		return "member/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String setMemberUpdate(MemberDTO memberDTO, HttpSession session)throws Exception{
		MemberDTO sessionMember = (MemberDTO)session.getAttribute("member");
		memberDTO.setId(sessionMember.getId());
		int result = memberService.setMemberUpdate(memberDTO);
		if(result>0) {
			session.removeAttribute("member");
			session.setAttribute("updateResult", "1");
			return "redirect:./login";
		}	 
		return "redirect:./mypage";
	}
	
	// 프로필 사진 수정
	@RequestMapping(value = "updateImg", method = RequestMethod.GET)
	public String setUpdateImg()throws Exception{
		return "member/updateImg";
	}
	
	@RequestMapping(value = "updateImg", method = RequestMethod.POST)
	public String setUpdateImg(MemberFileDTO memberFileDTO, MultipartFile photo, HttpSession session)throws Exception{
		FileDTO fileDTO = (FileDTO)memberFileDTO;
		
		MemberFileDTO result = memberService.setUpdateImg(photo, memberFileDTO, fileDTO, session);
		
		session.setAttribute("memberFile", result);
		
		return "redirect:./mypage";
	}
	
	// 회원 탈퇴
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteMember(HttpSession session)throws Exception{
		MemberDTO sessionMember = (MemberDTO)session.getAttribute("member");
		memberService.deleteMember(sessionMember);
		session.invalidate();		
		return "redirect:../";
	}
	
	// ID 중복체크
	@RequestMapping(value = "idCheck", method = RequestMethod.GET)
	public String getIdCheck(MemberDTO memberDTO, Model model)throws Exception{
		memberDTO = memberService.getIdCheck(memberDTO);
		
		int result=0;
		if(memberDTO == null) {
			result=1;
		}		
		model.addAttribute("result", result);	
		return "commons/ajaxResult";
	}
	
	// URL 중복체크
	@RequestMapping(value = "urlCheck", method = RequestMethod.GET)
	public String getUrlCheck(MemberDTO memberDTO, Model model)throws Exception{
		memberDTO = memberService.getUrlCheck(memberDTO);
		
		int result=0;	
		if(memberDTO == null) {
			result=1;
		}		
		model.addAttribute("result", result);		
		return "commons/ajaxResult";
	}
	
	// 닉네임 중복체크
	@RequestMapping(value = "nickNameCheck", method = RequestMethod.GET)
	public String getNickNameCheck(MemberDTO memberDTO, Model model)throws Exception{
		memberDTO = memberService.getNickNameCheck(memberDTO);
		
		int result=0; // 중복o	
		if(memberDTO == null) {
			result=1; // 중복x
		}		
		model.addAttribute("result", result);		
		return "commons/ajaxResult";
	}
	
	// email 본인 인증
	@Autowired
	private JavaMailSenderImpl mailSender;
	@RequestMapping(value = "emailCheck", method = RequestMethod.GET)
	public String getEmailCheck(String email, Model model)throws Exception{
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		
		String setFrom = "exnngod@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
		String toMail = email;
		String title = "MAPPER 회원 가입 인증 이메일"; // 이메일 제목 
		String content = 
				"MAPPER를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
                "<br><br>" + 
			    "인증 번호는 " + checkNum + "입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("result", checkNum);		
		return "commons/ajaxResult";
    }
	
	// 아이디 비밀번호 찾기
	@RequestMapping(value = "find", method = RequestMethod.GET)
	public String find() throws Exception{
		return "member/find";
	}
	
	// 아이디 비밀번호 찾기 기능
	@RequestMapping(value = "findIdPw", method = RequestMethod.GET)
	public String findIdPw(String email, Model model) throws Exception{
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setEmail(email);
		memberDTO = memberService.findIdPw(memberDTO);
		String found = "ID: "+memberDTO.getId()+" / PW: "+memberDTO.getPw();
		model.addAttribute("result", found);
		
		return "commons/ajaxResult";
	}
	
	// 회원 검색
	@RequestMapping(value = "searchMember", method = RequestMethod.GET)
	public String searchMember() throws Exception{
		return "member/searchMember";
	}
	
	@RequestMapping(value = "searchMember", method = RequestMethod.POST)
	public String searchMember(Model model, MemberSearchDTO memberSearchDTO, HttpSession session) throws Exception{
		
		MemberDTO uDTO = (MemberDTO)session.getAttribute("member");
		String uNN = uDTO.getNickName();
		memberSearchDTO.setNickName(uNN);
		// ml은 차단하지 않은 멤버 리스트
		List<MemberDTO> ml = memberService.searchMember(memberSearchDTO);
		
		// il은 차단한 멤버 리스트
		List<MemberDTO> il = memberService.searchMember2(memberSearchDTO);
		
		model.addAttribute("list", ml);
		model.addAttribute("ignore", il);
		
		return "member/searchList";
	}
	
	// 회원 차단하기
	@RequestMapping(value = "ignore", method = RequestMethod.GET)
	public String ignore(String ignored, HttpSession session) throws Exception{
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		String uNN = memberDTO.getNickName();
		
		IgnoreDTO ignoreDTO = new IgnoreDTO();
		ignoreDTO.setIgnored(ignored);
		ignoreDTO.setIgnoring(uNN);
		memberService.ignore(ignoreDTO);
		
		return "redirect:./searchIgnore";
	}
	
	// 회원 차단 해제
	@RequestMapping(value = "ignoreCancle", method = RequestMethod.GET)
	public String ignoreCancle(String ignored, HttpSession session) throws Exception{
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		String uNN = memberDTO.getNickName();
		
		IgnoreDTO ignoreDTO = new IgnoreDTO();
		ignoreDTO.setIgnored(ignored);
		ignoreDTO.setIgnoring(uNN);
		memberService.ignoreCancle(ignoreDTO);
		
		return "redirect:./searchIgnore";
	}
	
	// 내가 차단한 회원 조회
	@RequestMapping(value = "searchIgnore", method = RequestMethod.GET)
	public String searchIgnore(HttpSession session, Model model) throws Exception{
		MemberDTO memeberDTO = (MemberDTO)session.getAttribute("member");
		List<IgnoreDTO> il = memberService.didYouIgnore(memeberDTO);
		
		model.addAttribute("ignore", il);
		
		return "member/ignoreList";
	}
}
