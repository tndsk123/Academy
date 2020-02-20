package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import community_exchange.dto.Community_exchangeDTO;
import community_job.dto.Community_jobDTO;
import community_main.dto.Community_mainDTO;
import main.dao.MainDAO;
import reference.dto.ReferenceDTO;

@WebServlet("/main_servlet/*")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		MainDAO dao=new MainDAO();
		request.setCharacterEncoding("utf-8");
		if(url.indexOf("list.do")!=-1) {
			System.out.println("메인 리스트 실행");
			List<Community_mainDTO> main=dao.main();
			List<Community_exchangeDTO> exchange=dao.exchange();
			List<Community_jobDTO> job=dao.job();
			List<ReferenceDTO> reference=dao.reference();
			request.setAttribute("main", main);
			request.setAttribute("exchange", exchange);
			request.setAttribute("job", job);
			request.setAttribute("reference", reference);
			String page="/main.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page); 
			rd.forward(request, response);		
		}else if(url.indexOf("search.do")!=-1) {
			String keyword="%"+request.getParameter("keyword")+"%";
			List<Community_mainDTO> main=dao.searchMain(keyword);
			List<Community_exchangeDTO> exchange=dao.searchExchange(keyword);
			List<Community_jobDTO> job=dao.searchJob(keyword);
			List<ReferenceDTO> reference=dao.searchReference(keyword);
			if(main.isEmpty() && exchange.isEmpty() && job.isEmpty() && reference.isEmpty()) {
				System.out.println("하나도 없네?");
				request.setAttribute("searchList", "n");
			}
			System.out.println(main);
			System.out.println(exchange);
			System.out.println(job);
			System.out.println(reference);
			request.setAttribute("main", main);
			request.setAttribute("exchange", exchange);
			request.setAttribute("job", job);
			request.setAttribute("reference", reference);
			request.setAttribute("keyword", request.getParameter("keyword"));
			String page="/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
