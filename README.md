ZanoxRB [![Build Status](https://travis-ci.org/mozestudio/zanox-rb.svg)](https://travis-ci.org/mozestudio/zanox-rb)
=======
A Ruby wrapper for Zanox's RESTful APIs because all the current alternatives outta here are shit.
Currently supporting only `GET` requests (aka, read-only).

Install
=======
`$ gem install zanoxrb`

Usage
=====
To store the Zanox keys safely, consider to store them inside your environment variables:
```
$ export ZANOX_CONNECT_ID=''
$ export ZANOX_SECRET_KEY=''
```

To make requests to the APIs, call `Zanox::API#request` passing the endpoint of the method you want to call and optionally a hash with one or more params (such as `q`, `date`, `programs`, etc.) based on the official documentation you can find [here](https://developer.zanox.com/web/guest/publisher-api-2011/).

Every call will return a native Ruby hash or an array reflecting the original documentation provided by Zanox (I plan to also wrap every response inside a class that allows to get every value following the Ruby-way, btw).

For debugging purpose, consider also to enable info logs by executing `Zanox::API.debug!`.
