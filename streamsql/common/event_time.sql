CREATE TABLE ods (
    id INT,
    name VARCHAR,
    ct TIMESTAMP,
    WATERMARK FOR ct AS withOffset(ct, 30000)
) WITH (
    type ='kafka',
    bootstrapServers ='localhost:9092',
    offsetReset ='latest',
    groupId='g_1',
    topic ='wuren_foo',
    parallelism ='1'
);

CREATE TABLE dwd (
    ws TIMESTAMP,
    wd TIMESTAMP,
    row_count INT
) WITH (
    type ='console'
);

INSERT INTO dwd
    SELECT
        TUMBLE_START(ct, INTERNAL '20' MINUTES) AS ws,
        TUMBLE_END(ct, INTERNAL '20' MINUTES) AS wd,
        COUNT(id)
    FROM ods GROUP BY TUMBLE(ct, INTERNAL '20' MINUTES);