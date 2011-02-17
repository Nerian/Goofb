class ExportController < ApplicationController
  
  def new    
  end
  
  def create
    #send_data generate_tgz("#{RAILS_ROOT}/tmp/myfile_#{Process.pid}"), :filename => 'Facebook-export.tgz'
    
    client = facebook_client                 
    access_token = client.authorize(:code => session["token"]) 
    @user = client.me.info                       
    generate_profile_file(JSON.pretty_generate(@user))    
    send_file "#{RAILS_ROOT}/tmp/profile.txt#{Process.pid}", :filename => 'Facebook-export.txt'    
  end
end
