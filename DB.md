### Overview ###

The application programming interface is organized as the file system (e.g. as the networking in Inferno).

```
/db/         <-- DB API root
    ctl      <-- API control file
    /25/     <-- connection ID
        data <-- connection data file
```

A standard data encoding format (such as [json](http://www.vitanuova.com/inferno/man/6/json.html), [symbolic expressions](http://www.vitanuova.com/inferno/man/6/sexprs.html) or [ubfa](http://www.vitanuova.com/inferno/man/6/ubfa.html)) can be used to talk to the service.

The following examples use JSON, but this is not necessarily the case.

Connect to the database:
```
; echo '{"type":"connect", "addr":"tcp!localhost!7777", "user":"u" "passwd":"p"}' > /db/ctl
; cat /db/ctl
{"type":"connect", "id":25}
```

Execute a query:
```
; echo '{"q":"select * from a"}' > /db/25/data
; cat /db/25/data
...
```

#### Notes ####

To speed up drivers development a bridge can be build between Limbo and existing C driver implementation (see limbo [-T option](http://www.vitanuova.com/inferno/man/1/limbo.html)).

There is an ODBC [API](http://www.vitanuova.com/inferno/man/7/db.html) and [file server for windows](http://www.vitanuova.com/inferno/man/10/odbc.html) available. The DB interface described here will provide a platform independent solution.

There is a [libferris](http://witme.sourceforge.net/libferris.web/index.html) project which can expose the postgresql DB as the file system. A linux journal article on the subject can be found [here](http://www.linuxjournal.com/article/8901).

OC found an existing postgres driver for Limbo on the [net](http://www.maht0x0r.net/inferno). Here are some problems I faced with it:
  * Most probably Pg->PATH will not work for you
  * Connection hangs when wrong pass/user/db specified
  * Only plain password authentication can be used

### PostgreSQL Driver ###

We are building our own PostgreSQL driver for Limbo. Here is the psql [protocol](http://www.postgresql.org/docs/8.1/interactive/protocol.html) specification.

### API ###

Connect:
```
-> {"type":"connect", "addr":"tcp!localhost!5432", "user":"username", "passwd":"password"}
<- {"type":"connect", "id":25}
```

Error:
```
<- {"type":"error", "msg":"error message"}
```