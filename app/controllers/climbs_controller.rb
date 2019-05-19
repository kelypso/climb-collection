class ClimbsController < ApplicationController

  get '/home' do
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      @climbs = @user.climbs
      erb :'/users/home'
    else
      redirect '/login'
    end
  end

  get '/climbs/new' do
    if logged_in? && current_user
      @user = current_user
      session[:user_id] = @user.id
      erb :'climbs/new'
    else
      redirect '/login'
    end
  end
  
  post '/climbs' do 
    @user = current_user
    if logged_in? && params[:name] != "" && params[:location] != "" && params[:status]  != ""
      @climb = Climb.create(name: params[:name], grade: params[:grade], location: params[:location], status: params[:status], category: params[:category], notes: params[:notes])
      @user.climbs << @climb
      redirect "/climbs/#{@climb.id}"
    else 
      flash[:error] = "ERROR: Enter climb name, location, and status."
      redirect '/climbs/new'
    end
  end
  
  get '/climbs/:id' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @climb = Climb.find_by_id(params[:id]) 
      erb :'/climbs/show'
    end
  end

  get '/climbs/:id/edit' do 
    if !logged_in?
      redirect '/login'
    else
      @climb = current_user.climbs.find_by_id(params[:id]) 
      erb :'/climbs/edit'
    end
  end

  patch '/climbs/:id' do # NOT WORKING
    @climb = Climb.find_by_id(params[:id])
    if logged_in? && params[:name] != "" && params[:location] != "" && params[:status]  != ""
      @climb.update(name: params[:name], grade: params[:grade], location: params[:location], status: params[:status], category: params[:category], notes: params[:notes])
      @climb.save
      redirect "/climbs/#{@climb.id}"
    else 
      flash[:error] = "ERROR: Enter climb name, location, and status."
      redirect "/climbs/#{@climb.id}/edit"
    end
  end
  
  post '/climbs/:id/delete' do
    if logged_in?
      @climb = current_user.climbs.find_by_id(params[:id])
      @climb.delete
      redirect '/home'
    else
      redirect "/failure"
    end
  end

end