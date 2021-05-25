package mvc.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class ControllerUsingURI extends HttpServlet{
	private Map<String , CommandHandler> commandHandlerMap = new HashMap<>();
	
//	init()	
	public void init() throws ServletException{
		///WEB-INF/commandHandlerURI.properties
		String configFile = getInitParameter("configFile");
		Properties prop = new Properties();
		//D:\A_TeachingMaterial\6.JspSpring\workspace\board\WebContent\WEB-INF\commandHandlerURI.properties
		String configFilePath = getServletContext().getRealPath(configFile);
		try (FileReader fis = new FileReader(configFilePath)){
			prop.load(fis);
		}catch(IOException e) {
			throw new ServletException(e);
		}
		Iterator keyIter = prop.keySet().iterator();
		while(keyIter.hasNext()){
			String command = (String)keyIter.next(); //join.do
			String handlerClassName = prop.getProperty(command); //member.command.JoinHadler
			try {
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handlerInstance = (CommandHandler)handlerClass.newInstance();
				commandHandlerMap.put(command, handlerInstance);
			}catch (ClassNotFoundException | InstantiationException | IllegalAccessException e  ) {
				throw new ServletException(e);
			}
		}
	}
	


//	doGet()
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException{
		process(request, response);
	}
	
//	doPost()
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		process(request, response);
	}
	
   private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   //board/join.do
	      String command = request.getRequestURI();
	      System.out.println("command : " + command);
	      //board
	      if(command.indexOf(request.getContextPath())==0) {
	    	  //command :/join.do
	         command =  command.substring(request.getContextPath().length());
	         System.out.println("command : substring : " + command.substring(request.getContextPath().length()));
	      }
	      CommandHandler handler = commandHandlerMap.get(command);
//		      if(handler == null) {
//		         handler = new NullHandler();
//		      }
	      
	      String viewPage = null;
	      try {
	    	  
	    	  //viewPage = "WEB-INF/view/joinForm.jsp"
	         viewPage = handler.process(request, response);
	      }catch(Throwable e) {
	         throw new ServletException(e);
	      }
	      
	      if(viewPage != null) {
	         RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
	         dispatcher.forward(request, response); 
	      }
   }
}
