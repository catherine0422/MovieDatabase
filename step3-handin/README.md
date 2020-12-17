# Web application on IMDB database

## Introduction

In this project, we built a web application to handle the query on IMBD database. 

Specifically, the web application will query the persons that are active during the given year and show the id and name of these actors and the number of movies in which they have played.

Also, each person has a personal page that shows their basic information (gender, name, born year) and movie list in which they have played.

## Requirement

1. Tomcat 9.0

2. Java jdk >= 14.0

3. We will use the materialized view actor_info created in the step 2, so please make sure you have created this view before using our web application. The script for creating the view is:

   ```sql
   CREATE MATERIALIZED VIEW actors_info AS
   SELECT id, person_id, movie_id, person_role_id
   FROM cast_info
   WHERE role_id <= 2;
   ```

## Installation

1. Put all the `.java` files in your eclipse project under the folder `inf553-web\src\edu\polytechnique\inf553`

2. Put all the `.jsp` files and the `images` folder in your eclipse project under the folder `inf553-web\WebContent`

3. Start the Postgres server:

   ```
   PSQLPath/pg ctl -D DATAPath -l LOGPath/logfile start
   ```

4. Change the parameters for JDBC connection in the `Postgresql.java` file according to your own settings. The code is on the first four lines of the class:

   ```java
   public static final String PORT = "5432"; 			// port of the postgreSql server
   public static final String DATABASE = "postgres"; 	// name of the IMDB database in your postgreSql
   public static final String USER = "postgres";		// postgreSql user name 
   public static final String PASSWORD = "123456";		// password of the user
   ```

5. Start the tomcat servlet.

## Usage

1. Go to the page http://localhost:8080/inf553-web/QueryServlet?year=2011 on your browser. You can also change the year parameter '2011' into a year smaller than 2050. 

   ![](.\presentation_pictures\index.jpg)

   1. You will see information about actors and their number of movies played in that year.
   2. You can then query a certain year by the search bar.
   3. We use pagination, you can also select how many rows to display in one page by the selection box.

2. Click on the actor name, you can go to the personal page of that actor.

   ![](.\presentation_pictures\actorInfo.jpg)

   You can see the gender, birth year and acted movie in this page.

3. If you encounter an error, an exception will be throwed to the server, and you will also see an error page on the browser.

   ![](.\presentation_pictures\error.jpg)

## Presentation

You can also see the video for a short presentation  of the web application.

## Github

https://github.com/catherine0422/MovieDatabase

author: Yujia FU & Kunhao ZHENG
