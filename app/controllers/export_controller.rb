class ExportController < ApplicationController
  
  def new    
  end
  
  def create    
    client = get_client 
    @user = client.me.info                       
    
    generate_profile_file(JSON.pretty_generate(@user))    
    generate_album_file
    generate_wall_file
    generate_friend_list_file
    
    send_data generate_tgz("#{RAILS_ROOT}/tmp/export#{Process.pid}"), :filename => 'Facebook-export.zip'    
  end
end
