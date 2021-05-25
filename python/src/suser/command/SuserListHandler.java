package suser.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import suser.model.SuserVO;
import suser.service.SuserListService;

public class SuserListHandler implements CommandHandler {
	private static final String FORM_VIEW = "/WEB-INF/view/suser.jsp";
	private SuserListService getSuserListService = SuserListService.getInstance();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		List<SuserVO> suserList = getSuserListService.getSuserList();
		req.setAttribute("suserList", suserList);
		
		
		return FORM_VIEW;
		
	}
	
}
