
class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
      User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/climbs'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/failure' do
    erb :'/users/failure'
  end

  post "/login" do
    if params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
      login(params[:username], params[:password])    
    end
  end

  get "/account" do
    if  !logged_in?
      redirect '/failure'    
    else
      @user = User.find(session[:user_id])
      erb :'/users/account'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
    
end