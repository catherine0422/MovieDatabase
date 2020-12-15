# Web application on IMDB database

## Introduction

In this project, we built a web application to handle the query on IMBD database. 

Specifically, the web application will query the persons that are active during the given year and show the id and name of these actors and the number of movies in which they have played.

Also, each person has a personal page that shows their basic information (gender, name, born year) and movie list in which they have played.

## Requirement

1. Tomcat 9.0

2. Java

3. We will use the materialized view actor_info created in the step 2, so please make sure you have created this view before using our web application. The script for creating the view is:

   ```sql
   CREATE MATERIALIZED VIEW actors_info AS
   SELECT id, person_id, movie_id, person_role_id
   FROM cast_info
   WHERE role_id <= 2;
   ```

## Usage

1. Start the Postgres server:

   ```
   PSQLPath/pg ctl -D DATAPath -l LOGPath/logfile start
   ```

2. Start the tomcat servlet.

3. Go to the page http://localhost:8080/inf553-web/QueryServlet?year=2011 on your browser. You can also change the year parameter '2011' into a year smaller than 2050.

