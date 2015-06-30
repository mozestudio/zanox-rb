#! /usr/bin/env ruby
require 'rake'

task default: [ :build, :install, :test ]

task :build do
  `gem build zanoxrb.gemspec`
end

task :install do
  `gem install *.gem`
end

task :test do
  FileUtils.cd 'specs' do
    Dir['*_spec.rb'].each do |spec|
      sh "rspec #{spec} --backtrace --color --format doc"
    end
  end

  FileUtils.cd 'specs/resources' do
    Dir['*_spec.rb'].each do |spec|
      sh "rspec #{spec} --backtrace --color --format doc"
    end
  end
end
