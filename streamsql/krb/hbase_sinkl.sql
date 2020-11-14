CREATE TABLE ods_foo (
    id INT,
    name VARCHAR NOT NULL
) WITH (
    type ='kafka11',
    bootstrapServers ='kudu1:9092',
    offsetReset = 'latest',
    topic ='wuren_foo'
);

CREATE TABLE dwd_foo (
    cf1:id int as id ,
    cf1:name varchar as name
) WITH (
	type ='hbase',
	zookeeperQuorum ='eng-cdh1:2181,eng-cdh2:2181,eng-cdh3:2181',
	zookeeperParent ='/hbase',
	tableName ='wuren_java',
	partitionedJoin ='false',
	parallelism ='1',
	rowKey='id',
    kerberosAuthEnable='true',
    regionserverPrincipal='hbase/_HOST@DTSTACK.COM',
    clientKeytabFile='/Users/luna/etc/cdh/keytab/hbase-master.keytab',
    securityKrb5Conf='/Users/luna/etc/cdh/keytab/krb5.conf',
    -- clientKeytabFile='hbase-master.keytab',
    -- securityKrb5Conf='krb5.conf',
    clientPrincipal='hbase/eng-cdh1@DTSTACK.COM'
);

INSERT INTO dwd_foo
    SELECT ods_foo.id, ods_foo.name
    FROM ods_foo;