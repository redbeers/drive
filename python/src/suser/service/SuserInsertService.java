package suser.service;

import jdbc.ConnectionProvider;
import jdbc.JdbcUtil;
import suser.dao.SuserDao;
import suser.model.SuserVO;

import java.util.List;

import java.sql.Connection;
import java.sql.SQLException;

public class SuserInsertService {
	private static SuserInsertService instance = new SuserInsertService ();
	private SuserInsertService () {}
	public static SuserInsertService getInstance() {
		return instance;
	}
	
	public void SuserInsert(String userId, String pwd, String userName, String mobile, String email, String birth)
		throws SQLException{
		SuserDao suserdao = SuserDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			suserdao.suserInsert(conn, userId, pwd, userName, mobile, email, birth);
	
		}finally {
			JdbcUtil.close(conn);
		}
	}
}
