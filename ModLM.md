### Introduction ###

This module acts as a gateway between the [JavaScript](JS.md) Styx protocol implementation and Styx servers run under [Inferno OS](http://code.google.com/p/inferno-os). The [JS](JS.md) library wraps Styx messages into HTTP posts (base16 encoded atm) and transmits them to httpd. [ModLM](ModLM.md) does the following:
  * decodes HTTP post from a client
  * transmits the binary message to a Styx server
  * reads a binary response from the Styx server
  * encodes the received message to HTTP response
  * sends HTTP response back to the client

### Installation ###

There are no binaries yet for the Limbo Machine. This section describes how to build and install the module from source. You will need [Apache2](http://httpd.apache.org) and APXS ([APache eXtenSion](http://httpd.apache.org/docs/2.2/programs/apxs.html) tool) to build the module. (Windows version of the APXS can be found [here](http://www.apachelounge.com/download).)

  * **svn co** as described [here](http://code.google.com/p/limbo-machine/source)
  * cd /path/to/limbo-machine/web/apache
  * apxs -llibhttpd -llibapr-1 -llibaprutil-1 -ci mod\_lm\_tunnel.c
  * edit apache config:
    * load the module (_apxs -a_ can make this for you):
```
LoadModule lm_module modules/mod_lm_tunnel.so
```
    * set handler
```
<Location /styx>
    SetHandler lm-tunnel
</Location>
```
    * make sure that http keep-alive is configured (it is important for the styx.js performance):
```
KeepAlive On
KeepAliveTimeout 15
MaxKeepAliveRequests 100
```
  * test
    * start apache (httpd -k start or sudo apache2 -k start)
    * open the following URL http://localhost/styx in your browser (please change host/port according to your configuration)
    * you should see the **Limbo Machine Tunnel** text

If the test was successful you can try our sample application:
  * make /path/to/limbo-machine/web/js available from apache
```
$ ln -s /path/to/limbo-machine/web/js /var/www/limbo-machine
```
  * start some Styx server on port 7777 (see N.B.)
```
$ emu
; styxlisten -A 'tcp!*!7777' export /
```
  * open the following URL http://localhost/limbo-machine/sample.html
  * click mount and then list (you just listed your / directory in inferno)
  * click unmount or close the page

ModLM writes some debugging info in apache log. This can be useful for trouble shooting.

### N.B. ###
Please note that:
  * Styx server address is currently hardcoded. It is tcp!localhost!7777. We will make it a configuration parameter in the future (see task #2).
  * Styx server connection dispatch is not _yet_ implemented. A separate server connection (or client identification) should exist for each client to properly handle fid and tag styx protocol fields.