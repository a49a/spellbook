CREATE TABLE ods_foo (
    id INT,
    name VARCHAR
) WITH (
    type ='kafka',
    bootstrapServers ='kudu1:9092',
--     zookeeperQuorum ='172.16.8.198:2181/kafka',
    offsetReset ='latest',
    groupId='wuren_foo',
    topic ='wuren_foo',
    topicIsPattern = 'false',
    parallelism ='2'
);

CREATE TABLE dwd_foo (
    id INT,
    name VARCHAR
) WITH (
    type ='console',
    parallelism ='2'
);

INSERT INTO dwd_foo
    SELECT id, name
    FROM ods_foo;