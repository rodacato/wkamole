require 'rubygems'
require 'bundler/setup'
require File.dirname(__FILE__) + '/phantom'

::RACK_ENV = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, RACK_ENV)

run WkaMole::Extractor
