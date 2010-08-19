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

get '/table' do
  erb :table
end

get '/upload' do
  erb :upload_form
end

post '/upload' do
  unless params[:upload] &&
      (tmpfile = params[:upload][:tempfile]) &&
      (name = params[:upload][:filename])
    "No file selected"
  else
    "File #{name} uploaded"
  end
end

get '/protected' do
  auth = Rack::Auth::Basic::Request.new(request.env)
  if auth.provided? && auth.basic? && auth.credentials &&
      auth.credentials == ['username', 'password']
    "Authorized!"
  else
    response['WWW-Authenticate'] = %(Basic realm="Protected")
    throw :halt, [ 401, 'Authorization Required' ]
  end
end

