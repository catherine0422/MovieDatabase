package edu.polytechnique.inf553;

public class PersonInfo {
	public String id;
	public String gender;
	public String name;
	public String birthYear;

	public PersonInfo(String id, String gender, String name, String birthYear) {
		this.id = id;
		this.gender = gender;
		this.name = name;
		this.birthYear = birthYear;
	}

	public String getId() {
		return this.id;
	}

	public String getGender() {
		return this.gender;
	}

	public String getName() {
		return this.name;
	}

	public String getBirthYear() {
		return this.birthYear;
	}
}
