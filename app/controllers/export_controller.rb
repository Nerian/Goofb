class ExportController < ApplicationController
  
  def new    
  end
  
  def create    
    client = get_client 
    @user = client.me.info                       
    
    generate_profile_file(JSON.pretty_generate(@user)) if params[:profile]    
    generate_album_file if params[:album]
    generate_wall_file if params[:wall]
    generate_friend_list_file if params[:friends]
    
    send_data generate_tgz("#{RAILS_ROOT}/tmp/export#{Process.pid}"), :filename => 'Facebook-export.tgz'    
  end
end
