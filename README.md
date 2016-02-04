ZanoxRB [![Build Status](https://travis-ci.org/mozestudio/zanox-rb.svg)](https://travis-ci.org/mozestudio/zanox-rb) [![Gem Version](https://img.shields.io/gem/v/zanoxrb.svg)](https://rubygems.org/gems/zanoxrb)
=======
A Ruby wrapper for Zanox's RESTful APIs because all the current alternatives outta here are shit.

Currently it supports only `GET` requests (aka, read-only).

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

Every call will return a native Ruby hash or an array reflecting the original documentation provided by Zanox.

Alternatively you can use the native wrappers provided inside `resources/`.
They are a few and also they're under development, and if you need something complex probably they might be not the best choice, but for just reading and manipulate collections they're useful enough since there is no need to work on raw data.

Note also that the pagination in Zanox APIs is 0-indexed. For example, if you want to get the second page of the requested products list you have to pass `page: 1` to the optional params, otherwise you'll get, of course, the first page that actually is referrable as `page: 0`.
Consider using `Zanox::Response#next_page` and `Zanox::Response#previous_page` to navigate through the pages.

For debugging purpose, consider also to enable info logs by executing `Zanox::API.debug!`.
