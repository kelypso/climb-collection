class ClimbsController < ApplicationController
  
  get '/climbs' do
    if logged_in?
      erb :'/climbs/climbs'
    else
      redirect '/login'
    end
  end

 
  
end