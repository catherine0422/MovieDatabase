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
            person_id,movie_id
        FROM
            cast_info
        WHERE
            role_id = 1
            OR role_id = 2
        INTERSECT
        SELECT
            person_id,movie_id
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
    ) AS BAR
