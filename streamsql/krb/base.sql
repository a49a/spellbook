CREATE TABLE ods (
    id  int,
    name  varchar
) WITH (
    type ='kafka',
    bootstrapServers ='cdp003.dtstack.com:9092',
    topic ='wuren_foo',
    parallelism ='1',
    groupId = 'xxxxx',
    kafka.security.protocol='SASL_PLAINTEXT',
    kafka.sasl.mechanism='GSSAPI',
    kafka.sasl.kerberos.service.name='kafka'
);

CREATE TABLE dwd (
    id INT,
    name VARCHAR
) WITH (
    type ='console'
);

INSERT INTO dwd
    SELECT id, name FROM ods;
