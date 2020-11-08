DO $$
DECLARE
    file character varying;
    imdb_path text := 'C:/Users/ZT/Documents/university/course/3A/INF553_db/project/db/imdb-reduced';
BEGIN
    FOR file IN
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema='public'
              AND table_type='BASE TABLE'
        LOOP
        RAISE NOTICE 'import %s', file;
        EXECUTE  'COPY '||file||' FROM'||' '''||imdb_path||'/'||file||'.csv'''||' CSV HEADER';
        END LOOP;
END
$$;