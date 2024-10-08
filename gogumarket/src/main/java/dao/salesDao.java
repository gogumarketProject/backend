package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnection;
import dto.salesDto;

public class salesDao {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	//판매등록 번호 생성
	public int getSaleNo() {
		int newNo = 0;
		String query = "select nvl(max(s_no), '0') + 1 as s_no\n"
				+ "from sales";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			if(rs.next()) {
				newNo = rs.getInt("s_no");
			}
		} catch(Exception e) {
			System.out.println("getSaleNo() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return newNo;
	}
	
	//판매등록
	public int uploadSales(salesDto dto) {
		int result = 0;
		String query = "insert into sales\n"
				+ "(s_id, category_id, title, contents, product_status, trade, area, reg_date, image_dir, s_no, price)\n"
				+ "values\n"
				+ "('"+dto.getS_id()+"', '"+dto.getCategory_id()+"', '"+dto.getTitle()+"', '"+dto.getContents()+"',\n"
				+ "'"+dto.getProduct_status()+"', '"+dto.getTrade()+"', '"+dto.getArea()+"', to_date('"+dto.getReg_date()+"', 'yyyy-MM-dd HH24:mi:ss'),\n"
				+ "'"+dto.getImageDir()+"', '"+dto.getS_no()+"', '"+dto.getPrice()+"')";
		System.out.println(query);
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("uploadSales() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return result;
	}
	
	//찜 하기 전에 찜목록 테이블에 있는지 없는지 확인
	public int WishListCheck(String s_no, String id) {
		int result = 0;
		String query = "select count(*) as count from wish_list\n" + 
				"where s_no = "+s_no+"\n" + 
				"and id = '"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("count");
			}
		} catch(Exception e) {
			System.out.println("OnOffLikes() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	// 찜 추가
	public int OnLikes(String s_no, String id) {
		int result = 0;
		String updatequery = "UPDATE sales\n" + 
				"SET likes = likes + 1\n" + 
				"WHERE s_no = '"+s_no+"'";
		String insertquery = "insert into wish_list\n" + 
				"(id, s_no)\n" + 
				"values \n" + 
				"('"+id+"','"+s_no+"')";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(updatequery);
			int middelresult = ps.executeUpdate();
			if(middelresult != 0) {
				ps = con.prepareStatement(insertquery);
				result = ps.executeUpdate();
			}
		} catch(Exception e) {
			System.out.println("OnLikes method 오류!");
			System.out.println(insertquery);
			System.out.println(updatequery);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	//찜 제거
	public int OffLikes(String s_no, String id) {
		int result = 0;
		String updatequery = "UPDATE sales\n" + 
				"SET likes = likes - 1\n" + 
				"WHERE s_no = '"+s_no+"'"; 
		
		String deletequery = "delete wish_list\n" + 
				"where s_no = '"+s_no+"'\n" + 
				"and id = '"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(updatequery);
			int middelresult = ps.executeUpdate();
			if(middelresult != 0) {
				ps = con.prepareStatement(deletequery);
				result = ps.executeUpdate();
			}
		} catch(Exception e) {
			System.out.println("OnLikes method 오류!");
			System.out.println(updatequery);
			System.out.println(deletequery);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
}
