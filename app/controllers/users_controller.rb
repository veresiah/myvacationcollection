class UsersController < ApplicationController

  get '/users/login' do
    erb :'/users/login'
  end

  post 'users/login' do 
    erb :'users/homepage'
  end 

  get '/users/:slug' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id  
    erb :'/users/homepage'
  end

  get 'users/signup' do 
    erb :'users/signup'
  end 

  #post 'users/signup' do 
    #erb :/users/homepage
  #end 

  get '/users/logout' do 
    session.clear
    redirect '/'
  end
end