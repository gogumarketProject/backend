package common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommonUtil {
	
	//Images Directory
	public static String getImageDir() {
		String dir = "/Users/minseok/Documents/문서/gitHub/backend/gogumarket/src/main/webapp/resources/images/";
		return dir;
	}
	//getTodayTime yyyy-MM-dd
	public static String getToday() {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(date);
		
		return today;
	}
	//getTodayTime yyyy-MM-dd HH:mm:ss
	public static String getTodayTime() {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = dateFormat.format(date);			
		return today;
	}
	// 페이지 설정
	public static String pageListPost(int current_page,int total_page, int pageNumber_count){
		int pagenumber;    //화면에 보여질 페이지 인덱스수
		int startpage;     //화면에 보여질 시작 페이지 번호
		int endpage;       //화면에 보여질 마지막 페이지 번호
		int curpage;       //이동하고자 하는 페이지 번호
		
		String strList=""; //리턴될 페이지 인덱스 리스트

		pagenumber = pageNumber_count;   //한 화면의 페이지 인덱스수
		
		//시작 페이지 번호 구하기
		startpage = ((current_page - 1)/ pagenumber) * pagenumber + 1;
		//마지막 페이지 번호 구하기
		endpage = (((startpage -1) + pagenumber) / pagenumber)*pagenumber;
		//총페이지수가 계산된 마지막 페이지 번호보다 작을 경우
		//총페이지수가 마지막 페이지 번호가 됨
		
		if(total_page <= endpage)  endpage = total_page;
					
		//첫번째 페이지 인덱스 화면이 아닌경우
		if(current_page > pagenumber){
			curpage = startpage -1;  //시작페이지 번호보다 1적은 페이지로 이동
			strList = strList +"<div data-page='"+curpage+"'><i class='fa-solid fa-angle-left'></i></div>";
		}
						
		//시작페이지 번호부터 마지막 페이지 번호까지 화면에 표시
		curpage = startpage;
		while(curpage <= endpage){
			if(curpage == current_page){
				strList = strList +"<div class='active' data-page='"+curpage+"'>"+current_page+"</div>";
			} else {
				strList = strList +"<div data-page='"+curpage+"'>"+curpage+"</div>";
			}
			curpage++;
		}
		//뒤에 페이지가 더 있는 경우
		if(total_page > endpage){
			curpage = endpage+1;
			strList = strList + "<div data-page='"+curpage+"'><i class='fa-solid fa-angle-right'></i></div>";
		}
		return strList;
	}			
}
