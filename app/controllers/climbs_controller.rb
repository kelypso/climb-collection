class ClimbsController < ApplicationController
    
  get '/climbs' do
    @climbs = Climb.all
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

 post '/climbs' do
   if params[:name].empty? || params[:location].empty? || params[:status].empty?
     redirect '/failure'
   else
     @climb = Climb.create(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
     @climb.user = User.find_by(params[:id])
     @climb.save
     redirect "/climbs/#{@climb.id}"
   end
 end

 get '/climbs/:id' do
   if logged_in?
     @climb = Climb.find_by(params[:id])
     erb :'/climbs/show'
   else
     redirect '/login'
   end
 end

 get '/climbs/:id/edit' do
   if logged_in?
     @climb = Climb.find_by(params[:id])
     erb :'/climbs/edit'
   else
     redirect '/login'
   end
 end

 patch '/climbs/:id' do
   @climb = Climb.find_by(params[:id])
   if params[:name].empty? || params[:location].empty? || params[:status].empty?
     redirect "/climbs/#{@climb.id}/edit"
   else
     @climb.update(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
     @climb.save
     redirect "/climbs/#{@climb.id}"
   end
 end
 
 post '/climbs/:id' do
    @climb = Climb.find_by_id(params[:id])
    if params[:name].empty? || params[:location].empty? || params[:status].empty?
      redirect "/climbs/#{@climb.id}/edit"
    else
      if @climb.user == current_user
        @climb.update(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
        @climb.save
        redirect "/climbs/#{@climb.id}"
      else
        redirect "/climbs/#{@climb.id}"
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