require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "badbeta"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      erb :'/users/home'
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
        redirect "/home"
      else
        redirect "/login"
      end
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
end