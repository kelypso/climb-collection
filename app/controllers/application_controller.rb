require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "kinectopatronom"
  end

  get "/" do
    if logged_in?
      erb :'/users/account'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def login(username, password)
      session[:username] = username
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/account"
      else
        redirect "/login"
      end
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
end