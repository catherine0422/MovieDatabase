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
