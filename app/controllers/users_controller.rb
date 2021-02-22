class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/homepage'
  end

  get '/signup' do 
    if !logged_in?
    erb :'users/signup' , locals: {message: "Please finish signing up before you sign in"}
    else 
      redirect_to_homepage
    end 
  end 

  post '/signup' do 
    erb :'users/homepage'
  end 

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do 
    erb :'users/homepage'
  end 

  get '/logout' do 
    session.clear
    redirect '/'
  end
end