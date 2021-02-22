class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do 
    erb :'users/homepage'
  end 

  get '/users/:slug' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id  
    erb :'users/homepage'
  end

  get '/signup' do 
    erb :'users/signup'
  end 

  post '/signup' do 
    erb :'users/homepage'
  end 

  get '/logout' do 
    session.clear
    redirect '/'
  end
end