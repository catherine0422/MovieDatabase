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
		queryIndex("2010");
	}

	/**
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static ArrayList<QueryInfo> queryIndex(String production_year) throws ClassNotFoundException, SQLException {
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
		String querySqlString = "SELECT P.id, P.name, P.gender, COUNT(M.id) as movie_nr\n" + 
								"FROM person P, actors_info A, movie M\n" + 
								"WHERE P.id = A.person_id\n" + 
								"    AND M.id = A.movie_id\n" + String.format("    AND M.production_year = '%s'\n", production_year)+ 
								"GROUP BY P.id\n" + 
								"ORDER BY movie_nr DESC\n" + 
								"LIMIT 20 OFFSET 0;";
		// System.out.println(con);
		// 预编译对象
		PreparedStatement ps = connection.prepareStatement(querySqlString);
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

		// TODO
		// Write the query to get the info

		// System.out.println(con);
		// 预编译对象
		// PreparedStatement ps = connection.prepareStatement(querySqlString);
		// 返回结果集
		// ResultSet rs = ps.executeQuery();
		// 遍历数据
		// TODO change this!
		PersonInfo result = new PersonInfo("123", "kunhao", "Kunhao", "1998");
		// 关闭连接
		// rs.close();
		// ps.close();
		connection.close();
		return result;
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

		// TODO
		// Write the query to get the info

		// System.out.println(con);
		// 预编译对象
		// PreparedStatement ps = connection.prepareStatement(querySqlString);
		// 返回结果集
		// ResultSet rs = ps.executeQuery();
		// 遍历数据
		// TODO change this!!
		ArrayList<MovieInfo> resultList = new ArrayList<>();
		resultList.add(new MovieInfo("12", "Back to the Future"));
		// 关闭连接
		// rs.close();
		// ps.close();
		connection.close();
		return resultList;
	}
}
