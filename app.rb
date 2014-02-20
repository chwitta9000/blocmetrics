# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'

enable :sessions

class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 6 }
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
    redirect "users/#{@user.id}", :notice => 'Your user account was created successfully!'
  else
    redirect "users/new", :error => 'Something went wrong.  Please try again.'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"users/show"
end