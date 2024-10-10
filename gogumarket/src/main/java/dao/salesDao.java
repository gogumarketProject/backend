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
	public int WishListCheck(int s_no, String id) {
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
	public int OnLikes(int s_no, String id) {
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
	public int OffLikes(int s_no, String id) {
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
				+ "(select s_no, image_dir, title, to_char(price, '999,999,999')||'원' as price, area,\n"
				+ "        CASE\n"
				+ "           WHEN (SYSDATE - reg_date) * 24 * 60 < 60 THEN ROUND((SYSDATE - reg_date) * 24 * 60, 0) || '분 전' -- 1시간 미만\n"
				+ "           WHEN (SYSDATE - reg_date) * 24 < 24 THEN ROUND((SYSDATE - reg_date) * 24, 0) || '시간 전' -- 24시간 미만\n"
				+ "           WHEN (SYSDATE - reg_date) < 7 THEN ROUND(SYSDATE - reg_date, 0) || '일 전' -- 7일 미만\n"
				+ "           WHEN (SYSDATE - reg_date) < 30 THEN ROUND((SYSDATE - reg_date) / 7, 0) || '주 전' -- 7일 이상, 30일 미만\n"
				+ "           ELSE to_char(reg_date,'yyyy-MM-dd')  -- 30일 이상\n"
				+ "        END AS reg_date\n"
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
				String reg_date = rs.getString("reg_date");
				
				
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
	
	//상품 상세보기 불러오기
	   public salesDto ProductView(int s_no) {
	      salesDto dto = null;
	      String query = "SELECT s_no, s_id,c.c_name, title, contents, status, product_status,\r\n" + 
	      		"       to_char(price, '999,999,999')||'원' as price, -- 천의 자리마다 ',' 포맷\r\n" + 
	      		"       trade, area, likes, image_dir,\r\n" + 
	      		"       CASE\r\n" + 
	      		"           WHEN (SYSDATE - reg_date) * 24 * 60 < 60 THEN ROUND((SYSDATE - reg_date) * 24 * 60, 0) || '분 전' -- 1시간 미만\r\n" + 
	      		"           WHEN (SYSDATE - reg_date) * 24 < 24 THEN ROUND((SYSDATE - reg_date) * 24, 0) || '시간 전' -- 24시간 미만\r\n" + 
	      		"           WHEN (SYSDATE - reg_date) < 7 THEN ROUND(SYSDATE - reg_date, 0) || '일 전' -- 7일 미만\r\n" + 
	      		"           WHEN (SYSDATE - reg_date) < 30 THEN ROUND((SYSDATE - reg_date) / 7, 0) || '주 전' -- 7일 이상, 30일 미만\r\n" + 
	      		"           ELSE to_char(reg_date,'yyyy-MM-dd')  -- 30일 이상\r\n" + 
	      		"       END AS reg_date\r\n" + 
	      		"FROM sales s, category c\r\n" + 
	      		"where s_no = '"+s_no+"'\r\n" + 
	      		"and c.category_id = s.category_id";
	      try {
	         con = DBConnection.getConnection();
	         ps = con.prepareStatement(query);
	         rs = ps.executeQuery();
	         
	         if(rs.next()) {
	            String s_id = rs.getString("s_id");
	            String category_id = rs.getString("c_name");
	            String title = rs.getString("title");
	            String contents = rs.getString("contents");
	            String status = rs.getString("status");
	            if(status.equals("1")) status = "예약중";
	            else if(status.equals("2")) status = "판매중";
	            else if(status.equals("3")) status = "예약완료";
	            String product_status = rs.getString("product_status");
	            if(product_status.equals("1")) product_status = "중고";
	            else if(product_status.equals("2")) product_status = "새 상품";
	            String price = rs.getNString("price");
	            String trade = rs.getString("trade");
	            if(trade.equals("1")) trade = "직거래";
	            else if(trade.equals("2")) trade = "택배거래";
	            else if(trade.equals("3")) trade = "직거래 | 택배";
	            String area = rs.getString("area");
	            int likes = rs.getInt("likes");
	            String reg_date = rs.getNString("reg_date");
	            String image_dir = rs.getNString("image_dir");
	            dto = new salesDto(s_id, category_id, title, contents, status, product_status, trade, area, reg_date, image_dir, s_no, price, likes);
	         }
	      } catch(Exception e) {
	         System.out.println("ProductView method 오류!");
	         System.out.println(query);
	         e.printStackTrace();
	      } finally {
	         DBConnection.closeDB(con, ps, rs);
	      }
	      
	      return dto ;
	   }
	   
	 //인덱스 목록
		public ArrayList<salesDto> getViewLikesDtos(String likes){
			ArrayList<salesDto> dtos = new ArrayList<salesDto>();
			String query = "select * from\n"
					+ "(select rownum, tbl.*\n"
					+ "from\n"
					+ "(select s_no, image_dir, title, to_char(price, '999,999,999')||'원' as price, area,\n"
					+ "        CASE\n"
					+ "           WHEN (SYSDATE - reg_date) * 24 * 60 < 60 THEN ROUND((SYSDATE - reg_date) * 24 * 60, 0) || '분 전' -- 1시간 미만\n"
					+ "           WHEN (SYSDATE - reg_date) * 24 < 24 THEN ROUND((SYSDATE - reg_date) * 24, 0) || '시간 전' -- 24시간 미만\n"
					+ "           WHEN (SYSDATE - reg_date) < 7 THEN ROUND(SYSDATE - reg_date, 0) || '일 전' -- 7일 미만\n"
					+ "           WHEN (SYSDATE - reg_date) < 30 THEN ROUND((SYSDATE - reg_date) / 7, 0) || '주 전' -- 7일 이상, 30일 미만\n"
					+ "           ELSE to_char(reg_date,'yyyy-MM-dd')  -- 30일 이상\n"
					+ "        END AS reg_date\n"
					+ "from sales\n"
					+ "where status = '1'\n"
					+ "order by "+likes+" desc\n"
					+ ")tbl)\n"
					+ "where rownum <= 3";
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
					String reg_date = rs.getString("reg_date");
					
					
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
