package edu.polytechnique.inf553;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Pattern;

/**
 * Servlet implementation class QueryServlet
 * Returns the page for actors and number of played movies in the given year
 */
@WebServlet(urlPatterns = { "/QueryServlet" }, initParams = {
		@WebInitParam(name = "maxYear", value = "2050", description = "the maximum year") })
public class QueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public QueryServlet() {
		super();
	}

	/**
	 *  doGet parameters:
	 *  	@param year: production year of movies, mandatory
	 *  	@param page: pagination parameter, default value = 1
	 *  	@param rowsPerPage: pagination parameter, default value = 10
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, IllegalStateException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("utf-8");
		
		// Get the parameters from the request
		String query_year = request.getParameter("year").trim();
		String strPage = request.getParameter("page");
		String strRowsPerPage = request.getParameter("rowsPerPage");
		int page = 1;
		int rowsPerPage = 10;
		if (strPage != null) {
			page = Integer.parseInt(strPage);
		}
		if (strRowsPerPage != null) {
			rowsPerPage = Integer.parseInt(strRowsPerPage);
		}
		
		// Check the validity of query parameters
		// If year parameter not specified, throw IllegalArgumentException
		if (query_year == null || query_year.equals("")) {
			request.setAttribute("errorType", "Year parameter not found");
			request.setAttribute("errorMessage", "Please enter a year parameter");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalArgumentException("Expected year parameter but did not get one, URL malformed");
		}
		// If year parameter not well formated, throw IllegalArgumentException
		if (!Pattern.matches("\\d{4}", query_year)) {
			request.setAttribute("errorType", "IllegalArgumentException");
			request.setAttribute("errorMessage", "Please enter a year parameter that is consisted of four digits, eg. 2013");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalArgumentException("Expected year parameter consisted of four digits but get another format, URL malformed");
		}
		// If year parameter not smaller than 2050, throw IllegalStateException
		String maxYear = this.getServletConfig().getInitParameter("maxYear");
		if(Integer.parseInt(query_year) >= Integer.parseInt(maxYear)){
			request.setAttribute("errorType", "IllegalStateException");
			request.setAttribute("errorMessage", "Please enter a year parameter smaller than 2050");
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalStateException("Expected year parameter smaller than 2050, URL malformed");
		}

		// Get the QueryInfo list with Postgresql query
		ArrayList<QueryInfo> resultList = null;
		try {
			resultList = Postgresql.queryIndex(query_year, page, rowsPerPage);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// Get the total number of pages with Postgresql query
		int totalPages = 1;
		try {
			totalPages = Postgresql.queryTotalPages(query_year, rowsPerPage);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// If page parameter is bigger than the total number of pages, throw IllegalArgumentException
		if (page > totalPages) {
			request.setAttribute("errorType", "IllegalArgumentException");
			request.setAttribute("errorMessage", "Total number of pages is smaller than your page pamrameter, please enter a page no bigger than " + Integer.toString(totalPages));
			request.getRequestDispatcher("Error.jsp").forward(request, response);
			throw new IllegalArgumentException("Page parameter is bigger than the total number of pages, URL malformed");
		}
		
		// Direct to the index page
		request.setAttribute("year", query_year);
		request.setAttribute("infos", resultList);
		request.setAttribute("page", page);
		request.setAttribute("rowsPerPage", rowsPerPage);
		request.setAttribute("totalPages", totalPages);
		request.getRequestDispatcher("Index.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
