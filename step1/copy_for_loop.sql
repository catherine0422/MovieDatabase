DO $$
DECLARE
    file character varying;
    imdb_path text := 'D:/SS/Study/X/3A/INF553/Project/imdb-reduced';
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
