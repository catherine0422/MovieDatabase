CREATE TABLE "person"(
    "id" INTEGER PRIMARY KEY,
    "name" VARCHAR(128) NOT NULL CHECK(LENGTH("name") > 0),
    "gender" CHAR(8)
);

CREATE TABLE "info_type"(
    "id" INTEGER PRIMARY KEY,
    "info" VARCHAR(64) NOT NULL CHECK(LENGTH("info") > 0)
);

CREATE TABLE "link_type"(
    "id" INTEGER PRIMARY KEY,
    "link" CHAR(32) NOT NULL CHECK(LENGTH("link") > 0)
);

CREATE TABLE "comp_cast_type"(
    "id" INTEGER PRIMARY KEY,
    "kind" CHAR(32) NOT NULL CHECK(LENGTH("kind") > 0)
);

CREATE TABLE "movie_type"(
    "id" INTEGER PRIMARY KEY,
    "kind" CHAR(16) NOT NULL CHECK(LENGTH("kind") > 0)
);

CREATE TABLE "role_type"(
    "id" INTEGER PRIMARY KEY,
    "role" CHAR(32) NOT NULL CHECK(LENGTH("role") > 0)
);

CREATE TABLE "aka_name"(
    "id" INTEGER PRIMARY KEY,
    "person_id" INTEGER NOT NULL,
    "name" VARCHAR NOT NULL CHECK(LENGTH("name") > 0),
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE "movie"(
    "id" INTEGER PRIMARY KEY,
    "title" VARCHAR(256) NOT NULL CHECK(LENGTH("title") > 0),
    "kind_id" INTEGER REFERENCES movie_type(id),
    "production_year" VARCHAR(16),
    "episode_of_id" INTEGER REFERENCES movie(id),
    "season_nr" INTEGER,
    "episode_nr" INTEGER,
    "series_years" VARCHAR(16)
);

CREATE TABLE "keyword"(
    "id" INTEGER PRIMARY KEY,
    "keyword" VARCHAR(128) NOT NULL CHECK(LENGTH("keyword") > 0)
);

CREATE TABLE "person_info"(
    "id" INTEGER PRIMARY KEY,
    "person_id" INTEGER,
    "info_type_id" INTEGER REFERENCES info_type(id),
    "info" VARCHAR,
    "note" VARCHAR,
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE "company"(
    "id" INTEGER PRIMARY KEY,
    "name" VARCHAR NOT NULL CHECK(LENGTH("name") > 0),
    "country_code" CHAR(8)
);

CREATE TABLE "company_type"(
    "id" INTEGER PRIMARY KEY,
    "kind" VARCHAR(32) NOT NULL CHECK(LENGTH("kind") > 0)
);

CREATE TABLE "movie_company"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER REFERENCES movie(id),
    "company_id" INTEGER REFERENCES company(id),
    "company_type_id" INTEGER REFERENCES company_type(id),
    "note" VARCHAR(128)
);

CREATE TABLE "aka_title"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER NOT NULL,
    "title" VARCHAR,
    "kind_id" INTEGER REFERENCES movie_type(id),
    "production_year" VARCHAR(16),
    "episode_of_id" INTEGER REFERENCES movie(id),
    "season_nr" INTEGER,
    "episode_nr" INTEGER,
    "note" VARCHAR
);

CREATE TABLE "char_name"(
    "id" INTEGER PRIMARY KEY,
    "name" VARCHAR
);

CREATE TABLE "cast_info"(
    "id" INTEGER PRIMARY KEY,
    "person_id" INTEGER,
    "movie_id" INTEGER,
    "person_role_id" INTEGER,
    "note" VARCHAR,
    "role_id" INTEGER REFERENCES role_type(id),
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
    FOREIGN KEY (person_role_id) REFERENCES char_name(id) ON DELETE CASCADE
);

CREATE TABLE "complete_cast"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER,
    "subject_id" INTEGER REFERENCES comp_cast_type(id) CHECK(
        "subject_id" = 1
        OR "subject_id" = 2
        OR "subject_id" IS NULL
    ),
    "status_id" INTEGER REFERENCES comp_cast_type(id) CHECK(
        "status_id" = 3
        OR "status_id" = 4
        OR "status_id" IS NULL
    ),
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE "movie_rating"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER,
    "info_type_id" INTEGER REFERENCES info_type(id),
    "info" CHAR(16),
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE "movie_info"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER,
    "info_type_id" INTEGER REFERENCES info_type(id),
    "info" VARCHAR,
    "note" VARCHAR,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE "movie_keyword"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER,
    "keyword_id" INTEGER REFERENCES keyword(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE "movie_link"(
    "id" INTEGER PRIMARY KEY,
    "movie_id" INTEGER REFERENCES movie(id),
    "linked_movie_id" INTEGER REFERENCES movie(id),
    "link_type_id" INTEGER REFERENCES link_type(id)
);
