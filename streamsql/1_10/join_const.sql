CREATE TABLE ods_foo (
    id INT,
    name VARCHAR
) WITH (
    type ='kafka',
    bootstrapServers ='localhost:9092',
--     zookeeperQuorum ='localhost:2181/kafka',
    offsetReset ='latest',
    groupId='wuren_foo',
    topic ='wuren_foo',
    topicIsPattern = 'false',
    parallelism ='1'
);

CREATE TABLE dwd_foo (
    id INT,
    name VARCHAR
) WITH (
    type ='mysql',
    url ='jdbc:mysql://localhost:3306/wuren',
    userName ='root',
    password ='root',
    tableName ='dwd_foo',
    updateMode ='append',
    parallelism ='1',
    batchSize ='100',
    batchWaitInterval ='1000'
);

CREATE TABLE dim_foo(
    id INT,
    name VARCHAR,
    PRIMARY KEY(id) ,
    PERIOD FOR SYSTEM_TIME
) WITH (
    type ='mysql',
    url ='jdbc:mysql://localhost:3306/wuren',
    userName ='root',
    password ='root',
    tableName ='dim_foo',
    partitionedJoin ='false',
    cache ='LRU',
    cacheSize ='10000',
    cacheTTLMs ='60000',
    asyncPoolSize ='3',
    parallelism ='1'
);

INSERT INTO dwd_foo
    SELECT ods_foo.id, dim_foo.name FROM
    ods_foo LEFT JOIN dim_foo
    ON dim_foo.id = ods_foo.id
    AND dim_foo.id = 0;