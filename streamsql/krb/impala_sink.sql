CREATE TABLE ods_foo (
                         id INT,
                         name STRING NOT NULL
) WITH (
    type ='kafka11',
    bootstrapServers ='kudu1:9092',
    topic ='wuren_foo'
);

create table dwd_impala(
                        id int,
                        name STRING,

                        PRIMARY KEY(id)
) WITH (
    type='impala',
    url='jdbc:impala://eng-cdh3:21050',
    userName='1',
    password='1',
    storeType='KUDU',
    tableName='wuren_i',
    authMech='3',
    parallelism ='1',
    partitionedJoin='false',
    authMech='1',
    principal='impala/eng-cdh3@DTSTACK.COM',
    keyTabFilePath='impalad-cdh3.keytab',
    krb5FilePath='krb5.conf',
    batchSize='1',
    -- keyTabFilePath='/Users/luna/etc/cdh/keytab/impalad-cdh3.keytab',
    -- krb5FilePath='/Users/luna/etc/cdh/keytab/krb5.conf',
    krbRealm='DTSTACK.COM',
    krbHostFQDN='eng-cdh3',
    krbServiceName='impala'
);

-- CREATE TABLE outputtable(
--                             id    INT,
--                             name      VARCHAR
-- ) with (
--   type  =  'console'
-- );

INSERT INTO dwd_impala
SELECT ods_foo.id, ods_foo.name
FROM ods_foo;

-- INSERT INTO outputtable
-- SELECT ods_foo.id, ods_foo.name
-- FROM ods_foo;