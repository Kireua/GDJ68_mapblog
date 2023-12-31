package com.gdj68.mapblog.member.naver;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdj68.mapblog.member.AgreeDTO;
import com.gdj68.mapblog.member.MemberDTO;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/naver/*")
public class NaverController {
	
	@Autowired
	private NaverService naverService;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
		
	//로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		
		//네이버 
		model.addAttribute("url", naverAuthUrl);
 
		return "member/naverLogin";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException, org.json.simple.parser.ParseException {
			
			System.out.println("여기는 callback");
			OAuth2AccessToken oauthToken;
	        oauthToken = naverLoginBO.getAccessToken(session, code, state);
	 
	        //1. 로그인 사용자 정보를 읽어온다.
			apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
			
			/** apiResult json 구조
			{"resultcode":"00",
			 "message":"success",
			 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
			**/
			
			//2. String형식인 apiResult를 json형태로 바꿈
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			//3. 데이터 파싱 
			//Top레벨 단계 _response 파싱
			JSONObject response_obj = (JSONObject)jsonObj.get("response");
			
			System.out.println(response_obj);
			//response의 값 파싱
			String email = (String)response_obj.get("email");
			String name = (String)response_obj.get("name");
					
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setEmail(email);
			memberDTO.setName(name);
			
			MemberDTO memberDTO2 = naverService.getEmailCheck(memberDTO);
			System.out.println(memberDTO2);
			
			if(memberDTO2 != null) {
				//4. 세션에 저장
				System.out.println("기존 정보 있음");
				session.setAttribute("member", memberDTO2);				
				model.addAttribute("result", apiResult);
				return "/member/naverLoginS";
			}else {
				System.out.println("기존 정보 없음");
				session.setAttribute("naverMember", memberDTO);
				session.removeAttribute("loginFailed");
				session.removeAttribute("updateResult");
				return "/member/beforeNaverJoin";
			}			
		}
		
		
		//로그아웃
		@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
		public String logout(HttpSession session)throws IOException {
				System.out.println("여기는 logout");
				session.invalidate();
		        
				return "redirect:../";
		}
		
		// 네이버 회원가입(모델은 동의 사항 데이터 전달을 위해 필요) 
		@RequestMapping(value = "join", method = RequestMethod.GET)
		public String midJoin(AgreeDTO agreeDTO, Model model) throws Exception{
			model.addAttribute("agree", agreeDTO);
			
			return "member/naverJoin";
		}
}
