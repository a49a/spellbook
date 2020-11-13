CREATE TABLE ods_foo (
    id INT,
    name VARCHAR
) WITH (
    type ='kafka',
    bootstrapServers ='localhost:9092',
--     zookeeperQuorum ='172.16.8.198:2181/kafka',
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

CREATE VIEW view_foo AS SELECT * FROM ods_foo;

INSERT INTO dwd_foo SELECT id, name FROM view_foo;