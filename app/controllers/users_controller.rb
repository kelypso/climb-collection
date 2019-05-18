
class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      flash[:error] = "ERROR: Please enter email, username, and password to register."
      redirect "/signup"
    else
      User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/home'
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
      flash[:error] = "ERROR: Please enter username and password to log in."
      redirect '/login'
    else
      login(params[:username], params[:password])    
    end
  end

  get "/home" do
    if  !logged_in?
      flash[:error] = "ERROR: Please log in to view this page."
      redirect '/login'    
    else
      @user = User.find(session[:user_id])
      erb :'/users/home'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
    
end