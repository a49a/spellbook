CREATE TABLE ods (
    id INT,
    name VARCHAR NOT NULL
) WITH (
    type ='kafka11',
    bootstrapServers ='kudu1:9092',
    topic ='wuren_foo'
);

CREATE TABLE dim_i (
    name varchar,
    id int,
    PERIOD FOR SYSTEM_TIME
) WITH (
    type='kudu',
    kuduMasters='eng-cdh1',
    tableName='foo',
    parallelism ='1',
    cache ='LRU',
    keytab='kudu-master.keytab',
    krb5conf='krb5.conf',
    principal='kudu/eng-cdh1@DTSTACK.COM'
);

CREATE TABLE outputtable(
    id    INT,
    name      VARCHAR
) with (
  type  =  'console'
);

INSERT INTO outputtable
    SELECT ods.id, dim_i.name
    FROM ods LEFT JOIN dim_i ON ods.id = dim_i.id;