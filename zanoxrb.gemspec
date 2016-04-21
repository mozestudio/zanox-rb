Kernel.load 'lib/zanox/version.rb'

Gem::Specification.new { |s|
  s.name        = 'zanoxrb'
  s.version     = Zanox::VERSION
  s.author      = 'Giovanni Capuano'
  s.email       = 'webmaster@giovannicapuano.net'
  s.homepage    = 'http://github.com/mozestudio/zanoxrb'
  s.platform    = Gem::Platform::RUBY
  s.summary     = "A Ruby wrapper for Zanox's RESTful APIs."
  s.description = "A Ruby wrapper for Zanox's RESTful APIs because all the current alternatives outta here are shit."
  s.license     = 'BSD-2-Clause'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency             'httparty',                  '~> 0.13'
  s.add_dependency             'ruby-try',                  '~> 1.1'
  s.add_development_dependency 'rake',                      '~> 10.4'
  s.add_development_dependency 'rspec',                     '~> 3.3'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  s.add_development_dependency 'bundler',                   '~> 1.10'
  s.add_development_dependency 'vcr',                       '~> 3.0'
  s.add_development_dependency 'webmock',                   '~> 1.24'
}
