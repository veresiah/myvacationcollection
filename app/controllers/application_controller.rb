class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"
    use Rack::Flash
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
      redirect "/login"
    end 

    def redirect_to_index
      redirect "/"
    end 

    def redirect_to_homepage
      redirect "/users/:slug"
    end 

    def redirect_if_not_logged_in
      redirect "/login" if !logged_in?
  end
end
