class SessionController < ApplicationController
  def new      
    @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APPLICATION_ID'], ENV['FACEBOOK_APPLICATION_SECRET'], 'http://young-lightning-861.heroku.com/session/create')
    puts @oauth
    
    redirect_to @oauth.url_for_oauth_code(:permissions => 'user_photos,user_about_me,read_stream')   
  end
  
  def create
    @oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APPLICATION_ID'], ENV['FACEBOOK_APPLICATION_SECRET'], 'http://young-lightning-861.heroku.com/session/create')
    
    access_token = @oauth.get_access_token(params["code"]) 
    session["token"] = params["code"]
    redirect_to export_new_path
  end      
end
