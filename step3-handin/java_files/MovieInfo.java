package edu.polytechnique.inf553;

/*
 *   The class for a movie, contains information to shown in the movie list
 * */

public class MovieInfo {
	public String id;
	public String name;

	public MovieInfo(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getId() {
		return this.id;
	}

	public String getName() {
		return this.name;
	}
}
