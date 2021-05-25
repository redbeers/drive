package jdbc;

import java.io.IOException;
import java.io.StringReader;
import java.sql.DriverManager;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.DriverManagerConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnection;
import org.apache.commons.dbcp2.PoolableConnectionFactory;
import org.apache.commons.dbcp2.PoolingDriver;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;

public class DBCPInitListener implements ServletContextListener{
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		String poolconfig = 
				sce.getServletContext().getInitParameter("poolConfig");
		Properties prop = new Properties();
		try {
			prop.load(new StringReader(poolconfig));
		}catch(IOException e) {
			throw new RuntimeException("config load fail",e);
		}
		loadJDBCDriver(prop);
		initConnectPool(prop);
	}
	private void loadJDBCDriver(Properties prop) {
		String driverClass = prop.getProperty("jdbcdriver"); //oracle.jdbc.driver.OracleDriver
		try {
			Class.forName(driverClass);
		}catch (ClassNotFoundException ex) {
			throw new RuntimeException("fail to load JDBC Driver", ex);
		}
	}
	private void initConnectPool(Properties prop) {
		try {
			String jdbcUrl = prop.getProperty("jdbcUrl");
			String username= prop.getProperty("dbUser");
			String pw = prop.getProperty("dbPass");
			
			ConnectionFactory connFactory = new DriverManagerConnectionFactory(jdbcUrl,username,pw);
			PoolableConnectionFactory poolableConnFactory = 
					new PoolableConnectionFactory(connFactory, null);
			String validationQuery = prop.getProperty("validationQuery");//select 1
			if(validationQuery != null && !validationQuery.isEmpty()){
				poolableConnFactory.setValidationQuery(validationQuery);
			}
			GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
			poolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L * 5L);
			poolConfig.setTestWhileIdle(true);
			int minIdel = Integer.parseInt(prop.getProperty("minIdle"));
			poolConfig.setMinIdle(minIdel);
			int maxTotal = Integer.parseInt(prop.getProperty("maxTotal"));
			poolConfig.setMaxTotal(maxTotal);
			
			GenericObjectPool<PoolableConnection> connectionPool = 
		               new GenericObjectPool<>(poolableConnFactory, poolConfig);
		         poolableConnFactory.setPool(connectionPool);
			
			Class.forName("org.apache.commons.dbcp2.PoolingDriver");
			PoolingDriver driver = (PoolingDriver)DriverManager.getDriver("jdbc:apache:commons:dbcp:");
			String poolName = prop.getProperty("poolName");
			driver.registerPool(poolName, connectionPool);
			
			
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}
}
