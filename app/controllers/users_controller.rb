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
    if params[:firstname] == "" || params[:lastname] == "" || params[:username] == "" || params[:email] == "" || params[:password] == "" 
      flash[:message] = "Please fill out all fields"
      redirect to '/signup' 
    else 
      @user = User.create(:first_name => params[:firstname], :last_name => params[:lastname], :username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect_to_homepage
    end 
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