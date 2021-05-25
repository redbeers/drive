package suser.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jdbc.JdbcUtil;
import suser.model.SuserVO;

public class SuserDao {
	private static SuserDao suserDao = new SuserDao();
	private SuserDao() {}
	public static SuserDao getInstance() {
		
		return suserDao;
	}
	
	//로그인
	public SuserVO login (Connection conn, String userId, String pwd) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(
					"select * from suser "
					+ " where user_id = ?"
					+ "  and pwd = ?"
					);
			pstmt.setString(1, userId);
			pstmt.setString(2, pwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				SuserVO suser = makeSuserVO(rs);
				return suser;
			}else {
				return null;
			}			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//select
	public List<SuserVO> selectList (Connection conn ) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(
					"select * from suser"
					);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				List<SuserVO> suserList = new ArrayList();
				
				do {
					suserList.add(makeSuserVO(rs));
				}while(rs.next());
				
				return suserList;
			}else {
				return Collections.emptyList();
			}
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	//insert
	public void suserInsert (Connection conn, String userId, String userName , String pwd , String mobile , String email , String birth) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(
					  " INSERT INTO SUSER (USER_ID, PWD, USER_NAME, MOBILE, EMAIL, BIRTH)"
					+ " VALUES (?,?,?,?,?,?)"
					);
			pstmt.setString(1, userId);
			pstmt.setString(2, pwd);
			pstmt.setString(3, userName);
			pstmt.setString(4, mobile);
			pstmt.setString(5, email);
			pstmt.setString(6, birth);
			pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
		
		
	}
	
	
	
	private SuserVO makeSuserVO(ResultSet rs) throws SQLException {
		SuserVO vo = new SuserVO();
		
		vo.setUserId(rs.getString("user_id"));
		vo.setUserName(rs.getString("user_name"));
		vo.setPwd(rs.getString("pwd"));
		vo.setMobile(rs.getString("mobile"));
		vo.setEmail(rs.getString("email"));
		vo.setBirth(rs.getString("birth"));
		
		return vo;
		
	}
}
