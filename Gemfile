#source 'https://rubygems.org'
source 'https://ruby.taobao.org/'

ruby File.read(File.expand_path('../.ruby-version', __FILE__)).strip if ENV.key?('DYNO')

gem 'travis-support',  github: 'travis-ci/travis-support'
gem 'activesupport', '~> 4.0'
gem 'addressable', '~> 2.3'

gem 'sinatra', '~> 1.4'
gem 'puma'
gem 'sentry-raven'
gem 'rack-ssl', '~> 1.4'
gem 'metriks',         '0.9.9.6'
gem 'metriks-librato_metrics', github: 'eric/metriks-librato_metrics'
gem 'coder'

group :development do
  gem 'rerun'
end

group :test do
  gem 'mocha',       '~> 0.10.0'
  gem 'pry'
  gem 'rspec',       '~> 3.0'
  gem 'simplecov',   require: false
  gem 'sinatra-contrib'
  gem "codeclimate-test-reporter", group: :test, require: nil
  gem "travis", '~> 1.8.0'
end
