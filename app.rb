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

# Helper methods
helpers do 
  include Rack::Utils
  alias_method :h, :escape_html

  def protected!(user_id)
    return if authorized?(user_id)
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?(user_id)
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [User.find(user_id).email, User.find(user_id).password]
    # @auth.credentials == ['admin', 'admin']
  end
end

# Get all users
get '/' do
  @users = User.order('created_at DESC')
  erb :"users/index"
end

# Create new user
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

# View user profile
get '/users/:id' do
  protected!(params[:id])
  @user = User.find(params[:id])
  erb :"users/show"
end

# Edit user profile
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :"users/edit"
end
put "/users/:id" do
  @user = User.find(params[:id])
  @user.update(params[:user])
  redirect "/users/#{@user.id}"
end


# private route that takes apart what i receive and store as events in the db