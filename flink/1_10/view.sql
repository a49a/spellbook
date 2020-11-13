CREATE TABLE ods_foo (
    id INT,
    name STRING
) WITH (
  'connector.type' = 'kafka',

  'connector.version' = '0.11',     -- required: valid connector versions are
                                    -- "0.8", "0.9", "0.10", "0.11", and "universal"
  'connector.topic' = 'wuren_foo', -- required: topic name from which the table is read

  'connector.properties.bootstrap.servers' = 'localhost:9092', -- required: specify the Kafka server connection string
  'connector.properties.group.id' = 'group_foo', --optional: required in Kafka consumer, specify consumer group
  'connector.startup-mode' = 'earliest-offset',    -- optional: valid modes are "earliest-offset",

  'format.type' = 'json',
)

CREATE TABLE dwd_foo (
  id INT,
  name STRING
) WITH (
  'connector.type' = 'jdbc', -- required: specify this table type is jdbc

  'connector.url' = 'jdbc:mysql://localhost:3306/flink_dev', -- required: JDBC DB url

  'connector.table' = 'jdbc_table_name',  -- required: jdbc table name

  'connector.driver' = 'com.mysql.jdbc.Driver', -- optional: the class name of the JDBC driver to use to connect to this URL.
                                                -- If not set, it will automatically be derived from the URL.
  'connector.username' = 'root', -- optional: jdbc user name and password
  'connector.password' = 'root',
)

CREATE VIEW view_foo AS SELECT * FROM ods_foo;

INSERT INTO dwd_foo SELECT id, name FROM view_foo;