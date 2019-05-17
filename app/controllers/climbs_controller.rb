class ClimbsController < ApplicationController
    
  get '/climbs/new' do
    @climbs = Climb.all
    if logged_in?
      erb :'/climbs/new'
    else
      redirect '/login'
    end
  end
  
  post '/climbs/new' do
   if params[:name].empty? || params[:location].empty? || params[:status].empty? # || !logged_in?
     redirect '/climbs/new'
   else
     @climb = Climb.create(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
     @climb.user = User.find_by(params[:id])
     @climb.save
     redirect "/climbs/#{@climb.id}"
   end
 end

  get '/all' do
    if  !logged_in?
      redirect '/failure'    
    else
      @climbs = Climb.all
      @user = User.find(session[:user_id])   
      erb :'/climbs/all'
    end
  end

  get '/climbs/:id' do
    @climb = Climb.find(params[:id])
    @user = User.find(session[:user_id])
    erb :'climbs/show'
  end
  
  get '/climbs/:id/edit' do
    if logged_in?
      @climb = Climb.find_by_id(params[:id])
      erb :'/climbs/edit'
    else
      redirect '/failure'
    end
  end

  post '/climbs/:id' do
    @climb = Climb.find_by_id(params[:id])
    if params[:name].empty? || params[:location].empty? || params[:status].empty? # || !logged_in?
      redirect "/climbs/#{@climb.id}/edit"
    else
      if @climb.user == current_user
        @climb.update(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
        @climb.save
        redirect "/climbs/#{@climb.id}"
      else
        redirect "/users/failure"
      end
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
      redirect '/failure'
    end
  end

end