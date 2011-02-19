class ExportController < ApplicationController
  
  def new    
  end
  
  def create    
    client = get_client 
    @user = client.me.info                       
    
    if params[:profile] or params[:album] or params[:wall] or params[:friends] then    
      generate_profile_file(JSON.pretty_generate(@user)) if params[:profile]    
      generate_album_file if params[:album]
      generate_wall_file if params[:wall]
      generate_friend_list_file if params[:friends]                              
      send_data generate_tgz("#{RAILS_ROOT}/tmp/export#{Process.pid}"), :filename => 'Facebook-export.tgz'    
    else
      render :new, :notice => "You need to select at least one option" 
    end            
  end
end
