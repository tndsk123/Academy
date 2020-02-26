package reference.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import reference.dto.ReferenceDTO;
import reference.dto.Reference_commentDTO;
import sqlmap.MybatisManager;

public class ReferenceDAO {
	
	public List<ReferenceDTO> list(int start, int end, String division){
		List<ReferenceDTO> list=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			Map<String, Object> map =new HashMap<>(); 
			map.put("start", start);
			map.put("end", end);
			if(division==null ) {
				division="all";
			}
			map.put("division", division);
			list = session.selectList("reference.list" , map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void insert(ReferenceDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("reference.insert", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}		
	}

	public String getFileName(int num) {
		String result="";
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			result = session.selectOne("reference.getFileName", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return result;
	}

	public void plusDown(int num) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("reference.plusDown", num);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public ReferenceDTO view(int num) {
		ReferenceDTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto = session.selectOne("reference.view", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;
	}
	
	public ReferenceDTO viewReplace(int num) {
		ReferenceDTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto = session.selectOne("reference.view", num);
			String content=dto.getContent();
			content=content.replace("\n", "<br>");
			dto.setContent(content);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;
		
	}

	public void plusReadCount(int num, HttpSession count_session) {
		SqlSession session=null;
		try {
			long read_time=0;
			if(count_session.getAttribute("read_time_"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time_"+num);
			}
			long current_time=System.currentTimeMillis();
			session=MybatisManager.getInstance().openSession();
			if(current_time-read_time>5*1000) {
				session.update("reference.plusReadCount", num);
				session.commit();
				count_session.setAttribute("read_time_"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public List<Reference_commentDTO> commentList(int num) {
		List<Reference_commentDTO> list=null;
		SqlSession session=null;
		try {
			session = MybatisManager.getInstance().openSession();
			list=session.selectList("reference.commentList", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return list;

	}

	public void commentAdd(Reference_commentDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("reference.commentAdd", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public String passwdCheck(int num, String passwd) {
		String result=null;
		SqlSession session=null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("num", num);
			map.put("passwd", passwd);
			result=session.selectOne("reference.pass_check", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return result;
	}

	public void update(ReferenceDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("reference.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}		
	}

	public void delete(int num) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("reference.delete", num);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
	}

	public List<ReferenceDTO> searchList(String keyword) {
		List<ReferenceDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			list=session.selectList("reference.searchList",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public String searchCount(String keyword) {
		String keyword_count=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			keyword_count=session.selectOne("reference.searchCount",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return keyword_count;
	}	
	
	public int count() { 
		int result=0; 
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			result=session.selectOne("reference.count"); 
		} catch (Exception e) {
			e.printStackTrace(); 
		} 
		return result; 
	}
	public void plusGood(int num, HttpSession count_session) {
		SqlSession session=null;
		try {
			long read_time=0;
			if(count_session.getAttribute("read_time_"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time_"+num);
			}
			long current_time=System.currentTimeMillis();
			session=MybatisManager.getInstance().openSession();
			if(current_time-read_time>5*1000) {
				session.update("reference.plusGood", num);
				session.commit();
				count_session.setAttribute("read_time_"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public int countSearch(String division) {
		int result=0; 
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			if(division==null) {
				division="all";
			}
			result=session.selectOne("reference.countSearch",division); 
		} catch (Exception e) {
			e.printStackTrace(); 
		} 
		return result; 
	}

}
