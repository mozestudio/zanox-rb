ZanoxRB [![Build Status](https://travis-ci.org/mozestudio/zanox-rb.svg)](https://travis-ci.org/mozestudio/zanox-rb)
=======
A Ruby wrapper for Zanox's RESTful APIs because all the current alternatives outta here are shit.
Currently supporting only `GET` requests (aka, read-only). Documentation and RubyGems will come soon.

Setup
=====
To store the Zanox keys safely, consider to store them inside your environment variables:
```
$ export ZANOX_CONNECT_ID=''
$ export ZANOX_SECRET_KEY=''
```

For debugging purpose, consider also to enable info logs by setting `Zanox::API.debug` to `true`.
