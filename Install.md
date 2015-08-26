There are no binaries for the Limbo Machine yet. Please use the  [source](http://code.google.com/p/limbo-machine/source) code as described below.

  * Checkout the trunk as described [here](http://code.google.com/p/limbo-machine/source) (limbo-machine directory should be accessible from Inferno)
  * Start emu
```
$ emu
```
  * Go to the limbo-machine directory
  * Build everything
```
; mk clean all
```
  * You can also build a [styx.js](JS.md) file.
```
; mk styx.js
```

#### DB ####
There is a dbctl script which can mount the [DB](DB.md) service:
```
; /path/to/limbo-machine/dbctl
```
will print the usage info:
  * _dbctl start_ - starts the db service on the default port
  * _dbctl -p_

&lt;port&gt;

 start_- starts the db service on a given port
  *_dbctl stop_- stops the db service
  *_dbctl mount 

&lt;mountpoint&gt;

_- mounts the db service to a given directory_

#### Web ####
Please refer to [ModLM](ModLM.md) on how to build and run a sample web application.