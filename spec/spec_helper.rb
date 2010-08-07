require File.expand_path("../../expensives.rb", __FILE__)

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
