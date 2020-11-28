CREATE TABLE source (
    id  int,
    name  varchar
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

create table side (
    info:id  varchar as id,
    info:name varchar as k,
    PRIMARY KEY (rowKey),
    PERIOD FOR SYSTEM_TIME
)
WITH (
    type ='hbase',
    zookeeperQuorum ='eng-cdh1:2181,eng-cdh2:2181,eng-cdh3:2181',
    zookeeperParent ='/hbase',
    tableName ='tiezhu_side_table',
    parallelism ='1',

    -- 同步方式
    -- cache ='ALL',
    -- cacheTTLMS = '10000000',

    -- 异步方式
    cache ='LRU',

    hbase.security.auth.enable='true',
    hbase.security.authentication='kerberos',
    hbase.sasl.clientconfig='Client',
    hbase.kerberos.regionserver.principal='hbase/_HOST@DTSTACK.COM',
    hbase.keytab='hbase-master.keytab',
    hbase.principal='hbase/eng-cdh1@DTSTACK.COM',
    java.security.krb5.conf='krb5.conf'
);

CREATE TABLE sink(
    cf1:ids int as ids,
    cf1:name varchar as k
)
WITH (
    type ='hbase',
    zookeeperQuorum ='eng-cdh1:2181,eng-cdh2:2181,eng-cdh3:2181',
    zookeeperParent ='/hbase',
    tableName ='wuren_java',
    partitionedJoin ='false',
    parallelism ='1',
    rowKey='ids',
    kerberosAuthEnable='true',
    regionserverPrincipal='hbase/_HOST@DTSTACK.COM',
    clientKeytabFile='hbase-master.keytab',
    clientPrincipal='hbase/eng-cdh1@DTSTACK.COM',
    securityKrb5Conf='krb5.conf'
);

INSERT INTO sink
    SELECT source.id as ids, side.k as k
    FROM source
    LEFT JOIN side ON source.id = side.rowKey;