package community_exchange.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import community_exchange.dto.Community_exchangeDTO;
import community_exchange.dto.Community_exchange_commentDTO;
import sqlmap.MybatisManager;

public class Community_exchangeDAO {
	
	public List<Community_exchangeDTO> list(int start, int end, String list_view){
		List<Community_exchangeDTO> list=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			Map<String, Object> map =new HashMap<>(); 
			map.put("start", start);
			map.put("end", end);
			if(list_view==null) {
				list_view="basic";
			}
			map.put("list_view", list_view);
			list = session.selectList("community_exchange.list" , map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void insert(Community_exchangeDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("community_exchange.insert", dto);
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
			result = session.selectOne("community_exchange.getFileName", num);
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
			session.update("community_exchange.plusDown", num);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public Community_exchangeDTO view(int num) {
		Community_exchangeDTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto = session.selectOne("community_exchange.view", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;
	}
	
	public Community_exchangeDTO viewReplace(int num) {
		Community_exchangeDTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto = session.selectOne("community_exchange.view", num);
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
			long current_time=System.currentTimeMillis();//현재시각
			session=MybatisManager.getInstance().openSession();
			if(current_time-read_time>5*1000) {//현재시간-읽은시간>5초,
				//하루에 한번 증가 24*60*60*1000
				session.update("community_exchange.plusReadCount", num);
				session.commit();//auto commit 아님
				//최근 열람 시각 업데이트
				count_session.setAttribute("read_time_"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public List<Community_exchange_commentDTO> commentList(int num) {
		List<Community_exchange_commentDTO> list=null;
		SqlSession session=null;
		try {
			session = MybatisManager.getInstance().openSession();
			list=session.selectList("community_exchange.commentList", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return list;

	}

	public void commentAdd(Community_exchange_commentDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("community_exchange.commentAdd", dto);
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
			result=session.selectOne("community_exchange.pass_check", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return result;
	}

	public void update(Community_exchangeDTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("community_exchange.update", dto);
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
			session.update("community_exchange.delete", num);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
	}

	public List<Community_exchangeDTO> searchList(String keyword) {
		List<Community_exchangeDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			list=session.selectList("community_exchange.searchList",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public String searchCount(String keyword) {
		String keyword_count=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			keyword_count=session.selectOne("community_exchange.searchCount",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return keyword_count;
	}	
	
	public int count() { 
		int result=0; 
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			result=session.selectOne("community_exchange.count"); 
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
				session.update("community_exchange.plusGood", num);
				session.commit();
				count_session.setAttribute("read_time_"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	} 
	
	
}
