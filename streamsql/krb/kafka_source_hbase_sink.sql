CREATE TABLE ods (
    id  INT,  
    name  VARCHAR
) WITH (
    type ='kafka',
    bootstrapServers ='eng-cdh1:9092',
    topic ='test',
    parallelism ='1',
    groupId = 'xxxxx',
    kafka.security.protocol='SASL_PLAINTEXT',
    kafka.sasl.mechanism='GSSAPI',
    kafka.sasl.kerberos.service.name='kafka'
);

CREATE TABLE dwd (
    cf1:did int as did,
    cf1:name varchar as name
) WITH (
    type ='hbase',
    zookeeperQuorum ='eng-cdh1:2181,eng-cdh2:2181,eng-cdh3:2181',
    zookeeperParent ='/hbase',
    tableName ='wuren_java',
    partitionedJoin ='false',
    parallelism ='1',
    rowKey='did',
    kerberosAuthEnable='true',
    regionserverPrincipal='hbase/_HOST@DTSTACK.COM',
    clientKeytabFile='hbase-master.keytab',
    clientPrincipal='hbase/eng-cdh1@DTSTACK.COM',
    securityKrb5Conf='krb5.conf'
);

INSERT INTO dwd
    SELECT ods.id as did, ods.name
    FROM ods;
