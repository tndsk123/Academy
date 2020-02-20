package main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import community_exchange.dto.Community_exchangeDTO;
import community_job.dto.Community_jobDTO;
import community_main.dto.Community_mainDTO;
import reference.dto.ReferenceDTO;
import sqlmap.MybatisManager;

public class MainDAO {

	public List<Community_mainDTO> main() {
		List<Community_mainDTO> main=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			main = session.selectList("Main.main");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return main;
	}
	public List<Community_exchangeDTO> exchange() {
		List<Community_exchangeDTO> exchange=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			exchange = session.selectList("Main.exchange");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return exchange;
	}
	public List<Community_jobDTO> job() {
		List<Community_jobDTO> job=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			job = session.selectList("Main.job");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return job;
	}
	public List<ReferenceDTO> reference() {
		List<ReferenceDTO> reference=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();			
			reference = session.selectList("Main.reference");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return reference;
	}
	public List<Community_mainDTO> searchMain(String keyword) {
		List<Community_mainDTO> main=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			main=session.selectList("Main.searchMain",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return main;
	}
	public List<Community_exchangeDTO> searchExchange(String keyword) {
		List<Community_exchangeDTO> exchange=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			exchange=session.selectList("Main.searchExchange",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return exchange;
	}
	public List<Community_jobDTO> searchJob(String keyword) {
		List<Community_jobDTO> job=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			job=session.selectList("Main.searchJob",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return job;
	}
	public List<ReferenceDTO> searchReference(String keyword) {
		List<ReferenceDTO> reference=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			reference=session.selectList("Main.searchReference",keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reference;
	}
}
