class SessionController < ApplicationController
  def new      
    client = FacebookOAuth::Client.new(
        :application_id => '104108729662859',
        :application_secret => 'acb7a93d8e5938f3b5663c81b0862c88',
        :callback => 'http://goofb.webbyapp.com/session/create'
    )                                                      
    redirect_to client.authorize_url    
  end
  
  def create
    client = FacebookOAuth::Client.new(
        :application_id => '104108729662859',
        :application_secret => 'acb7a93d8e5938f3b5663c81b0862c88',
        :callback => 'http://goofb.webbyapp.com/session/create'
    )                 
    access_token = client.authorize(:code => params["code"]) 
    session["token"] = params["code"]    
    @user = client.me.info.to_yaml
    redirect_to home_show_path
  end      
end
