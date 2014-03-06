# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'
require './models/user.rb'
require './models/application.rb'

enable :sessions

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
  erb :"index"
end

get '/users/index' do
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
    redirect "/", :notice => 'Your user account was created successfully!'
  else
    redirect "/", :error => 'Something went wrong.  Please try again.'
  end
end

# View user profile
get '/users/show/:id' do
  protected!(params[:id])
  @user = User.find(params[:id])
  @applications = @user.applications
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

get '/index' do
  erb :"index"
end

get '/users/:id/applications/:id' do
  @user = User.find(params[:user_id])
  @application = @user.applications.find(params[:id])
end

# private route that takes apart what i receive and store as events in the db

get '/tracking-hit' do
  erb :index

  #json params
  #javascript will send params here

  #puts params

  #parse stuff to use elewhere - create objects - using ruby
    #event object
    #what URL, save objects associated with that application
    #search by app 
end





