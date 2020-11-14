CREATE TABLE ods_foo (
    id INT,
    name VARCHAR NOT NULL
) WITH (
    type ='kafka11',
    bootstrapServers ='kudu1:9092',
    topic ='wuren_foo'
);

CREATE TABLE dwd (
    name varchar,
    id int
) WITH (
    type='kudu',
    kuduMasters='eng-cdh1',
    tableName='foo',
    writeMode='upsert',
    parallelism ='1',
    keytab='/Users/luna/etc/cdh/keytab/kudu-master.keytab',
    krb5conf='/Users/luna/etc/cdh/keytab/krb5.conf',
    principal='kudu/eng-cdh1@DTSTACK.COM'
);

INSERT INTO dwd
    SELECT ods_foo.id, ods_foo.name
    FROM ods_foo;
