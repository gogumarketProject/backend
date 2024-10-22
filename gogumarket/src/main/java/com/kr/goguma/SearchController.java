package com.kr.goguma;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import common.CommonUtil;
import dao.salesDao;
import dto.salesDto;

@Controller
public class SearchController {
	
	// 검색, 메뉴바-카테고리
		@RequestMapping(value = "search", method = { RequestMethod.GET, RequestMethod.POST })
		
		public void searchList(
				@RequestParam(value = "search", required = false) String search,
				@RequestParam(value = "categoryId", required = false) String categoryId,
				@RequestParam(value = "minPrice",required = false) String minPrice,
				@RequestParam(value = "maxPrice",required = false) String maxPrice,
				@RequestParam(value = "trade",required = false) String trade,
				@RequestParam(value = "status",required = false) String status,
				@RequestParam(value = "sort",required = false) String sort,
				@RequestParam(value = "page",required = false) String page,
				HttpServletResponse response
				){
			salesDao dao = new salesDao();
			ObjectMapper mapper = new ObjectMapper();
		    // 기본값 처리
		    if(search == null) search = "";
		    if(categoryId == null) categoryId = "";
		    if (minPrice == null || minPrice.equals("")) minPrice = "0";
		    if (maxPrice == null || maxPrice.equals("")) maxPrice = "99999999";
		    if (sort.equals("recent")) sort = "s_no desc";
		    if (sort.equals("likes")) sort = "likes desc";
		    if (sort.equals("low-price")) sort = "price asc";
		    if (sort.equals("high-price")) sort = "price desc";


		    
			/* paging 설정 start*/
			int totalCount = dao.getTotalCount(search, categoryId, minPrice, maxPrice, trade, status);
			int list_setup_count = 5;  //한페이지당 출력 (행 * 열) 수
			int pageNumber_count = 2;  //한페이지당 출력 페이지 갯수
			
			int current_page = 0; // 현재페이지 번호
			int total_page = 0;    // 전체 페이지 수
			
			if(page == null) current_page = 1; 
			else current_page = Integer.parseInt(page);
			
			total_page = totalCount / list_setup_count;  // 몫 : 2
			int rest = 	totalCount % list_setup_count;   // 나머지:1
			if(rest !=0) total_page = total_page + 1;     // 3
			
			int start = (current_page -1) * list_setup_count + 1;
			int end   = current_page * list_setup_count;
			String pageDis = CommonUtil.pageListPost(current_page, total_page, pageNumber_count);
			/* paging 설정 end*/
			
			// 목록 불러오기
			ArrayList<salesDto> dtos = dao.getSeachView(start, end, search, categoryId, minPrice, maxPrice, trade, status, sort);
			
			// 세 객체를 배열에 담기
			Object[] responseArray = new Object[]{dtos, pageDis, totalCount};
			
			
			
			try {
				response.getWriter().print(mapper.writeValueAsString(responseArray));
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}
