package community_job;

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
import community_job.dao.Community_jobDAO;
import community_job.dto.Community_jobDTO;
import config.Pager;

@WebServlet("/community_job_servlet/*")
public class Community_jobController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		Community_jobDAO dao=new Community_jobDAO();
		if(url.indexOf("list.do")!=-1) { 
			System.out.println("리스트 실행..");
			int count=dao.count();
			int curPage=1;
			if(request.getParameter("curPage")!=null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			String list_view=request.getParameter("sequence");
			System.out.println(list_view);
			List<Community_jobDTO> list=dao.list(start,end,list_view);
			request.setAttribute("list", list);
			System.out.println(list);
			request.setAttribute("page", pager);			
			request.setAttribute("list_view", list_view);
			String page="/community_job.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page); 
			rd.forward(request, response);			 
		}else if(url.indexOf("insert.do")!=-1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {//업로드디렉토리가 존재하지 않으면
				uploadDir.mkdir();//디렉토리를 만듦
			}
			//request를 확장시킨 MultipartRequest 생성
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			HttpSession session=request.getSession();
			String writer=(String)session.getAttribute("writer");
			System.out.println(writer);
			String job_area=multi.getParameter("job_area");
			System.out.println(job_area);
			String subject=multi.getParameter("subject");
			System.out.println(subject);
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
			Community_jobDTO dto=new Community_jobDTO();
			dto.setWriter(writer);
			dto.setJob_area(job_area);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			//파일 첨부를 하지 않을 경우
			//trim() 문자열의 좌우 공백 제거
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			
			dao.insert(dto);
			String page="/community_job_servlet/list.do";
			response.sendRedirect(contextPath+page);
		} else if(url.indexOf("download.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String filename=dao.getFileName(num);
			System.out.println("첨부파일 이름:"+filename);
			String path=Constants.UPLOAD_PATH+filename;
			byte b[]=new byte[4096];
			FileInputStream fis=new FileInputStream(path);
			String mimeType=getServletContext().getMimeType(path);
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			filename = new String(filename.getBytes("utf-8"),"8859_1");
			//http header
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			//OutputStream 생성(서버에서 클라이언트에 쓰기)
			ServletOutputStream out=response.getOutputStream();
			int numRead;
			while(true) {
				numRead = fis.read(b,0,b.length);//데이터 읽음
				if(numRead == -1) break; //더 이상 내용이 없으면
				out.write(b,0,numRead);//데이터 쓰기
			}
			//파일 처리 관련 리소스 정리
			out.flush();
			out.close();
			fis.close();
			//다운로드 횟수 증가 처리
			dao.plusDown(num);
			String page="/community_job_servlet/list.do";
			response.sendRedirect(contextPath+page);
		} else if(url.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession(); //조회수 증가 처리 
			dao.plusReadCount(num,session);		 
			Community_jobDTO dto=dao.viewReplace(num);
			int count=dao.count();
			request.setAttribute("count", count);
			request.setAttribute("dto", dto);
			System.out.println(dto);
			String page="/community_job_view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("pass_check.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String passwd=request.getParameter("passwd");
			String result=dao.passwdCheck(num, passwd);
			String page="";
			if(result != null) {
				page="/community_job_list_edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가 틀리면
				page=contextPath+"/community_job_servlet/view.do?num="
			+num+"&message=error";
				response.sendRedirect(page);
			}//else
		} else if(url.indexOf("community_job_update.do")!=-1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String subject=multi.getParameter("subject");
			String job_area=multi.getParameter("job_area");
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
			Community_jobDTO dto=new Community_jobDTO();
			dto.setNum(num);
			dto.setJob_area(job_area);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				Community_jobDTO dto2=dao.view(num);
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
			//레코드 수정
			dao.update(dto);
			//페이지 이동
			String page="/community_job_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("community_job_delete.do")!=-1) {
			MultipartRequest multi=new MultipartRequest(request,Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			//페이지 이동
			String page="/community_job_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("search.do")!=-1) {
			String keyword="%"+request.getParameter("keyword")+"%";
			List<Community_jobDTO> list=dao.searchList(keyword);
			String keyword_count=dao.searchCount(keyword);
			request.setAttribute("list", list);
			request.setAttribute("keyword_count", keyword_count);
			request.setAttribute("keyword", request.getParameter("keyword"));
			String page="/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("like_good.do")!=-1) {
			System.out.println("좋아용ㅎㅎ");
			int num=Integer.parseInt(request.getParameter("num"));
			HttpSession session=request.getSession();
			System.out.println(num);
			dao.plusGood(num, session);
			String page="/community_job_view.jsp";
			response.sendRedirect(contextPath+page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
