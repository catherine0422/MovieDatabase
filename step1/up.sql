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
