package edu.polytechnique.inf553;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Postgresql {
	// TODO delete this main function when you think you fully understand
	public static void main(String[] args) throws Exception {
		queryIndex("2010", 0, 10);
	}

	/**
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static ArrayList<QueryInfo> queryIndex(String production_year, int page, int rowsPerPage) throws ClassNotFoundException, SQLException {
		// 加载驱动
		Class.forName("org.postgresql.Driver");
		// 获得连接对象: 注意：mydb是数据库；postgres：用户名; 123456:密码
		String url = "jdbc:postgresql://127.0.0.1:5432/postgres";
		Connection connection = null; // 连接接口实例
		Statement statmment = null; // 执行静态sql的接口实例
		PreparedStatement preStatement = null; // 执行动态sql的接口实例
		ResultSet resultSet = null; // sql查询的返回数据集合
		connection = DriverManager.getConnection(url);
		statmment = connection.createStatement();
		String querySqlString = "SELECT P.id, P.name, P.gender, COUNT(M.id) as movie_nr" + 
								" FROM person P, actors_info A, movie M" + 
								" WHERE P.id = A.person_id" + 
								" AND M.id = A.movie_id AND M.production_year =?" + 
								" GROUP BY P.id" + 
								" ORDER BY movie_nr DESC" + 
								" LIMIT ? OFFSET ?;";
		// System.out.println(con);
		// 预编译对象
		PreparedStatement ps = connection.prepareStatement(querySqlString);
		
		ps.setString(1, production_year);
		ps.setInt(2, rowsPerPage);
		ps.setInt(3, (page - 1) * rowsPerPage);
		// 返回结果集
		ResultSet rs = ps.executeQuery();
		// 遍历数据
		ArrayList<QueryInfo> resultList = rsToArrayList(rs);
		// 关闭连接
		rs.close();
		ps.close();
		connection.close();
		return resultList;
	}
	
	public static ArrayList<QueryInfo> rsToArrayList(ResultSet rs) throws SQLException {
		ArrayList<QueryInfo> resultList = new ArrayList<>();
		if (rs == null)
			return null;
		while (rs.next()) {
			String p_id = rs.getString("id");
			String p_name = rs.getString("name");
			String p_gender = rs.getString("gender");
			int movie_nr = rs.getInt("movie_nr");
			resultList.add(new QueryInfo(p_id, p_name, p_gender, movie_nr));
		}
		return resultList;

	}
	
	public static int queryTotalPages(String production_year, int rowsPerPage) throws ClassNotFoundException, SQLException {
		// 加载驱动
		Class.forName("org.postgresql.Driver");
		// 获得连接对象: 注意：mydb是数据库；postgres：用户名; 123456:密码
		String url = "jdbc:postgresql://127.0.0.1:5432/postgres";
		Connection connection = null; // 连接接口实例
		Statement statmment = null; // 执行静态sql的接口实例
		PreparedStatement preStatement = null; // 执行动态sql的接口实例
		ResultSet resultSet = null; // sql查询的返回数据集合
		connection = DriverManager.getConnection(url);
		statmment = connection.createStatement();
		String querySqlString = "SELECT COUNT(DISTINCT A.person_id) as nPersons" +
				 " FROM actors_info A, movie M" +
				 " WHERE M.id = A.movie_id AND M.production_year = ?;";
		// System.out.println(con);
		// 预编译对象
		PreparedStatement ps = connection.prepareStatement(querySqlString);
		
		ps.setString(1, production_year);
		// 返回结果集
		ResultSet rs = ps.executeQuery();
		int totalPages = 1;
        while(rs.next()){
        	totalPages = (int)Math.ceil(rs.getInt("nPersons")/(double)rowsPerPage);
        }

		// 关闭连接
		rs.close();
		ps.close();
		connection.close();
		return totalPages;
	}

	public static PersonInfo queryPersonInfo(String pid) throws ClassNotFoundException, SQLException {
		// 加载驱动
		Class.forName("org.postgresql.Driver");
		// 获得连接对象: 注意：mydb是数据库；postgres：用户名; 123456:密码
		String url = "jdbc:postgresql://127.0.0.1:5432/postgres";
		Connection connection = null; // 连接接口实例
		Statement statmment = null; // 执行静态sql的接口实例
		PreparedStatement preStatement = null; // 执行动态sql的接口实例
		ResultSet resultSet = null; // sql查询的返回数据集合
		connection = DriverManager.getConnection(url);
		statmment = connection.createStatement();
		String queryGender = "SELECT P.gender, P.name" + 
				" FROM person P" + 
				" WHERE P.id = " + pid +";";
		
		ResultSet rsGender = statmment.executeQuery(queryGender);
		String gender = null;
		String name = null;
		while (rsGender.next()) {
			gender = rsGender.getString("gender");
			name =  rsGender.getString("name");
		}
		rsGender.close();
		
		
		String queryBirthday = "SELECT P.info" +
							   " FROM person_info P" +
							   " WHERE P.info_type_id = 21 AND P.id = " + pid;
		ResultSet rsBirthday = statmment.executeQuery(queryBirthday);
		String birthyear = null;
		while (rsBirthday.next()) {
			String birthday = rsBirthday.getString("info");
			// get the birth year
			birthyear = birthday.substring(birthday.length() - 4);
		}
		rsBirthday.close();

		PersonInfo personInfo = new PersonInfo(pid, gender, name, birthyear);

		connection.close();
		return personInfo;
	}

	public static ArrayList<MovieInfo> queryMovieInfo(String pid) throws ClassNotFoundException, SQLException {
		// 加载驱动
		Class.forName("org.postgresql.Driver");
		// 获得连接对象: 注意：mydb是数据库；postgres：用户名; 123456:密码
		String url = "jdbc:postgresql://127.0.0.1:5432/postgres";
		Connection connection = null; // 连接接口实例
		Statement statmment = null; // 执行静态sql的接口实例
		PreparedStatement preStatement = null; // 执行动态sql的接口实例
		ResultSet resultSet = null; // sql查询的返回数据集合
		connection = DriverManager.getConnection(url);
		statmment = connection.createStatement();
		
		String queryMovies = "SELECT DISTINCT M.id, M.title" + 
				" FROM movie M, cast_info cf" + 
				" WHERE cf.movie_id = M.id AND cf.person_id = " + pid +";";
		
		ResultSet rsMovies = statmment.executeQuery(queryMovies);
		ArrayList<MovieInfo> movieList = new ArrayList<>();
		while (rsMovies.next()) {
			movieList.add(new MovieInfo(rsMovies.getString("id"), rsMovies.getString("title")));
		}
		rsMovies.close();
		connection.close();
		return movieList;
	}
}
