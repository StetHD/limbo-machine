The idea is to have a single entry point for a number of Styx servers (e.g. `tcp!somehost!7777`, and then dispatch different paths to different Styx server implementations.

A sample configuration might look as follows:
```
; cat dispatch.cfg
map sample=/dummyfs
map net=/net

# server definitions
sample=sample.dis
net=redirect.dis path=/net
```

You can find the sketch in web/limbo source directory.

**nsbuild(1)** can do the similar job, so it is now questionable whether we need this module or not.

Comments are welcome.