ZanoxRB
=======
A Ruby wrapper for Zanox's RESTful APIs because all the current alternatives outta here are shit.

Setup
=====
To store the Zanox keys safely, consider to store the keys inside your environment variables:
```
$ export ZANOX_CONNECT_ID=''
$ export ZANOX_SECRET_KEY=''
```

For debugging purpose, consider also to enable info logs by setting `Zanox::API.debug` to `true`.
