class HomeController < ApplicationController
  def index
  end
  
  def show
    client = facebook_client                 
    access_token = client.authorize(:code => session["token"]) 
    @user = client.me.info       
    render :json => JSON.pretty_generate(@user)   
  end
end
