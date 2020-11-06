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
    CONSTRAINT "complete_cast_subject_id_check1" CHECK (
        (
            (subject_id = 3)
            OR (subject_id = 4)
            OR (subject_id IS NULL)
        )
    );

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
