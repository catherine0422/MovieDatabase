# Movie database

## Introduction

This is a sql project that manages a movie database.

## Requirement

* Postgresql
* [IMDB dataset](https://drive.google.com/file/d/1cqamuyPyg_xKpAGCcKQ8PCiOJZSfNlFS/view?usp=sharing)

## Installation

1. Download the IMDB dataset and extract the folder into out root path.

2. Create a file named 'logFile.txt' in the log folder.

3. In the root path,  initialize a Postgres disk area:

   ```
   initdb -D ./data -E UTF8
   ```

4. Launch the postgreSQL server:

   ```
   pg_ctl -D ./data -l ./log/logFile.txt start
   ```

5. PostgreSQL create automatically a role with your user name on your operating system.  We note it $USER. Then we connect to the server using this role name.

   ```
   psql -U $USER -d postgres
   ```

   

 