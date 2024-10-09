package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.CommonUtil;
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
				+ "'"+dto.getImage_dir()+"', '"+dto.getS_no()+"', '"+dto.getPrice()+"')";
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
	
	//인덱스 목록
	public ArrayList<salesDto> getIndexView(String gubun){
		ArrayList<salesDto> dtos = new ArrayList<salesDto>();
		String query = "select * from\n"
				+ "(select rownum, tbl.*\n"
				+ "from\n"
				+ "(select s_no, image_dir, title, to_char(price, '999,999,999')||'원' as price,\n"
				+ "    area, to_char(reg_date, 'YYYY-MM-DD') as reg_date, round((sysdate - reg_date) * 24 * 60) as mm\n"
				+ "from sales\n"
				+ "where status = '1'\n"
				+ "order by "+gubun+" desc\n"
				+ ")tbl)\n"
				+ "where rownum <= 10";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int s_no = rs.getInt("s_no");
				String image_dir = rs.getString("image_dir");
				String title = rs.getString("title");
				String price = rs.getString("price");
				String area = rs.getString("area");
				if(area == null) area = "";
				
				//시간 계산 
				int mm = rs.getInt("mm"); // 현재시간 - 등록시간 분으로
				String reg_date = "";
				if(mm > 24 * 60 * 7) {
					reg_date = "2023-10-23";
					
				} else if(mm < 60){
					reg_date = Integer.toString(mm) + "분 전";
					
				} else if(mm < 24 * 60) {
					int time = mm / 60;
					reg_date = Integer.toString(time) + "시간 전";
					
				} else if(mm < 24 * 60 * 7) {
					int time = mm / (24 * 60);
					reg_date = Integer.toString(time) + "일 전";
				}
				
				salesDto dto = new salesDto(title, area, reg_date, image_dir, price, s_no);
				dtos.add(dto);
			}
		} catch(Exception e) {
			System.out.println("getIndexLikes method 오류!");
			System.out.println(query);
			e.printStackTrace();
		}
		return dtos;
	}
}
