package edu.polytechnique.inf553;

/*
 *   The class for the result of main query: actor and movies played in a certain year
 * */

public class QueryInfo {
	public String personId;
	public String personName;
	public String personGender;
	public int movieNr;

	public QueryInfo(String pid, String pname, String pgender, int movie_nr) {
		this.personId = pid;
		this.personName = pname;
		this.personGender = pgender;
		this.movieNr = movie_nr;
	}

	public String getPersonId() {
		return this.personId;
	}

	public String getPersonName() {
		return this.personName;
	}

	public String getPersonGender() {
		return this.personGender;
	}

	public int getMovieNr() {
		return this.movieNr;
	}
}
