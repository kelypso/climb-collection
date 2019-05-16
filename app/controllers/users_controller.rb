class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      @climbs = Climb.all 
      erb :'climbs/climbs'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:email].empty? || params[:username].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/climbs'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      erb :'climbs/climbs'
    end
  end

  post '/login' do
    @user = User.find_by(params[:id])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/climbs'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end
  
end