class ClimbsController < ApplicationController
    
  get '/climbs' do
    @user = current_user
    @climbs = @user.climbs
    if logged_in?
      erb :'/users/account'
    else
      redirect '/login'
    end
  end

  get '/climbs/new' do
    if logged_in?
      erb :'climbs/new'
    else
      redirect '/login'
    end
  end
  
  post '/climbs/new' do # NOT WORKING
    @user = current_user
    if logged_in? && params[:name] != "" && params[:location] != "" && params[:status]  != ""
      @climb = Climb.create(name: params[:name], grade: params[:grade], location: params[:location], status: params[:status], category: params[:category], notes: params[:notes])
      @climb.user = current_user
      @climb.save
      redirect "/climbs/#{@climb.id}"
    else 
      flash[:error] = "REQUIRED: Climb name, location, and status."
      redirect "/climbs/new"
    end
  end

  get '/climbs/:id' do # NOT WORKING
    @user = current_user
    if !logged_in?
      redirect '/login'
    else
      if @user = current_user && @climb = @user.climbs.find_by(params[:id]) 
        erb :'/climbs/show'
      else
        erb :'/failure'
      end
    end
  end

  get '/climbs/:id/edit' do # NOT WORKING
    @user = current_user
    if !logged_in?
      redirect '/login'
    else
      if @user = current_user && @climb = @user.climbs.find_by(params[:id]) 
        erb :'/climbs/edit'
      else
        erb :'/failure'
      end
    end
  end

  patch '/climbs/:id' do # NOT WORKING
    @climb = Climb.find_by(params[:id])
    if params[:name].empty? || params[:location].empty? || params[:status].empty?
      redirect "/climbs/#{@climb.id}/edit"
    else
      @climb.update(name: params[:name], grade: params[:grade], location: params[:location], status: params[:status], category: params[:category], notes: params[:notes])
      @climb.save
      redirect "/climbs/#{@climb.id}"
    end
  end

  post '/climbs/:id/delete' do
    if logged_in?
      @climb = Climb.find_by_id(params[:id])
      if @climb.user == current_user
        @climb.delete
        redirect '/account'
      else
        redirect "/climbs/#{@climb.id}"
      end
    else
      redirect '/login'
    end
  end

end