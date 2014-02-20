# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class User < ActiveRecord::Base
end

get '/' do
  @users = User.order('created_at DESC')
  erb :"users/index"
end

get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    redirect "users/#{@user.id}"
  else
    erb :"users/new"
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"users/show"
end