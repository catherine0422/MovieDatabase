/*  
 Description: Project Step 1   
 Author: Kunhao ZHENG / Yujia FU 
 Create Date: 11/08/2020
 */
--*******************************************************************************
--************** 1.  DEPLOY THE SCHEMA OF THE DATABASE   ************************
--*******************************************************************************

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

--
-- Drop All the constaints. The code are auto-generated.
ALTER TABLE
    "public"."aka_name" DROP CONSTRAINT "aka_name_person_id_fkey" CASCADE;

ALTER TABLE
    "public"."aka_title" DROP CONSTRAINT "aka_title_episode_of_id_fkey" CASCADE;

ALTER TABLE
    "public"."aka_title" DROP CONSTRAINT "aka_title_kind_id_fkey" CASCADE;

ALTER TABLE
    "public"."cast_info" DROP CONSTRAINT "cast_info_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."cast_info" DROP CONSTRAINT "cast_info_person_id_fkey" CASCADE;

ALTER TABLE
    "public"."cast_info" DROP CONSTRAINT "cast_info_person_role_id_fkey" CASCADE;

ALTER TABLE
    "public"."cast_info" DROP CONSTRAINT "cast_info_role_id_fkey" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_status_id_fkey" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_subject_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie" DROP CONSTRAINT "movie_episode_of_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie" DROP CONSTRAINT "movie_kind_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_company" DROP CONSTRAINT "movie_company_company_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_company" DROP CONSTRAINT "movie_company_company_type_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_company" DROP CONSTRAINT "movie_company_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_info" DROP CONSTRAINT "movie_info_info_type_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_info" DROP CONSTRAINT "movie_info_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_keyword" DROP CONSTRAINT "movie_keyword_keyword_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_keyword" DROP CONSTRAINT "movie_keyword_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_link" DROP CONSTRAINT "movie_link_link_type_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_link" DROP CONSTRAINT "movie_link_linked_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_link" DROP CONSTRAINT "movie_link_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_rating" DROP CONSTRAINT "movie_rating_info_type_id_fkey" CASCADE;

ALTER TABLE
    "public"."movie_rating" DROP CONSTRAINT "movie_rating_movie_id_fkey" CASCADE;

ALTER TABLE
    "public"."person_info" DROP CONSTRAINT "person_info_info_type_id_fkey" CASCADE;

ALTER TABLE
    "public"."person_info" DROP CONSTRAINT "person_info_person_id_fkey" CASCADE;

ALTER TABLE
    "public"."aka_name" DROP CONSTRAINT "aka_name_name_check" CASCADE;

ALTER TABLE
    "public"."comp_cast_type" DROP CONSTRAINT "comp_cast_type_kind_check" CASCADE;

ALTER TABLE
    "public"."company" DROP CONSTRAINT "company_name_check" CASCADE;

ALTER TABLE
    "public"."company_type" DROP CONSTRAINT "company_type_kind_check" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_status_id_check" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_subject_id_check" CASCADE;

ALTER TABLE
    "public"."info_type" DROP CONSTRAINT "info_type_info_check" CASCADE;

ALTER TABLE
    "public"."keyword" DROP CONSTRAINT "keyword_keyword_check" CASCADE;

ALTER TABLE
    "public"."link_type" DROP CONSTRAINT "link_type_link_check" CASCADE;

ALTER TABLE
    "public"."movie" DROP CONSTRAINT "movie_title_check" CASCADE;

ALTER TABLE
    "public"."movie_type" DROP CONSTRAINT "movie_type_kind_check" CASCADE;

ALTER TABLE
    "public"."person" DROP CONSTRAINT "person_name_check" CASCADE;

ALTER TABLE
    "public"."role_type" DROP CONSTRAINT "role_type_role_check" CASCADE;

ALTER TABLE
    "public"."aka_name" DROP CONSTRAINT "aka_name_pkey" CASCADE;

ALTER TABLE
    "public"."aka_title" DROP CONSTRAINT "aka_title_pkey" CASCADE;

ALTER TABLE
    "public"."cast_info" DROP CONSTRAINT "cast_info_pkey" CASCADE;

