package dto;

public class memberDto {
	private String id;
	private int name;
	
	public memberDto(String id, int name) {
		super();
		this.id = id;
		this.name = name;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public int getName() {
		return name;
	}
	
	public void setName(int name) {
		this.name = name;
	}
	
}
