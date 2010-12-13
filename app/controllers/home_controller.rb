class HomeController < ApplicationController
  def index
  end
  
  def show
    client = FacebookOAuth::Client.new(
        :application_id => '104108729662859',
        :application_secret => 'acb7a93d8e5938f3b5663c81b0862c88',
        :callback => 'http://goofb.webbyapp.com/session/create'
    )                 
    access_token = client.authorize(:code => session["token"]) 
    @user = client.me.info       
    render :json => JSON.pretty_generate(@user)   
  end
end
