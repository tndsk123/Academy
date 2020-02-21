package userInfomation.dao;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.Random;
import sqlmap.MybatisManager;
import userInfomation.dto.UserInfomationDTO;

public class UserInfomationDAO {

	public void joinUserInfo(UserInfomationDTO dto) {
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			session.insert("userinfo.join",dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}

	public String idCheck(String id) {
		SqlSession session = 
				MybatisManager.getInstance().openSession();
		String result=null;
		result=session.selectOne("userinfo.idcheck",id);
		if(result==null) {
			result="사용 가능한 아이디 입니다.";
		}else {
			result="이미 사용중인 아이디 입니다.";
		}
		session.close();
		return result;
	}

	public String nicknameCheck(String nickname) {
		SqlSession session = 
				MybatisManager.getInstance().openSession();
		String result2=null;
		result2=session.selectOne("userinfo.nicknamecheck",nickname);
		if(result2==null) {
			result2="사용 가능한 닉네임 입니다.";		
		}else {
			result2="이미 사용중인 닉네임 입니다.";
		}
		session.close();
		return result2;
	}
	public UserInfomationDTO login(String id, String passwd) {
		UserInfomationDTO result=null;
		SqlSession session = MybatisManager.getInstance().openSession();
		Map<String, String> map=new HashMap<>();
		map.put("id", id);
		map.put("passwd", passwd);
		result=session.selectOne("userinfo.login",map);
		session.close();
		return result;
	}

	public UserInfomationDTO userList(String nickname) {
		UserInfomationDTO dto=null;
		SqlSession session = MybatisManager.getInstance().openSession();
		dto=session.selectOne("userinfo.userlist", nickname);
		session.close();
		return dto;
	}

	public void update(UserInfomationDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.update("userinfo.update", dto);
		session.commit();
		session.close();
	}

	public void delete(String id) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.delete("userinfo.delete", id);
		session.commit();
		session.close();
	}
	
	public int look_id(UserInfomationDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String code;
		code=session.selectOne("userinfo.look_id", dto);
		if(code==null) {
			int result=-1;
			session.close();
			return result;
		}else {
			int result=1;
			session.close();
			return result;
		}
	}
	
	public String get_id(String email, String name) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String id;
		Map<String, String> map=new HashMap<>();
		map.put("email", email);
		map.put("name", name);
		id=session.selectOne("userinfo.get_id", map);
		session.close();
		return id;
	}
	
	public int look_pw(UserInfomationDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String code;
		code=session.selectOne("userinfo.look_pw", dto);
		if(code==null) {
			int result=-1;
			session.close();
			return result;
		}else {
			int result=1;
			session.close();
			return result;
		}
		
	}
	
	public String update_passwd(String email, String id) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String passwd;
		passwd=Random.random("1");
		Map<String, String> map=new HashMap<>();
		map.put("email", email);
		map.put("id", id);
		map.put("passwd", passwd);
		session.update("userinfo.update_passwd", map);
		session.commit();
		session.close();
		return passwd;
	}

	public void emailcheck(String nickname) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.update("userinfo.emailcheck", nickname);
		session.commit();
		session.close();		
	}

}
