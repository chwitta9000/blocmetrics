# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

get '/' do
  "Hello world!"
end

class User < ActiveRecord::Base


end


