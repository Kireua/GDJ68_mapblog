package com.gdj68.mapblog.interceptors;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gdj68.mapblog.admin.member.AdminMemberDTO;
import com.gdj68.mapblog.admin.member.RoleDTO;


@Component
public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		AdminMemberDTO adminMemberDTO = (AdminMemberDTO)request.getSession().getAttribute("adminMember");
		List<RoleDTO> roles= adminMemberDTO.getRoles();
		for(RoleDTO roleDTO:roles) {
			if(roleDTO.getRoleName().equals("MASTER")) {
				
				return true;
			}
		}
		
		request.setAttribute("message", "권한이 없습니다.");
		request.setAttribute("url", "/admin/main");
		
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/commons/result.jsp");
		try {
			view.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false; 
	}

}
