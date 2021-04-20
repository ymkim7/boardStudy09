package kr.co.controller;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class Test {
	
	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionFactory sql;
	
	@org.junit.Test
	public void test() throws Exception {
		try(Connection conn = ds.getConnection()) {
			System.out.println(conn);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@org.junit.Test
	public void sessionTest() throws Exception {
		try(SqlSession session = sql.openSession()) {
			System.out.println(session);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
