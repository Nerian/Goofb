class ExportController < ApplicationController
  
  def new     
    if session[:access_token]
      @graph = get_graph        
      @albums = @graph.get_connections('me', 'albums')        
    else
      redirect_to 'home#index', :flash => "First click on 'Click here to connect to facebook'"
    end
        
  end
  
  def create    
    graph = get_graph                    
    if params[:profile] or params[:album] or params[:wall] or params[:friends] then    
      generate_profile_file(graph) if params[:profile]    
      generate_album_file(graph) if params[:album]
      generate_wall_file(graph) if params[:wall]
      generate_friend_list_file(graph) if params[:friends]                              
      send_data generate_tgz, :filename => 'Facebook-export.tgz'    
    else              
      redirect_to export_new_path, :notice => "You need to provide at least one option"
    end            
  end
end
