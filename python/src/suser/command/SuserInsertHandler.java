package suser.command;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import suser.service.SuserInsertService;

public class SuserInsertHandler implements  CommandHandler{
	private static final String FORM_VIEW = "suser.do";
	private SuserInsertService suserInsertService = SuserInsertService.getInstance();
	
//	req : 받아온다
//	res : 보내준다
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return processForm(req,res);
		}else if(req.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(req,res);
		}else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
		
		
	}
	
	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}
	
	private String processSubmit(HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		String userId  = req.getParameter("userId");
		String pwd  = req.getParameter("pwd");
		String userName  = req.getParameter("userName");
		String mobile  = req.getParameter("mobile");
		String email  = req.getParameter("email");
		String birth  = req.getParameter("birth");
		
		try {
			suserInsertService.SuserInsert(userId, pwd, userName, mobile, email, birth);
			return FORM_VIEW;			
		}catch(SQLException e) {
			e.getMessage();
			return FORM_VIEW;			
			
		}
	}
}