ALTER TABLE
    "public"."char_name" DROP CONSTRAINT "char_name_pkey" CASCADE;

ALTER TABLE
    "public"."comp_cast_type" DROP CONSTRAINT "comp_cast_type_pkey" CASCADE;

ALTER TABLE
    "public"."company" DROP CONSTRAINT "company_pkey" CASCADE;

ALTER TABLE
    "public"."company_type" DROP CONSTRAINT "company_type_pkey" CASCADE;

ALTER TABLE
    "public"."complete_cast" DROP CONSTRAINT "complete_cast_pkey" CASCADE;

ALTER TABLE
    "public"."info_type" DROP CONSTRAINT "info_type_pkey" CASCADE;

ALTER TABLE
    "public"."keyword" DROP CONSTRAINT "keyword_pkey" CASCADE;

ALTER TABLE
    "public"."link_type" DROP CONSTRAINT "link_type_pkey" CASCADE;

ALTER TABLE
    "public"."movie" DROP CONSTRAINT "movie_pkey" CASCADE;

ALTER TABLE
    "public"."movie_company" DROP CONSTRAINT "movie_company_pkey" CASCADE;

ALTER TABLE
    "public"."movie_info" DROP CONSTRAINT "movie_info_pkey" CASCADE;

ALTER TABLE
    "public"."movie_keyword" DROP CONSTRAINT "movie_keyword_pkey" CASCADE;

ALTER TABLE
    "public"."movie_link" DROP CONSTRAINT "movie_link_pkey" CASCADE;

ALTER TABLE
    "public"."movie_rating" DROP CONSTRAINT "movie_rating_pkey" CASCADE;

ALTER TABLE
    "public"."movie_type" DROP CONSTRAINT "movie_type_pkey" CASCADE;

ALTER TABLE
    "public"."person" DROP CONSTRAINT "person_pkey" CASCADE;

ALTER TABLE
    "public"."person_info" DROP CONSTRAINT "person_info_pkey" CASCADE;

ALTER TABLE
    "public"."role_type" DROP CONSTRAINT "role_type_pkey" CASCADE;

--************************************************************************
--************************   2.  IMPORT DATA  ****************************
--************************************************************************

-- Method 1
COPY person FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/person.csv' CSV HEADER;
COPY info_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/info_type.csv' CSV HEADER;
COPY link_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/link_type.csv' CSV HEADER;
COPY comp_cast_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/comp_cast_type.csv' CSV HEADER;
COPY movie_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_type.csv' CSV HEADER;
COPY role_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/role_type.csv' CSV HEADER;
COPY aka_name FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/aka_name.csv' CSV HEADER;
COPY movie FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie.csv' CSV HEADER;
COPY keyword FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/keyword.csv' CSV HEADER;
COPY person_info FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/person_info.csv' CSV HEADER;
COPY company FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/company.csv' CSV HEADER;
COPY company_type FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/company_type.csv' CSV HEADER;
COPY movie_company FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_company.csv' CSV HEADER;
COPY aka_title FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/aka_title.csv' CSV HEADER;
COPY char_name FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/char_name.csv' CSV HEADER;
COPY cast_info FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/cast_info.csv' CSV HEADER;
COPY complete_cast FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/complete_cast.csv' CSV HEADER;
COPY movie_rating FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_rating.csv' CSV HEADER;
COPY movie_info FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_info.csv' CSV HEADER;
COPY movie_keyword FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_keyword.csv' CSV HEADER;
COPY movie_link FROM 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced/movie_link.csv' CSV HEADER;

-- Method 2
DO $$
DECLARE
    file character varying;
    imdb_path text := 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced';
BEGIN
    FOR file IN
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema='public'
              AND table_type='BASE TABLE'
        LOOP
        RAISE NOTICE 'import %s', file;
        EXECUTE  'COPY '||file||' FROM'||' '''||imdb_path||'/'||file||'.csv'''||' CSV HEADER';
        END LOOP;
END
$$;

--
-- Re-add the constraints to the data. The code is auto-generated.
ALTER TABLE
    "public"."role_type"
ADD
    CONSTRAINT "role_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."person_info"
