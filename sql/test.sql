explain analyze(
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
        M.id = FOO.movie_id
);
