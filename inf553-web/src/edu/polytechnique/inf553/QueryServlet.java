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
		String query_year = request.getParameter("year");
		String str_page = request.getParameter("page");
		int page = 1;
		if (str_page != null) {
			page = Integer.parseInt(str_page);
		}
		String maxYear = this.getServletConfig().getInitParameter("maxYear");
		// TODO if query_year bigger than maxYear throws an exception
		System.out.println(maxYear);
		ArrayList<QueryInfo> resultList = null;
		try {
			resultList = Postgresql.queryIndex(query_year, page);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// System.out.println(resultList);
		// request.setAttribute("message", "Hello, Kunhao\n");
		request.setAttribute("year", query_year);
		request.setAttribute("infos", resultList);
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
