class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def facebook_client
    client = FacebookOAuth::Client.new(
        :application_id => '104108729662859',
        :application_secret => 'acb7a93d8e5938f3b5663c81b0862c88',
        :callback => 'http://young-lightning-861.heroku.com/session/create'
    )    
  end
end
