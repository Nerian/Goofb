class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def oauth_client
    oauth = Koala::Facebook::OAuth.new(
    ENV['FACEBOOK_APPLICATION_ID'], 
    ENV['FACEBOOK_APPLICATION_SECRET'], 
    'http://young-lightning-861.heroku.com/session/create')            
  end
                
  def get_graph                                                        
    graph = Koala::Facebook::GraphAPI.new(session[:access_token])          
  end         
  
  def generate_profile_file(graph)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/profile.txt", 'w') {|f| f.write(JSON.pretty_generate(graph.get_object('me'))) }        
  end         
      
  def generate_album_file(graph)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    Dir.mkdir("#{RAILS_ROOT}/tmp/export/albums") unless File.exists?("#{RAILS_ROOT}/tmp/export/albums")
        
    albums = graph.get_connections('me', 'albums') 
    albums.each do |album|              
      album_name = album['name'].downcase.tr(' ', '_')      
      Dir.mkdir("#{RAILS_ROOT}/tmp/export/albums/#{album_name}") unless File.exists?("#{RAILS_ROOT}/tmp/export/albums/#{album_name}")
      photos = graph.get_connections(album['id'], 'photos')
      photos.each do |photo|                               
        photo_name = ''
        if photo['name'].nil?
          photo_name = photo['id']
        else          
          photo_name = photo['name'].downcase.tr(' ', '_') 
        end
        url = URI.parse(photo['source'])           
        File.open("#{RAILS_ROOT}/tmp/export/albums/#{album_name}/#{photo_name}.jpg", 'w'){ |f| f.write(Net::HTTP.start(url.host, url.port) {|http| http.get(url.path)}.body)}
      end
    end                     
  end                    
  
  def generate_wall_file(graph)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/wall.txt", 'w') {|f| f.write(graph.get_connections('me','feed')) }        
  end                   
  
  def generate_friend_list_file(graph)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/friends.txt", 'w') {|f| f.write(graph.get_connections('me','friends')) }    
  end
  
  def generate_tgz
    system("tar -czf #{RAILS_ROOT}/tmp/export.tgz --directory=#{RAILS_ROOT}/tmp export/")
    content = File.read("#{RAILS_ROOT}/tmp/export.tgz")   
  end
end
