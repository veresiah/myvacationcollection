class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/homepage'
  end

  get '/signup' do 
    redirect_if_not_logged_in
    erb :'users/signup' 
  end 

  post '/signup' do 
    @user = User.create(:first_name => params[:firstname], :last_name => params[:lastname], :email => params[:email], :username => params[:username], :password => params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to_homepage
    else 
      flash[:error] = user.errors.full_messages.to_sentence
      redirect to '/signup' 
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
      flash[:message] = "Logged in Successfully"
      redirect_to_homepage
    else 
      redirect_to_login
    end 
  end 

  get '/logout' do 
    if logged_in?
      session.clear
      flash[:message] = "Logged out Successfully"
      redirect_to_index
    end 
  end
end