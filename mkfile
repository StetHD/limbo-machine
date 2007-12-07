# start server: mk start
# stop server: mk stop
# clean: mk clean
# build: mk build

# mount: mount -A tcp!localhost!7777 mnt
# unmount: unmount mnt

base = `pwd`
dis = $base/dis
web = $base/web
module = $base/module
db = $base/db
flags = -gw -I$module

init:
    mkdir $dis

clean:
    rm -rf $dis
    rm -f $base/*.dis $base/*.sbl

%.dis: %.b 
    limbo $flags -o $stem.dis $stem.b 
    mv $stem.dis $stem.sbl $dis

build: clean init $web/server.dis $web/sample.dis \
       $web/http.dis $web/dispatch.dis $web/export.dis \
       $db/postgres.dis $db/binary.dis $db/server.dis
    cp $web/dispatch.cfg $dis

start-web:
    cd $dis
    server &

start-db:
    cd $dis
    listen -A 'tcp!*!7778' server.dis

stop:
    kill -g Server