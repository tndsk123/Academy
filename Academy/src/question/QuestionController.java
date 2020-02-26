package question;

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
import config.Pager;
import question.dao.QuestionDAO;
import question.dto.QuestionDTO;
import question.dto.Question_commentDTO;


@WebServlet("/question_servlet/*")
public class QuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		QuestionDAO dao=new QuestionDAO();
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
			List<QuestionDTO> list=dao.list(start,end,list_view);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);			
			request.setAttribute("list_view", list_view);
			String page="/question.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page); 
			rd.forward(request, response);			 
		}else if(url.indexOf("insert.do")!=-1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {
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
				Enumeration files=multi.getFileNames();//첨부파일의 집합
				while(files.hasMoreElements()) {					
					String file1=(String)files.nextElement();//첨부파일의 이름
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			QuestionDTO dto=new QuestionDTO();
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
			String page="/question_servlet/list.do";
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
			String page="/question_servlet/list.do";
			response.sendRedirect(contextPath+page);
		} else if(url.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			HttpSession session=request.getSession();
			dao.plusReadCount(num,session);		 
			QuestionDTO dto=dao.viewReplace(num);
			int count=dao.count();
			request.setAttribute("count", count);
			request.setAttribute("dto", dto);
			String page="/question_view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("commentList.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			List<Question_commentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			String page="/question_comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("comment_add.do") != -1) {
			Question_commentDTO dto=new Question_commentDTO();
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
				page="/question_list_edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {
				page=contextPath+"/question_servlet/view.do?num="
			+num+"&message=error";
				response.sendRedirect(page);
			}
		} else if(url.indexOf("question_update.do")!=-1) {
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
			QuestionDTO dto=new QuestionDTO();
			dto.setNum(num);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				QuestionDTO dto2=dao.view(num);
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
			String page="/question_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("question_delete.do")!=-1) {
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			String page="/question_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("search.do")!=-1) {
			String keyword="%"+request.getParameter("keyword")+"%";
			List<QuestionDTO> list=dao.searchList(keyword);
			String keyword_count=dao.searchCount(keyword);
			request.setAttribute("list", list);
			request.setAttribute("keyword_count", keyword_count);
			request.setAttribute("keyword", request.getParameter("keyword"));
			String page="/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("reply.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			QuestionDTO dto=dao.view(num);
			dto.setContent("=========게시물의 내용=========\n"+dto.getContent()+"\n=========게시물의 답변=========\n");
			request.setAttribute("dto", dto);
			String page="/question_aply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("insertReply.do")!=-1){
			int num=Integer.parseInt(request.getParameter("num"));
			QuestionDTO dto=dao.view(num);
			int ref=dto.getRef();//답변 그룹 번호
			int re_step=dto.getRe_step()+1;//출력순번
			int re_level=dto.getRe_level()+1;//답변 단계
			HttpSession session=request.getSession();
			String writer=(String)session.getAttribute("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			String passwd=request.getParameter("passwd");
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setRef(ref);
			dto.setRe_level(re_level);
			dto.setRe_step(re_step);
			dto.setFilename("-");
			dto.setFilesize(0);
			dto.setDown(0);
			dao.updateStep(ref, re_step);
			dao.reply(dto);
			String page="/question_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
