CREATE TABLE ods (
    id INT,
    name STRING,
    pt AS PROCTIME()
) WITH (
    'connector' = 'kafka',
    'topic' = 'wuren_foo',
    'properties.bootstrap.servers' = 'localhost:9092',
    'properties.group.id' = 'gg',
--     'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.fail-on-missing-field' = 'false',
    'json.ignore-parse-errors' = 'false'
);

CREATE TABLE dim (
    id INT,
    name STRING
) WITH (
    'connector' = 'jdbc',
    -- 'driver' = 'org.postgresql.Driver',
    'url' = 'jdbc:postgresql://localhost:5432/dev',
    'table-name' = 'dim',
    'username' = 'postgres',
    'password' = 'root'
);

CREATE TABLE ads (
    id INT,
    name STRING
) WITH (
    'connector' = 'jdbc',
    -- 'driver' = 'org.postgresql.Driver',
    'url' = 'jdbc:postgresql://localhost:5432/dev',
    'table-name' = 'dwd',
    'username' = 'postgres',
    'password' = 'root'
);

-- CREATE VIEW v AS
--     SELECT id, d.name
--     FROM ods
--         LEFT JOIN dim
--         FOR SYSTEM_TIME AS OF ods.pt AS d
--             ON d.id = ods.id;

-- INSERT INTO ads SELECT * FROM v;

INSERT INTO ads
    SELECT ods.id, d.name
    FROM ods
    LEFT JOIN dim
        FOR SYSTEM_TIME AS OF ods.pt AS d
        ON d.id = ods.id;

-- INSERT INTO ads_m
-- SELECT id, ct AS name
-- FROM ods_k LEFT JOIN LATERAL TABLE(lookup_redis(name));