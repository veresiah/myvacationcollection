class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/homepage'
  end

  get '/signup' do 
    if !logged_in?
    erb :'users/signup' 
    #flash[:message] = "Please finish signing up before you sign in"
    else 
      redirect_to_homepage
    end 
  end 

  post '/signup' do 
    if params[:firstname] == "" || params[:lastname] == "" || params[:email] == "" || params[:username] == "" || params[:password] == "" 
      flash[:message] = "Please fill out all fields"
      redirect to '/signup' 
    else 
      @user = User.create(:first_name => params[:firstname], :last_name => params[:lastname], :email => params[:email], :username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect_to_homepage
    end 
  end 

  get '/login' do
    if !logged_in?
    erb :'/users/login'
    else 
    redirect_to_homepage
    end 
  end

  post '/login' do 
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to_homepage
    else 
      redirect_to_login
    end 
  end 

  get '/logout' do 
    if logged_in?
      session.clear
      redirect_to_login
    else
      redirect_to_index
    end 
  end
end