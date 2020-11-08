CREATE INDEX "person__name" ON "person" USING HASH ("name");

CREATE INDEX "aka_name__person_id" ON "aka_name"("person_id");

CREATE INDEX "aka_name__name" ON "aka_name" USING HASH ("name");

CREATE INDEX "movie__production_year" ON "movie"("production_year");

CREATE INDEX "person_info__person_id" ON "person_info"("person_id");

CREATE INDEX "char_name__name" ON "char_name" USING HASH ("name");

CREATE INDEX "cast_info__person_id" ON "cast_info"("person_id");

CREATE INDEX "cast_info__movie_id" ON "cast_info"("movie_id");

CREATE INDEX "cast_info__person_role_id" ON "cast_info" USING HASH ("person_role_id");

CREATE INDEX "cast_info__role_id" ON "cast_info"("role_id");

CREATE INDEX "movie_rating__info" ON "movie_rating"("info");
