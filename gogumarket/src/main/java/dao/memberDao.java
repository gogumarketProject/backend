package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DBConnection;

public class memberDao {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public int saveMember(String email, int i) {
		int result = 0;
		String query = "insert into member\n"
				+ "(id,name)\n"
				+ "values\n"
				+ "('"+email+"',"+i+")";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("saveMember() 오류 : "+query);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return result;
	}
	
	
	public boolean isExistingUser(String email) {
	    String query = "SELECT COUNT(*) FROM member WHERE id = ?";
	    try {
	    	con = DBConnection.getConnection();
	        ps = con.prepareStatement(query);
	        ps.setString(1, email);
	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next() && rs.getInt(1) > 0; // 1 이상이면 존재하는 이메일
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }finally {
	    	DBConnection.closeDB(con, ps, rs);
	    }
	}

}
