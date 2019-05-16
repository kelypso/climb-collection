class ClimbsController < ApplicationController
  
  get '/climbs' do
    if logged_in?
      erb :'/climbs/climbs'
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
   if params[:name].empty? || params[:category].empty? || params[:grade].empty? || params[:location].empty? || params[:status].empty? ||
     !logged_in?
     redirect '/climbs/new'
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
   if params[:name].empty? || params[:category].empty? || params[:grade].empty? || params[:location].empty? || params[:status].empty?
     redirect "/climbs/#{@climb.id}/edit"
   else
     @climb.update(name: params[:name], category: params[:category], grade: params[:grade], location: params[:location], status: params[:status], notes: params[:notes])
     @climb.save
     redirect "/climbs/#{@climb.id}"
   end
 end

end