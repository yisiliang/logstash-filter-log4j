# logstash-filter-log4j

Parse log4j logs to logstash, sample as below

```log
[2020-10-14 20:17:00,062][org.hibernate.jdbc.ConnectionManager.afterTransaction(ConnectionManager.java:325)][DefaultQuartzScheduler_Worker-4]transaction completed on session with on_close connection release mode; be sure to close the session to release JDBC resources!
```
to
```json
{
    "timestamp": "2020-10-14T12:17:00.062Z",
    "className": "org.hibernate.jdbc.ConnectionManager.java",
    "funcName": "afterTransaction",
    "thradName": "DefaultQuartzScheduler_Worker-4",
    "message": "transaction completed on session with on_close connection release mode; be sure to close the session to release JDBC resources!",
    "@timestamp": "2020-10-14T12:17:00.115Z",
    "originMessage": "[2020-10-14 20:17:00,062][org.hibernate.jdbc.ConnectionManager.afterTransaction(ConnectionManager.java:325)][DefaultQuartzScheduler_Worker-4]transaction completed on session with on_close connection release mode; be sure to close the session to release JDBC resources!"

}
```
