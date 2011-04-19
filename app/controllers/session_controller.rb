class SessionController < ApplicationController
  def new      
    @oauth = oauth_client
    redirect_to @oauth.url_for_oauth_code(:permissions => 'user_photos,user_about_me,read_stream')   
  end
  
  def create
    @oauth = oauth_client    
    access_token = @oauth.get_access_token(params["code"]) 
    session["token"] = params["code"]
    redirect_to export_new_path
  end      
end
