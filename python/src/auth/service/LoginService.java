package auth.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import jdbc.JdbcUtil;
import suser.dao.SuserDao;
import suser.model.SuserVO;

public class LoginService {
	SuserDao suserDao = SuserDao.getInstance();
	
	public SuserVO login(String userId, String pwd) {
		Connection conn = null;
		SuserVO suser = null; 
		try {
			conn = ConnectionProvider.getConnection();
			suser = suserDao.login(conn, userId, pwd);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
			
		}finally {
			JdbcUtil.close(conn);
		}
		return suser;
	}
}
