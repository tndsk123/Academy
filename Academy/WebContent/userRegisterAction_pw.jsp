<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="userInfomation.dto.UserInfomationDTO"%>
<%@ page import="userInfomation.dao.UserInfomationDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	if(request.getParameter("id") != null) {
		String name = (String) request.getParameter("name");		
	}
	if(request.getParameter("name2") != null) {
		String name = (String) request.getParameter("name2");		
	}
	if(request.getParameter("email") != null) {
		String email = (String) request.getParameter("email");
	}
	if (request.getParameter("id") == null || request.getParameter("name2") == null || request.getParameter("email") == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		UserInfomationDAO dao = new UserInfomationDAO();
		int result = dao.look_pw(new UserInfomationDTO((String)request.getParameter("id"), (String)request.getParameter("name2"), (String)request.getParameter("email")));
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력받은 값의 정보가 없습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			session.setAttribute("email", (String)request.getParameter("email"));
			session.setAttribute("id", (String)request.getParameter("id"));
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'look_for_pw.jsp';");
			script.println("</script>");
			script.close();
		}
	}
%>
