package dto;

public class salesDto {
	private String s_id, category_id,category_name ,title, contents, status, product_status, trade, area, reg_date, image_dir, price;
	private int s_no, likes;
	
	//판매제안 리스트
	public salesDto(String s_id, String price) {
	this.s_id = s_id;
	this.price = price;
	}
	
	//물품 등록
	public salesDto(String s_id, String category_id, String title, String contents, String product_status, String trade,
	String area, String reg_date, String image_dir, String price, int s_no) {
	super();
	this.s_id = s_id;
	this.category_id = category_id;
	this.title = title;
	this.contents = contents;
	this.product_status = product_status;
	this.trade = trade;
	this.area = area;
	this.reg_date = reg_date;
	this.image_dir = image_dir;
	this.s_no = s_no;
	this.price = price;
	}

	//consumerview에 필요한 dto 추가
	   public salesDto(String s_id, String category_id, String category_name,String title, String contents, String status,
	         String product_status, String trade, String area, String reg_date, String image_dir,
	         int s_no, String price, int likes) {
	      super();
	      this.s_id = s_id;
	      this.category_id = category_id;
	      this.category_name = category_name;
	      this.title = title;
	      this.contents = contents;
	      this.status = status;
	      this.product_status = product_status;
	      this.trade = trade;
	      this.area = area;
	      this.reg_date = reg_date;
	      this.image_dir = image_dir;
	      this.s_no = s_no;
	      this.price = price;
	      this.likes = likes;
	   }

	//IndexView
	public salesDto(String title, String area, String reg_date, String image_dir, String price, int s_no) {
	super();
	this.title = title;
	this.area = area;
	this.reg_date = reg_date;
	this.image_dir = image_dir;
	this.s_no = s_no;
	this.price = price;
	}

	public String getS_id() {
		return s_id;
	}
	public String getCategory_id() {
		return category_id;
	}
	public String getTitle() {
		return title;
	}
	public String getContents() {
		return contents;
	}
	public String getStatus() {
		return status;
	}
	public String getProduct_status() {
		return product_status;
	}
	public String getTrade() {
		return trade;
	}
	public String getArea() {
		return area;
	}
	public String getReg_date() {
		return reg_date;
	}
	public String getImage_dir() {
		return image_dir;
	}
	public String getPrice() {
		return price;
	}
	public int getS_no() {
		return s_no;
	}
	public int getLikes() {
		return likes;
	}
	public String getCategory_name() {
		return category_name;
	}
	
}
