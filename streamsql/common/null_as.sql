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
    type ='console'
);



INSERT INTO dwd_foo 
    SELECT 
    id, 
    null as name 
    FROM ods_foo;