package exp5;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 连接数据库
 * 
 * @author xu
 *
 */
public class ConnectionDB {

	private String driver = "com.mysql.jdbc.Driver";

	private String url = "jdbc:mysql://localhost:3306/shopping?useSSL=false";

	private String user = "root";

	private String passwd = "xxq123456";

	public Connection getConnection() {
		try {
			Class.forName(driver);
			return DriverManager.getConnection(url, user, passwd);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static Connection getConnection1() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping?useSSL=false", "root",
					"xxq123456");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public static void main(String[] args) {
		Connection connection = getConnection1();
		Statement stmt;
		try {
			stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("select * from goods");
			while (rs.next()) {
				System.out.print(rs.getInt(1) + "  ");
				System.out.print(rs.getString(2) + "  ");
				System.out.print(rs.getDouble(3) + "  ");
				System.out.print(rs.getInt(4) + "  ");
				System.out.println(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

//		 String url = "jdbc:mysql://localhost:3306/shopping?useSSL=false";
//
//		 String driver = "com.mysql.jdbc.Driver";
//
//		 String user = "root";
//
//		 String passwd = "xxq123456";
//		 try {
//				Class.forName(driver);
//				Connection connection=  DriverManager.getConnection(url, user, passwd);
//				Statement stmt = connection.createStatement();
//				ResultSet rs = stmt.executeQuery("select * from goods");
//				while(rs.next()) {
//					System.out.print(rs.getInt(1)+ "  ");
//					System.out.print(rs.getString(2)+"  ");
//					System.out.print(rs.getDouble(3)+"  ");
//					System.out.print(rs.getInt(4)+"  ");
//					System.out.println(rs.getString(5));
//				}
//			} catch (ClassNotFoundException e) {
//				e.printStackTrace();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}

	}
}
