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
        
        require 'open-uri'
        File.open("#{RAILS_ROOT}/tmp/export/albums/#{album_name}/#{photo_name}", 'wb') do |dest|
          open(URI.parse(photo['source'], 'rb') do |src|
            dest.write(src.read)
          end
        end
        
        #File.open("#{RAILS_ROOT}/tmp/export/albums/#{album_name}/#{photo_name}.jpg", 'w'){ |f| f.write(Net::HTTP.start(url.host, url.port) {|http| http.get(url.path)}.body)}
      end
    end                     
  end         
    
  #def generate_album_file(client)
  #  Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
  #  Dir.mkdir("#{RAILS_ROOT}/tmp/export/album") unless File.exists?("#{RAILS_ROOT}/tmp/export/album")
  #  
  #  client.me.albums['data'].each do |album|   
  #    
  #    puts 'ALBUM'
  #    puts JSON.pretty_generate(album) 
  #    puts ' '                     
  #    puts " --> client.me.albums(album['id'])"
  #    puts JSON.pretty_generate(client.me.albums(album['id']))
  #    puts ' '
  #    
  #    client.me.albums(album['id']).each do |photo|
  #      puts ' A photo, in the each '
  #      puts JSON.pretty_generate(photo)
  #      puts ' '
  #      source = client.me.photos(photo['id']).source # not sure if you need to do source['data']
  #      file = open(source)
  #      content = file.read()
  #      File.open("#{RAILS_ROOT}/tmp/export/album/#{photo['id']}.jpg", 'w') {|f| content }
  #    end
  #  end
            
  #  File.open("#{RAILS_ROOT}/tmp/export/album/album.txt", 'w') {|f| f.write(JSON.pretty_generate(client.me.albums)) }    
  #end                   
  
  def generate_wall_file(client)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/wall.txt", 'w') {|f| f.write(JSON.pretty_generate(client.me.feed)) }        
  end                   
  
  def generate_friend_list_file(client)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/friends.txt", 'w') {|f| f.write(JSON.pretty_generate(client.me.friends)) }
    
  end
  
  def generate_tgz
    system("tar -czf #{RAILS_ROOT}/tmp/export.tgz --directory=#{RAILS_ROOT}/tmp export/")
    content = File.read("#{RAILS_ROOT}/tmp/export.tgz")   
  end
end