ADD
    CONSTRAINT "person_info_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."person"
ADD
    CONSTRAINT "person_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_type"
ADD
    CONSTRAINT "movie_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_rating"
ADD
    CONSTRAINT "movie_rating_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_link"
ADD
    CONSTRAINT "movie_link_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_keyword"
ADD
    CONSTRAINT "movie_keyword_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_info"
ADD
    CONSTRAINT "movie_info_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie_company"
ADD
    CONSTRAINT "movie_company_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."movie"
ADD
    CONSTRAINT "movie_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."link_type"
ADD
    CONSTRAINT "link_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."keyword"
ADD
    CONSTRAINT "keyword_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."info_type"
ADD
    CONSTRAINT "info_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."company_type"
ADD
    CONSTRAINT "company_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."company"
ADD
    CONSTRAINT "company_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."comp_cast_type"
ADD
    CONSTRAINT "comp_cast_type_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."char_name"
ADD
    CONSTRAINT "char_name_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."cast_info"
ADD
    CONSTRAINT "cast_info_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."aka_title"
ADD
    CONSTRAINT "aka_title_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."aka_name"
ADD
    CONSTRAINT "aka_name_pkey" PRIMARY KEY (id);

ALTER TABLE
    "public"."role_type"
ADD
    CONSTRAINT "role_type_role_check" CHECK ((length(role) > 0));

ALTER TABLE
    "public"."person"
ADD
    CONSTRAINT "person_name_check" CHECK ((length((name) :: text) > 0));

ALTER TABLE
    "public"."movie_type"
ADD
    CONSTRAINT "movie_type_kind_check" CHECK ((length(kind) > 0));

ALTER TABLE
    "public"."movie"
ADD
    CONSTRAINT "movie_title_check" CHECK ((length((title) :: text) > 0));

ALTER TABLE
    "public"."link_type"
ADD
    CONSTRAINT "link_type_link_check" CHECK ((length(link) > 0));

ALTER TABLE
    "public"."keyword"
ADD
    CONSTRAINT "keyword_keyword_check" CHECK ((length((keyword) :: text) > 0));

ALTER TABLE
    "public"."info_type"
ADD
    CONSTRAINT "info_type_info_check" CHECK ((length((info) :: text) > 0));

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_subject_id_check" CHECK (
        (
            (subject_id = 1)
            OR (subject_id = 2)
            OR (subject_id IS NULL)
        )
    );

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_status_id_check" CHECK (
        (
            (status_id = 3)
            OR (status_id = 4)
            OR (status_id IS NULL)
        )
    );

ALTER TABLE
    "public"."company_type"
ADD
    CONSTRAINT "company_type_kind_check" CHECK ((length((kind) :: text) > 0));

ALTER TABLE
    "public"."company"
ADD
    CONSTRAINT "company_name_check" CHECK ((length((name) :: text) > 0));

ALTER TABLE
    "public"."comp_cast_type"
ADD
    CONSTRAINT "comp_cast_type_kind_check" CHECK ((length(kind) > 0));

ALTER TABLE
    "public"."aka_name"
ADD
    CONSTRAINT "aka_name_name_check" CHECK ((length((name) :: text) > 0));

ALTER TABLE
    "public"."person_info"
ADD
    CONSTRAINT "person_info_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."person_info"
ADD
    CONSTRAINT "person_info_info_type_id_fkey" FOREIGN KEY (info_type_id) REFERENCES info_type(id);

ALTER TABLE
    "public"."movie_rating"
ADD
    CONSTRAINT "movie_rating_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."movie_rating"
ADD
    CONSTRAINT "movie_rating_info_type_id_fkey" FOREIGN KEY (info_type_id) REFERENCES info_type(id);

ALTER TABLE
    "public"."movie_link"
ADD
    CONSTRAINT "movie_link_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE
    "public"."movie_link"
ADD
    CONSTRAINT "movie_link_linked_movie_id_fkey" FOREIGN KEY (linked_movie_id) REFERENCES movie(id);

ALTER TABLE
    "public"."movie_link"
ADD
    CONSTRAINT "movie_link_link_type_id_fkey" FOREIGN KEY (link_type_id) REFERENCES link_type(id);

