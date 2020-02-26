package community_main;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Constants;
import community_main.dao.Community_mainDAO;
import community_main.dto.Community_mainDTO;
import community_main.dto.Community_main_commentDTO;
import config.Pager;

@WebServlet("/community_main_servlet/*")
public class Community_mainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		Community_mainDAO dao=new Community_mainDAO();
		request.setCharacterEncoding("utf-8");
		if(url.indexOf("list.do")!=-1) { 
			int count=dao.count();
			int curPage=1;
			if(request.getParameter("curPage")!=null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			String list_view=request.getParameter("sequence");
			List<Community_mainDTO> list=dao.list(start,end,list_view);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);			
			request.setAttribute("list_view", list_view);
			String page="/community_main.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page); 
			rd.forward(request, response);			 
		}else if(url.indexOf("insert.do")!=-1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			HttpSession session=request.getSession();
			String writer=(String)session.getAttribute("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			String filename=" ";
			int filesize=0;
			try {				
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {					
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			Community_mainDTO dto=new Community_mainDTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);			
			dao.insert(dto);
			String page="/community_main_servlet/list.do";
			response.sendRedirect(contextPath+page);
		} else if(url.indexOf("download.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String filename=dao.getFileName(num);
			String path=Constants.UPLOAD_PATH+filename;
			byte b[]=new byte[4096];
			FileInputStream fis=new FileInputStream(path);
			String mimeType=getServletContext().getMimeType(path);
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			filename = new String(filename.getBytes("utf-8"),"8859_1");
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			ServletOutputStream out=response.getOutputStream();
			int numRead;
			while(true) {
				numRead = fis.read(b,0,b.length);
				if(numRead == -1) break; 
				out.write(b,0,numRead);
			}
			out.flush();
			out.close();
			fis.close();
			dao.plusDown(num);
			String page="/community_main_servlet/list.do";
			response.sendRedirect(contextPath+page);
		} else if(url.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			HttpSession session=request.getSession(); 
			dao.plusReadCount(num,session);		 
			Community_mainDTO dto=dao.viewReplace(num);
			int count=dao.count();
			request.setAttribute("count", count);
			request.setAttribute("dto", dto);
			String page="/community_main_view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("commentList.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			List<Community_main_commentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			String page="/community_main_comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("comment_add.do") != -1) {
			Community_main_commentDTO dto=new Community_main_commentDTO();
			int board_num=Integer.parseInt(request.getParameter("board_num"));
			String writer=request.getParameter("co_writer");
			String content=request.getParameter("co_content");
			dto.setBoard_num(board_num);
			dto.setWriter(writer);
			dto.setContent(content);
			dao.commentAdd(dto);
		} else if(url.indexOf("pass_check.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String passwd=request.getParameter("passwd");
			String result=dao.passwdCheck(num, passwd);
			String page="";
			if(result != null) {
				page="/community_main_list_edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {
				page=contextPath+"/community_main_servlet/view.do?num="
			+num+"&message=error";
				response.sendRedirect(page);
			}
		} else if(url.indexOf("community_main_update.do")!=-1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			String filename=" ";
			int filesize=0;
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file=(String)files.nextElement();
					filename=multi.getFilesystemName(file);
					File f1=multi.getFile(file);
					if(f1 != null) {
						filesize=(int)f1.length();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			Community_mainDTO dto=new Community_mainDTO();
			dto.setNum(num);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				Community_mainDTO dto2=dao.view(num);
				String fName=dto2.getFilename();
				int fSize=dto2.getFilesize();
				int fDown=dto2.getDown();
				dto.setFilename(fName);
				dto.setFilesize(fSize);
				dto.setDown(fDown);
			}else {
				dto.setFilename(filename);
				dto.setFilesize(filesize);
			}
			String fileDel=multi.getParameter("fileDel");
			if(fileDel != null && fileDel.equals("on")) {
				String fileName=dao.getFileName(num);
				File f=new File(Constants.UPLOAD_PATH+fileName);
				f.delete();
				dto.setFilename("-");
				dto.setFilesize(0);
				dto.setDown(0);
			}
			dao.update(dto);
			String page="/community_main_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("community_main_delete.do")!=-1) {
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			String page="/community_main_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("search.do")!=-1) {
			String keyword="%"+request.getParameter("keyword")+"%";
			List<Community_mainDTO> list=dao.searchList(keyword);
			String keyword_count=dao.searchCount(keyword);
			request.setAttribute("list", list);
			request.setAttribute("keyword_count", keyword_count);
			request.setAttribute("keyword", request.getParameter("keyword"));
			String page="/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("like_good.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			HttpSession session=request.getSession();
			dao.plusGood(num, session);
			String page="/community_main_view.jsp";
			response.sendRedirect(contextPath+page);
		} 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
