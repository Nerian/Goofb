class SessionController < ApplicationController
  def new      
    client = facebook_client                                                      
    redirect_to client.authorize_url    
  end
  
  def create
    client = facebook_client                 
    access_token = client.authorize(:code => params["code"]) 
    session["token"] = params["code"]    
    @user = client.me.info.to_yaml
    redirect_to export_new_path
  end      
end
