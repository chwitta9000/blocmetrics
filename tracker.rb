require 'sinatra'

get '/' do
  erb :index
  #{}"Hello world, it's #{Time.now} at the server!"
end


#ajax get request
# http://stackoverflow.com/questions/1459211/jquery-ajax-get-example


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