ALTER TABLE
    "public"."movie_keyword"
ADD
    CONSTRAINT "movie_keyword_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."movie_keyword"
ADD
    CONSTRAINT "movie_keyword_keyword_id_fkey" FOREIGN KEY (keyword_id) REFERENCES keyword(id);

ALTER TABLE
    "public"."movie_info"
ADD
    CONSTRAINT "movie_info_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."movie_info"
ADD
    CONSTRAINT "movie_info_info_type_id_fkey" FOREIGN KEY (info_type_id) REFERENCES info_type(id);

ALTER TABLE
    "public"."movie_company"
ADD
    CONSTRAINT "movie_company_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE
    "public"."movie_company"
ADD
    CONSTRAINT "movie_company_company_type_id_fkey" FOREIGN KEY (company_type_id) REFERENCES company_type(id);

ALTER TABLE
    "public"."movie_company"
ADD
    CONSTRAINT "movie_company_company_id_fkey" FOREIGN KEY (company_id) REFERENCES company(id);

ALTER TABLE
    "public"."movie"
ADD
    CONSTRAINT "movie_kind_id_fkey" FOREIGN KEY (kind_id) REFERENCES movie_type(id);

ALTER TABLE
    "public"."movie"
ADD
    CONSTRAINT "movie_episode_of_id_fkey" FOREIGN KEY (episode_of_id) REFERENCES movie(id);

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_subject_id_fkey" FOREIGN KEY (subject_id) REFERENCES comp_cast_type(id);

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_status_id_fkey" FOREIGN KEY (status_id) REFERENCES comp_cast_type(id);

ALTER TABLE
    "public"."complete_cast"
ADD
    CONSTRAINT "complete_cast_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."cast_info"
ADD
    CONSTRAINT "cast_info_role_id_fkey" FOREIGN KEY (role_id) REFERENCES role_type(id);

ALTER TABLE
    "public"."cast_info"
