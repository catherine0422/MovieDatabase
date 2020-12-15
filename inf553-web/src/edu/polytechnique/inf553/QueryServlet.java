package edu.polytechnique.inf553;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.regex.Pattern;

/**
 * Servlet implementation class QueryServlet
 */
@WebServlet(urlPatterns = { "/QueryServlet" }, initParams = {
		@WebInitParam(name = "maxYear", value = "2050", description = "the maximum year") })
public class QueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QueryServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, IllegalStateException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("utf-8");
		String query_year = request.getParameter("year").trim();
		String strPage = request.getParameter("page");
		String strRowsPerPage = request.getParameter("rowsPerPage");
		String maxYear = this.getServletConfig().getInitParameter("maxYear");
		if (query_year == null || query_year.equals("")) {
			request.setAttribute("errorType", "Year parameter not found");
			request.setAttribute("errorMessage", "Please enter a year parameter");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalArgumentException("Expected year parameter but did not get one, URL malformed");
		}
		if (!Pattern.matches("\\d{4}", query_year)) {
			request.setAttribute("errorType", "IllegalArgumentException");
			request.setAttribute("errorMessage", "Please enter a year parameter that is consisted of four digits, eg. 2013");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalArgumentException("Expected year parameter consisted of four digits but get another format, URL malformed");
		}
		if(Integer.parseInt(query_year) >= Integer.parseInt(maxYear)){
			request.setAttribute("errorType", "IllegalStateException");
			request.setAttribute("errorMessage", "Please enter a year parameter smaller than 2050");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalStateException("Expected year parameter smaller than 2050, URL malformed");
		}
		int page = 1;
		int rowsPerPage = 10;
		if (strPage != null) {
			page = Integer.parseInt(strPage);
		}
		if (strRowsPerPage != null) {
			rowsPerPage = Integer.parseInt(strRowsPerPage);
		}
		
		// TODO if query_year bigger than maxYear throws an exception
		ArrayList<QueryInfo> resultList = null;
		try {
			resultList = Postgresql.queryIndex(query_year, page, rowsPerPage);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int totalPages = 1;
		try {
			totalPages = Postgresql.queryTotalPages(query_year, rowsPerPage);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("year", query_year);
		request.setAttribute("infos", resultList);
		request.setAttribute("page", page);
		request.setAttribute("rowsPerPage", rowsPerPage);
		request.setAttribute("totalPages", totalPages);
		request.getRequestDispatcher("Index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO I don't think doPost is necessary
		doGet(request, response);
	}

}
