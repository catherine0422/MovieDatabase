package edu.polytechnique.inf553;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Postgresql {
	
	// Please change the following parameters according to your db settings
	public static final String PORT = "5432"; 			// port of the postgreSql server
	public static final String DATABASE = "postgres"; 	// name of the IMDB database in your postgreSql
    public static final String USER = "postgres";		// postgreSql user name 
    public static final String PASSWORD = "123456";		// password of the user
	public static final String URL = "jdbc:postgresql://127.0.0.1:" + PORT + "/" + DATABASE;

	
	// Query actors and their movie numbers in the given year, in a certain page with certain rows per page
	public static ArrayList<QueryInfo> queryIndex(String production_year, int page, int rowsPerPage) throws ClassNotFoundException, SQLException {
		
		// Connect to the postgreSql server
		Class.forName("org.postgresql.Driver");
		Connection connection = null; 
		connection = DriverManager.getConnection(URL, USER, PASSWORD);
		
		// Script to query actors and their movie numbers in the given year
		String querySqlString = "SELECT P.id, P.name, P.gender, COUNT(M.id) as movie_nr" + 
								" FROM person P, actors_info A, movie M" + 
								" WHERE P.id = A.person_id" + 
								" AND M.id = A.movie_id AND M.production_year =?" + 
								" GROUP BY P.id" + 
								" ORDER BY movie_nr DESC" + 
								" LIMIT ? OFFSET ?;";
		
		// Prepare the statement
		PreparedStatement ps = connection.prepareStatement(querySqlString);
		
		// Fill in the statement with parameters
		ps.setString(1, production_year);
		ps.setInt(2, rowsPerPage);  // we use pagination, so we need to set limit = rows per page
		ps.setInt(3, (page - 1) * rowsPerPage);  // the offset will be the number of rows shown in all previous pages
		
		// Execute the query
		ResultSet rs = ps.executeQuery();
		ArrayList<QueryInfo> resultList = rsToArrayList(rs);
		
		// Close the connection
		rs.close();
		ps.close();
		connection.close();
		return resultList;
	}
	
	
	// Change JDBC query result of 'queryIndex' into QueryInfo list
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
	
	
	// Query total number of pages of actors and their movie numbers in the given year
	public static int queryTotalPages(String production_year, int rowsPerPage) throws ClassNotFoundException, SQLException {
		
		// Connect to the postgreSql server
		Class.forName("org.postgresql.Driver");
		Connection connection = null;
		connection = DriverManager.getConnection(URL, USER, PASSWORD);
		
		// Script to query total number of pages of actors and their movie numbers in the given year
		String querySqlString = "SELECT COUNT(DISTINCT A.person_id) as nPersons" +
				 " FROM actors_info A, movie M" +
				 " WHERE M.id = A.movie_id AND M.production_year = ?;";

		// Prepare the statement
		PreparedStatement ps = connection.prepareStatement(querySqlString);
		
		// Fill in the statement with parameters
		ps.setString(1, production_year);
		
		// Execute the query
		ResultSet rs = ps.executeQuery();
		int totalPages = 1;
        while(rs.next()){
        	// Get the total number of pages
        	totalPages = (int)Math.ceil(rs.getInt("nPersons")/(double)rowsPerPage);
        }

		// Close the connection
		rs.close();
		ps.close();
		connection.close();
		return totalPages;
	}

	
	// Query personal information about a person
	public static PersonInfo queryPersonInfo(String pid) throws ClassNotFoundException, SQLException {

		// Connect to the postgreSql server
		Class.forName("org.postgresql.Driver");
		Connection connection = null; 
		Statement statmment = null; 
		connection = DriverManager.getConnection(URL, USER, PASSWORD);
		statmment = connection.createStatement();
		
		// Script to query the gender and name of a person
		String queryGender = "SELECT P.gender, P.name" + 
				" FROM person P" + 
				" WHERE P.id = " + pid +";";
		
		// Execute the query
		ResultSet rsGender = statmment.executeQuery(queryGender);
		String gender = null;
		String name = null;
		while (rsGender.next()) {
			gender = rsGender.getString("gender").trim();
			name =  rsGender.getString("name");
		}
		rsGender.close();
		
		// Script to query the birth year of a person
		String queryBirthday = "SELECT P.info" +
							   " FROM person_info P" +
							   " WHERE P.info_type_id = 21 AND P.person_id = " + pid;
		
		// Execute the query
		ResultSet rsBirthday = statmment.executeQuery(queryBirthday);
		String birthyear = null;
		while (rsBirthday.next()) {
			String birthday = rsBirthday.getString("info").trim();
			// get the birth year
			birthyear = birthday.substring(birthday.length() - 4);
		}
		rsBirthday.close();

		// Use the query result to create a personInfo instance
		PersonInfo personInfo = new PersonInfo(pid, gender, name, birthyear);

		// Close the connection
		statmment.close();
		connection.close();
		return personInfo;
	}
	

	// Query movies a person has played in
	public static ArrayList<MovieInfo> queryMovieInfo(String pid) throws ClassNotFoundException, SQLException {
		
		// Connect to the postgreSql server
		Class.forName("org.postgresql.Driver");
		Connection connection = null;
		Statement statmment = null; 
		connection = DriverManager.getConnection(URL, USER, PASSWORD);
		statmment = connection.createStatement();
		
		// Script to query movies a person has played in
		String queryMovies = "SELECT DISTINCT M.id, M.title" + 
				" FROM movie M, cast_info cf" + 
				" WHERE cf.movie_id = M.id AND cf.person_id = " + pid +";";
		
		// Execute the query
		ResultSet rsMovies = statmment.executeQuery(queryMovies);
		ArrayList<MovieInfo> movieList = new ArrayList<>();
		while (rsMovies.next()) {
			movieList.add(new MovieInfo(rsMovies.getString("id"), rsMovies.getString("title")));
		}
		
		// Close the connection
		rsMovies.close();
		statmment.close();
		connection.close();
		return movieList;
	}
}
