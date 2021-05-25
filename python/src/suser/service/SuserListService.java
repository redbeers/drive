package suser.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import jdbc.ConnectionProvider;
import jdbc.JdbcUtil;
import suser.dao.SuserDao;
import suser.model.SuserVO;

public class SuserListService {
	private static SuserListService instance = new SuserListService ();
	private SuserListService () {}
	public static SuserListService getInstance() {
		return instance;
	}
	
	public List<SuserVO> getSuserList(){
		Connection conn = null;
		List<SuserVO> suserList = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			SuserDao dao = SuserDao.getInstance();
			suserList = dao.selectList(conn);
		}catch(SQLException e) {
			e.getMessage();
		}finally {
			JdbcUtil.close(conn);
		}
		return suserList;
	}
	
	
}
