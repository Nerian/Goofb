class SessionController < ApplicationController
  def new      
    @oauth = oauth_client
    redirect_to @oauth.url_for_oauth_code(:permissions => 'user_photos,user_about_me,read_stream')   
  end
  
  def create
    session[:access_token] = Koala::Facebook::OAuth.new('http://young-lightning-861.heroku.com/session/create').get_access_token(params[:code]) if params[:code]        
    redirect_to export_new_path
  end      
end
