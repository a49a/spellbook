CREATE TABLE ods_foo (
                         id INT,
                         name STRING NOT NULL
) WITH (
    type ='kafka11',
    bootstrapServers ='kudu1:9092',
    topic ='wuren_foo'
);

create table dim_i(
    id INT,
    name STRING,
    PERIOD FOR SYSTEM_TIME
) WITH (
    type='impala',
    url='jdbc:impala://eng-cdh3:21050',
    userName='1',
    password='1',
    tableName='wuren_i',
    authMech='3',
    parallelism ='1',
    partitionedJoin='false',
    --     cache ='ALL',
    authMech='1',
    principal='impala/eng-cdh3@DTSTACK.COM',
    -- keyTabFilePath='/Users/luna/etc/cdh/keytab/impalad-cdh3.keytab',
    -- krb5FilePath='/Users/luna/etc/cdh/keytab/krb5.conf',
    keyTabFilePath='impalad-cdh3.keytab',
    krb5FilePath='krb5.conf',
    krbRealm='DTSTACK.COM',
    krbHostFQDN='eng-cdh3',
    krbServiceName='impala'
);

CREATE TABLE outputtable(
  id    INT,
  name      STRING
) with (
  type  =  'console'
);

INSERT INTO outputtable
  SELECT ods_foo.id, dim_i.name
  FROM ods_foo 
  LEFT JOIN dim_i ON ods_foo.id = dim_i.id;