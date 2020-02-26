package userInfomation;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Constants;
import config.Gmail;
import userInfomation.dao.UserInfomationDAO;
import userInfomation.dto.UserInfomationDTO;

@WebServlet("/userInfo_servlet/*")
public class UserInfomationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		UserInfomationDAO dao=new UserInfomationDAO();
		request.setCharacterEncoding("utf-8");
		if(url.indexOf("join.do")!=-1) {
			HttpSession session=request.getSession();
			session.removeAttribute("result");
			session.removeAttribute("result2");
			String id=(String)session.getAttribute("id");
			session.removeAttribute("id");
			String passwd=request.getParameter("passwd");
			String name=request.getParameter("name");
			String nickname=(String)session.getAttribute("nickname");
			session.removeAttribute("nickname");
			String birth=request.getParameter("birth");
			String email=request.getParameter("email");
			String hp=request.getParameter("hp");
			String address=request.getParameter("address");
			UserInfomationDTO dto=new UserInfomationDTO();
			dto.setId(id);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setNickname(nickname);
			dto.setBirth(birth);
			dto.setEmail(email);
			dto.setHp(hp);
			dto.setAddress(address);
			dao.joinUserInfo(dto);
			session.setAttribute("email", email);
			Gmail gmail=new Gmail();
			gmail.EmailJoin(nickname, email);			
			String page="/emailCheck.jsp";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("idcheck.do")!=-1) {
			String id=request.getParameter("id");
			String result=null;
			result=dao.idCheck(id);
			request.setAttribute("result", result);
			request.setAttribute("id", id);
			String page="/idcheck.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("nicknamecheck.do")!=-1) {
			String nickname=request.getParameter("nickname");
			String result2=null;
			result2=dao.nicknameCheck(nickname);
			request.setAttribute("result2", result2);
			request.setAttribute("nickname", nickname);
			String page="/nicknamecheck.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("login.do")!=-1) {
			String id=request.getParameter("id");
			String passwd=request.getParameter("passwd");
			UserInfomationDTO dto=dao.login(id,passwd);
			if(dto!=null) {
				String nickname=dto.getNickname();
				String img=dto.getImg();
				HttpSession session=request.getSession();
				session.setAttribute("nickname", nickname);
				session.setAttribute("img", img);
				String page="/index.jsp?message=login";
				response.sendRedirect(contextPath+page);				
			}else {
				String page="/login.jsp?message=fail";
				response.sendRedirect(contextPath+page);
			}
		}else if(url.indexOf("idc.do")!=-1) {
			String id=request.getParameter("id");
			String result=request.getParameter("result");
			HttpSession session=request.getSession();
			session.setAttribute("id", id);
			session.setAttribute("result", result);
			String page="/join.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("idn.do")!=-1) {
			String nickname=request.getParameter("nickname");
			String result2=request.getParameter("result2");
			HttpSession session=request.getSession();
			session.setAttribute("nickname", nickname);	
			session.setAttribute("result2", result2);
			String page="/join.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("logout.do")!=-1) {
			HttpSession session=request.getSession();
			session.invalidate();
			String page=contextPath+"/index.jsp?message=logout";
			response.sendRedirect(page);
		}else if(url.indexOf("userlist.do")!=-1) {
			HttpSession session=request.getSession();
			String nickname=(String)session.getAttribute("nickname");
			UserInfomationDTO dto=new UserInfomationDTO();
			dto=dao.userList(nickname);
			request.setAttribute("dto", dto);
			String page="/mypage.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("update.do")!=-1) {
			System.out.println("회원정보수정");
			File uploadDir=new File(Constants.UPLOAD_PATH_IMG);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH_IMG, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			String id=multi.getParameter("id");
			String passwd=multi.getParameter("passwd");
			String name=multi.getParameter("name");
			HttpSession session=request.getSession();
			String nickname=(String)session.getAttribute("nickname");
			String birth=multi.getParameter("birth");
			String email=multi.getParameter("email");
			String hp=multi.getParameter("hp");
			String address=multi.getParameter("address");
			String img="";
			int imgsize=0;
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file=(String)files.nextElement();
					img=multi.getFilesystemName(file);
					File f1=multi.getFile(img);
					if(f1 != null) {
						imgsize=(int)f1.length();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			UserInfomationDTO dto=new UserInfomationDTO();
			dto.setId(id);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setNickname(nickname);
			dto.setBirth(birth);
			dto.setEmail(email);
			dto.setHp(hp);
			dto.setAddress(address);
			if(img == null || img.trim().equals("")) {
				UserInfomationDTO dto2=dao.userList(nickname);
				String fName=dto2.getImg();
				int fSize=dto2.getImgsize();
				dto.setImg(fName);
				dto.setImgsize(fSize);
			}else {
				dto.setImg(img);
				dto.setImgsize(imgsize);
			}
			dao.update(dto);
			String page=contextPath+"/sucess.jsp?message=update";
			response.sendRedirect(page);
		}else if(url.indexOf("delete.do")!=-1) {
			String id=request.getParameter("id");
			dao.delete(id);
			HttpSession session=request.getSession();
			session.invalidate();
			String page=contextPath+"/index.jsp?message=delete";
			response.sendRedirect(page);
		}else if(url.indexOf("emailcheck.do")!=-1) {
			String nickname=request.getParameter("nickname");
			dao.emailcheck(nickname);
			String page="/sucess.jsp?message=join";
			response.sendRedirect(contextPath+page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
