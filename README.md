# Movie database

## Introduction

This is a sql project that manages a movie database.

## Requirement

-   Postgresql
-   [IMDB reduced dataset](https://drive.google.com/file/d/1cqamuyPyg_xKpAGCcKQ8PCiOJZSfNlFS/view?usp=sharing)

## Installation

1. Download the IMDB reduced dataset and extract the folder into our root path, the fold should be named as `imdb-reduced`.

2. Create a file named `logfile` in the log folder.

## For Linux User

3. In the root path, initialize a Postgres disk area:

    ```
    initdb -D ./data -E UTF8
    ```

4. Launch the postgreSQL server:

    ```
    pg_ctl -D ./data -l ./log/logfile start
    ```

5. PostgreSQL create automatically a role with your user name on your operating system. We note it \$USER. Then we connect to the server using this role name.

    ```
    psql -U $USER -d postgres
    ```

## For Windows User

3. Make sure you have set the variable `DATAPath` with the path of the folder `data` (resp. `LOGPath` with the path of the folder `log`) in the PATH. Also there must be a `PSQLPath` pointing to `C:\Program Files\PostgreSQL\12\bin` if you install PostgreSQL in the default path.

4. In the root path, initialize a Postgres disk area using PowerShell:

```{powershell}
& "$env:PSQLPath\initdb" -D $env:DATAPath -E UTF8
```

5. Launch the postgreSQL server:

```{powershell}
& "$env:PSQLPath\pg_ctl" -D $env:DATAPath -l "$env:LOGPath\logfile" start
```

if it fails. Try kill the process which occupies port 5432 (cf [StackOverflow](https://stackoverflow.com/questions/39632667/how-do-i-kill-the-process-currently-using-a-port-on-localhost-in-windows)) in cmd running as Administator.

```{cmd}
netstat -ano | findstr :5432
taskkill /PID <PID> /F
```

6. PostgreSQL create automatically a role with your user name on your operating system. We note it \$USER. Then we connect to the server using this role name.

```{powershell}
psql -U $env:UserName -d postgres
```

7. To delete all the tables and contents. (cf [StackOverflow](https://stackoverflow.com/questions/3327312/how-can-i-drop-all-the-tables-in-a-postgresql-database))

```
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO public;
```

## Create DataBase

```
postgres=# \i create.sql
postgres=# \o drop_command.sql
postgres=# \i hack_drop.sql
postgres=# \o
```

Then remove the redundant lines in `drop_command.sql`.

```
postgres=# \o add_command.sql
postgres=# \i hack_create.sql
postgres=# \o
```

Then remove the redundant lines in `add_command.sql`.

```
postgres=# \i drop_command.sql
```

Change the path correctly in your `copy_for_loop.sql`, Then copy the data in csv file into database.

```
postgres=# \i copy_for_loop.sql
```

Add constraints.

```
postgres=# \i add_command.sql
```

Execute the queries.

```
postgres=# \i query.sql
```

Update the database.

```
postgres=# \i up.sql
```

To remove the change.

```
postgres=# \i down.sql
```

## Web application

1. Start the db `pg_ctl start -D ./data -l ./log/logFile.txt`
2. Start the servlet.
3. Go to the page 'http://localhost:8080/inf553-web/QueryServlet' in the browser.