ADD
    CONSTRAINT "cast_info_person_role_id_fkey" FOREIGN KEY (person_role_id) REFERENCES char_name(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."cast_info"
ADD
    CONSTRAINT "cast_info_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."cast_info"
ADD
    CONSTRAINT "cast_info_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE;

ALTER TABLE
    "public"."aka_title"
ADD
    CONSTRAINT "aka_title_kind_id_fkey" FOREIGN KEY (kind_id) REFERENCES movie_type(id);

ALTER TABLE
    "public"."aka_title"
ADD
    CONSTRAINT "aka_title_episode_of_id_fkey" FOREIGN KEY (episode_of_id) REFERENCES movie(id);

ALTER TABLE
    "public"."aka_name"
ADD
    CONSTRAINT "aka_name_person_id_fkey" FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;



--************************************************************************
--****************************  3.     QUERYS       **********************
--************************************************************************

-- Find the pairs of (movie title, actor name) such that the actor played in the movie.
SELECT
    M.title,
    P.name
FROM
    movie M,
    person P,
    cast_info C
WHERE
    M.id = C.movie_id
    AND P.id = C.person_id
    AND(
        C.role_id = 1
        OR C.role_id = 2
    );

-- Find the person names and movie titles such that the person has played in the movie a character called Amber.
SELECT
    M.title,
    P.name
FROM
    movie M,
    person P,
    cast_info C,
    char_name CH
WHERE
    M.id = C.movie_id
    AND P.id = C.person_id
    AND (
        C.role_id = 1
        OR C.role_id = 2
    )
    AND CH.id = C.person_role_id
    AND CH.name = 'Amber';

-- Find the title and the year of production of each movie in which Nicolas Cage played. The lines for which
-- the production year is unavailable should not be displayed. Order the results by year in descending order,
-- then by title in ascending order.
SELECT
    M.title,
    M.production_year
FROM
    movie M,
    cast_info C,
    person P
WHERE
    C.movie_id = M.id
    AND C.person_id = P.id
    AND P.name = 'Ross, Kevin'
    AND M.production_year IS NOT NULL
    AND (
        C.role_id = 1
        OR C.role_id = 2
    )
ORDER BY
    M.production_year DESC,
    M.title ASC;

-- Find the name of all the people that have played in a movie they directed, and order them by their names
-- (increasing alphabetical order).
SELECT
    DISTINCT P.name
FROM
    person P,
    (
        SELECT
            person_id,
            movie_id
        FROM
            cast_info
        WHERE
            role_id = 1
            OR role_id = 2
        INTERSECT
        SELECT
            person_id,
            movie_id
        FROM
            cast_info
        WHERE
            role_id = 8
    ) AS FOO
WHERE
    FOO.person_id = P.id
ORDER BY
    P.name ASC;

-- Find the titles of the movies that have only 1, 9 and 10 as rating.
--
-- Condition1: ratings contain exactly 1, 9 and 10
SELECT
    M.title
FROM
    movie_rating MR,
    movie M
WHERE
    MR.info ~ '\d\.\.\.\.\.\.\.\d\d'
    AND M.id = MR.movie_id;

-- Condition2: ratings are in 1, 9 and 10
SELECT
    M.title
FROM
    movie_rating MR,
    movie M
WHERE
    MR.info LIKE '_.......%%'
    AND M.id = MR.movie_id;

-- Find the titles of the twenty movies having the largest number of directors and their number of directors,
-- ordered by their number of directors in decreasing order.
SELECT
    M.title,
    FOO.director_nr
FROM
    movie M,
    (
        SELECT
            movie_id,
            count(DISTINCT(person_id)) as director_nr
        FROM
            cast_info
        WHERE
            role_id = 8
        GROUP BY
            movie_id
        ORDER BY
            director_nr DESC
        LIMIT
            20
    ) AS FOO
WHERE
    M.id = FOO.movie_id;

-- Find the average number of episode Kevin Ross played in, in her active years. A year is active if she
-- plays in at least one movie produced that year.
SELECT
    AVG(count) as avg_episode_nr
FROM
    (
        SELECT
            COUNT(DISTINCT FOO.id) as count
        FROM
            (
                SELECT
                    M.id,
                    M.episode_of_id,
                    M.title,
                    M.production_year
                FROM
                    person P,
                    cast_info C,
                    movie M
                WHERE
                    P.name = 'Ross, Kevin'
                    AND (
                        C.role_id = 1
                        OR C.role_id = 2
                    )
                    AND P.id = C.person_id
                    AND M.id = C.movie_id
            ) AS FOO
        WHERE
            FOO.episode_of_id IS NOT NULL
        GROUP BY
            production_year
    ) AS BAR;

--************************************************************************
--*************************     4.    UPDATE       ***********************
--************************************************************************

DROP TABLE IF EXISTS "vote_distribution";

CREATE TABLE "vote_distribution"(
    "id" INTEGER PRIMARY KEY,
    "mark_1" CHAR(1),
    "mark_2" CHAR(1),
    "mark_3" CHAR(1),
    "mark_4" CHAR(1),
    "mark_5" CHAR(1),
    "mark_6" CHAR(1),
    "mark_7" CHAR(1),
    "mark_8" CHAR(1),
    "mark_9" CHAR(1),
    "mark_10" CHAR(1)
);

DROP FUNCTION IF EXISTS migrate_vote_distribution;

CREATE FUNCTION migrate_vote_distribution() RETURNS void AS $$
DECLARE
    rating_info RECORD;
BEGIN
    FOR rating_info IN
       SELECT *
        FROM movie_rating
        WHERE info_type_id = 99
    LOOP
        INSERT INTO vote_distribution VALUES(rating_info.movie_id,
                                             SUBSTRING(rating_info.info,1,1),
                                             SUBSTRING(rating_info.info,2,1),
                                             SUBSTRING(rating_info.info,3,1),
                                             SUBSTRING(rating_info.info,4,1),
                                             SUBSTRING(rating_info.info,5,1),
                                             SUBSTRING(rating_info.info,6,1),
                                             SUBSTRING(rating_info.info,7,1),
                                             SUBSTRING(rating_info.info,8,1),
                                             SUBSTRING(rating_info.info,9,1),
                                             SUBSTRING(rating_info.info,10,1));

    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT "migrate_vote_distribution"();
