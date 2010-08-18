#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'erb'

disable :logging
STDOUT.sync = true

get '/' do
  erb :index
end

get '/form' do
  erb :form
end

post '/form' do
  erb :form_output
end
