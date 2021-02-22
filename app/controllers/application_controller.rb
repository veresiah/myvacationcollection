#require 'securerandom'
class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "myvaca_so_secret"
  end

  get '/' do 
    erb :index
  end 

  helpers do 
    def logged_in? 
      !!current_user 
    end 

    def current_user 
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end 

    def redirect_to_login 
      redirect "/users/login"
    end 

    def redirect_to_homepage
      redirect "/users/:slug"
    end 

end
