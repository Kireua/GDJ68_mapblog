package com.gdj68.mapblog.feed;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.gdj68.mapblog.util.Pager;

@Controller
@RequestMapping("/board/*")
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	/* ---------------------------------------------- */
	
	// getList
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String getList(Pager pager, Model model) throws Exception {
		List<FeedDTO> ar = feedService.getList(pager);
		model.addAttribute("list", ar);
		model.addAttribute("pager", pager);
		
		return "board/list";
	}
	
	
	// setAdd Form
	@RequestMapping(value="add", method = RequestMethod.GET)
	public String setAdd() throws Exception {
		return "board/add";
	}
	
	// setAdd Insert
	@RequestMapping(value="add", method = RequestMethod.POST)
	public String setAdd(FeedDTO feedDTO, MultipartFile [] photos, HttpSession session, Model model) throws Exception {
		
		int result = feedService.setAdd(feedDTO, photos, session);
		
		String message = "등록 실패";
		
		if(result>0) {
			message = "등록 성공";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("url", "list");
	
		return "commons/result";

	}
	
	
	// getDetail
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String getDetail(FeedDTO feedDTO, Model model) throws Exception {
		feedDTO = feedService.getDetail(feedDTO);
		
		if(feedDTO != null) {
			String message = "등록성공";
			model.addAttribute("dto", feedDTO);
			
			return "board/detail";
		} else {
			model.addAttribute("message", "글을 불러올 수 없습니다.");
			model.addAttribute("url", "list");
			
			return "commons/result";
		}
	}
	
}