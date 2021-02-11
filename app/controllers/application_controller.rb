class ApplicationController < Sinatra::Base
  require 'securerandom'
  
  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get '/' do 
    erb :index
  end 

end
