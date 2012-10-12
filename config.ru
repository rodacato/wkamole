require 'rubygems'
require 'bundler/setup'

::RACK_ENV = ENV['RACK_ENV'] || 'development'

Bundler.require(:default, RACK_ENV)

# Setting loggers
#logger = File.new("logs/#{RACK_ENV}.log", "a")
#STDOUT.reopen(logger)
#STDERR.reopen(logger)

require File.dirname(__FILE__) + '/phantom'

#use Rack::CommonLogger, logger
run WkaMole::Extractor
