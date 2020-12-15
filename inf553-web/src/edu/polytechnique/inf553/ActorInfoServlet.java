package edu.polytechnique.inf553;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class InfoDisplay
 * Returns the personal page for an actor
 */
@WebServlet("/ActorInfoServlet")
public class ActorInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ActorInfoServlet() {
		super();
	}

	/**
	 * deGet parameter:
	 *  	@param pid: person id 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String pid = request.getParameter("pid");
		
		// Get personal information with the Postgresql query
		PersonInfo pif = null;
		ArrayList<MovieInfo> mif = new ArrayList<>();
		try {
			pif = Postgresql.queryPersonInfo(pid);
			mif = Postgresql.queryMovieInfo(pid);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Direct to the InfoDisplay page
		request.setAttribute("pif", pif);
		request.setAttribute("mif", mif);
		request.getRequestDispatcher("ActorInfo.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
