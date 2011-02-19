class ExportController < ApplicationController
  
  def new    
  end
  
  def create    
    client = get_client                    
    if params[:profile] or params[:album] or params[:wall] or params[:friends] then    
      generate_profile_file(client) if params[:profile]    
      generate_album_file(client) if params[:album]
      generate_wall_file(client) if params[:wall]
      generate_friend_list_file(client) if params[:friends]                              
      send_data generate_tgz, :filename => 'Facebook-export.tgz'    
    else              
      redirect_to export_new_path, :notice => "You need to provide at least one option"
    end            
  end
end
