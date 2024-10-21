package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	      String query = "SELECT s_no, s_id,s.category_id,c.c_name, title, contents, status, product_status,\r\n" + 
	      		"       to_char(price, '999,999,999') as price, -- 천의 자리마다 ',' 포맷\r\n" + 
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
	            String category_id = rs.getString("category_id");
	            String c_name = rs.getString("c_name");
	            String title = rs.getString("title");
	            String contents = rs.getString("contents");
	            String status = rs.getString("status");
	            if(status.equals("1")) status = "판매중";
	            else if(status.equals("2")) status = "예약중";
	            else if(status.equals("3")) status = "판매완료";
	            String product_status = rs.getString("product_status");
	            if(product_status.equals("1")) product_status = "중고";
	            else if(product_status.equals("2")) product_status = "새 상품";
	            String price = rs.getNString("price");
	            String trade = rs.getString("trade");
	            if(trade.equals("1")) trade = "택배거래";
	            else if(trade.equals("2")) trade = "직거래";
	            else if(trade.equals("3")) trade = "직거래 | 택배";
	            String area = rs.getString("area");
	            int likes = rs.getInt("likes");
	            String reg_date = rs.getNString("reg_date");
	            String image_dir = rs.getNString("image_dir");
	            dto = new salesDto(s_id, category_id, c_name,title, contents, status, product_status, trade, area, reg_date, image_dir, s_no, price, likes);
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
	   
	 //상품 상세보기 불러오기
	   public salesDto UpdateProductView(int s_no) {
	      salesDto dto = null;
	      String query = "SELECT s_no, s_id,s.category_id,c.c_name, title, contents, status, product_status,\r\n" + 
	      		"       price,\r\n" + 
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
	            String category_id = rs.getString("category_id");
	            String c_name = rs.getString("c_name");
	            String title = rs.getString("title");
	            String contents = rs.getString("contents");
	            String status = rs.getString("status");
	            if(status.equals("1")) status = "판매중";
	            else if(status.equals("2")) status = "에약중";
	            else if(status.equals("3")) status = "판매완료";
	            String product_status = rs.getString("product_status");
	            if(product_status.equals("1")) product_status = "중고";
	            else if(product_status.equals("2")) product_status = "새 상품";
	            String price = rs.getNString("price");
	            String trade = rs.getString("trade");
	            if(trade.equals("1")) trade = "택배거래";
	            else if(trade.equals("2")) trade = "직거래";
	            else if(trade.equals("3")) trade = "직거래 | 택배";
	            String area = rs.getString("area");
	            int likes = rs.getInt("likes");
	            String reg_date = rs.getNString("reg_date");
	            String image_dir = rs.getNString("image_dir");
	            dto = new salesDto(s_id, category_id, c_name,title, contents, status, product_status, trade, area, reg_date, image_dir, s_no, price, likes);
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
		public ArrayList<salesDto> getViewLikesDtos(int s_no){
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
					+ "where status = '1'\r\n"  
					+ "and s_no NOT IN ("+s_no+")"
					+ "order by likes desc\n"
					+ ")tbl)\n"
					+ "where rownum <= 3";
			try {
				con = DBConnection.getConnection();
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				while(rs.next()) {
					s_no = rs.getInt("s_no");
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
	   
	//검색, 목록(게시물 총 개수) -- 페이징
	public int getTotalCount(String search, String category_id, String min_price, String max_price, String trade,
			String product_status) {
		int count = 0;
		String query = "select count(*) as count\n"
				+ "from sales\n"
				+ "where (title like '%"+search+"%' or contents like '%"+search+"%' or area like'%"+search+"%')\n"
				+ "and category_id like '%"+category_id+"%'\n"
				+ "and trade like '%"+trade+"%'\n"
				+ "and product_status like '%"+product_status+"%'\n"
				+ "and price >= "+min_price+"\n"
				+ "and price <= " + max_price;
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch(Exception e) {
			System.out.println("getTotalCount() Method Error");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return count;
	}
	
	//검색 및 목록 게시물 불러오기
	public ArrayList<salesDto> getSeachView(int start, int end, String search, String category_id, String min_price,
			String max_price, String trade, String product_status, String sort) {
		ArrayList<salesDto> dtos = new ArrayList<salesDto>();
		String query = "select * from(\n"
				+ "select rownum as rnum, tbl.*\n"
				+ "from(\n"
				+ "select s_no, image_dir, title, to_char(price, '999,999,999')||'원' as price, area,\n"
				+ "        CASE\n"
				+ "           WHEN (SYSDATE - reg_date) * 24 * 60 < 60 THEN ROUND((SYSDATE - reg_date) * 24 * 60, 0) || '분 전' -- 1시간 미만\n"
				+ "           WHEN (SYSDATE - reg_date) * 24 < 24 THEN ROUND((SYSDATE - reg_date) * 24, 0) || '시간 전' -- 24시간 미만\n"
				+ "           WHEN (SYSDATE - reg_date) < 7 THEN ROUND(SYSDATE - reg_date, 0) || '일 전' -- 7일 미만\n"
				+ "           WHEN (SYSDATE - reg_date) < 30 THEN ROUND((SYSDATE - reg_date) / 7, 0) || '주 전' -- 7일 이상, 30일 미만\n"
				+ "           ELSE to_char(reg_date,'yyyy-MM-dd')  -- 30일 이상\n"
				+ "        END AS reg_date\n"
				+ "from sales\n"
				+ "where (title like '%"+search+"%' or contents like '%"+search+"%' or area like'%"+search+"%')\n"
				+ "and category_id like '%"+category_id+"%'\n"
				+ "and trade like '%"+trade+"%'\n"
				+ "and product_status like '%"+product_status+"%'\n"
				+ "and price >= "+min_price+"\n"
				+ "and price <= "+max_price+"\n"
				+ "order by "+sort+"\n"
				+ ")tbl)\n"
				+ "where rnum >= "+start+" and rnum <= "+end;
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
			System.out.println("getSearchView() Method Error");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
	}
	
	
	//물품 수정
	public int updateSales(salesDto dto) {
		int result = 0;
		String query = "update sales\r\n" + 
				"set title = '"+dto.getTitle()+"',\r\n" + 
				"price = "+dto.getPrice()+",\r\n" + 
				"category_id = '"+dto.getCategory_id()+"',\r\n" + 
				"contents = '"+dto.getContents()+"',\r\n" + 
				"product_status = '"+dto.getProduct_status()+"',\r\n" + 
				"trade = '"+dto.getTrade()+"',\r\n" + 
				"area = '"+dto.getArea()+"'\r\n" + 
				"where s_no = '"+dto.getS_no()+"'";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("updateSales() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		
		return result;
	}
	
	
	//물품 삭제
	public int DeleteSales(int s_no) {
		int result = 0;
		String query = "delete sales\r\n" + 
				"where s_no = "+s_no+"";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("DeleteSales() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	//이 사람이 제의를 했었는지 안했는지 검사
	public int SearchOfferPrice(int s_no, String id) {
		int result = 0;
		String query = "select s_no, id, offer_price\r\n" + 
				"from offer_price\r\n" + 
				"where s_no = "+s_no+"\r\n" + 
				"and id = '"+id+"'";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("SearchOfferPrice() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	// 가격제안
	public int InsertOffer(int s_no, String id, int offer_price) {
		int result = 0;
		String query = "insert into offer_price\r\n" + 
				"(s_no,id,offer_price)\r\n" + 
				"values\r\n" + 
				"("+s_no+",'"+id+"',"+offer_price+")";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("InsertOffer() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	//가격 제안 수정
	public int UpdateOffer(int s_no, String id, int offer_price) {
		int result = 0;
		String query = "update offer_price\r\n" + 
				"set offer_price = "+offer_price+"\r\n" + 
				"where id = '"+id+"'\r\n" + 
				"and s_no = "+s_no+"";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("UpdateOffer() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
	
	//해당글에 오퍼한사람 리스트
	public ArrayList<salesDto> getOfferList(int s_no) {
		ArrayList<salesDto> dtos = new ArrayList<salesDto>();
		String query = "select id, offer_price\r\n" + 
				"from offer_price\r\n" + 
				"where s_no = "+s_no+"\r\n" + 
				"order by offer_price desc";
		
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				String id = rs.getNString("id");
				int offer_price = rs.getInt("offer_price");
				salesDto dto = new salesDto(id, Integer.toString(offer_price));
				dtos.add(dto);
			}
		} catch(Exception e) {
			System.out.println("getOfferList() Method Error");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return dtos;
	}

	//물건 거래상태 변경
	public int ChangeStatus(int s_no, String status) {
		int result = 0;
		String query = "update sales\r\n" + 
				"set status = '"+status+"'\r\n" + 
				"where s_no = "+s_no+"";
		try {
			con = DBConnection.getConnection();
			ps = con.prepareStatement(query);
			result = ps.executeUpdate();
		} catch(Exception e) {
			System.out.println("ChangeStatus() method 오류!");
			System.out.println(query);
			e.printStackTrace();
		} finally {
			DBConnection.closeDB(con, ps, rs);
		}
		return result;
	}
}
