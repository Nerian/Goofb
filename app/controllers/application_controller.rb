class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def facebook_client
    client = FacebookOAuth::Client.new(
        :application_id => ENV['FACEBOOK_APPLICATION_ID'],
        :application_secret => ENV['FACEBOOK_APPLICATION_SECRET'],
        :callback => 'http://young-lightning-861.heroku.com/session/create'
    )    
  end
                
  def get_client
    client = facebook_client                 
    access_token = client.authorize(:code => session["token"])
    client    
  end         
  
  def generate_profile_file(content)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export") unless File.exists?("#{RAILS_ROOT}/tmp/export")
    File.open("#{RAILS_ROOT}/tmp/export/profile.txt", 'w') {|f| f.write(content) }        
  end
  
  def generate_album_file(client)
    Dir.mkdir("#{RAILS_ROOT}/tmp/export/album") unless File.exists?("#{RAILS_ROOT}/tmp/export/album")
            
    File.open("#{RAILS_ROOT}/tmp/export/album/album.txt", 'w') {|f| f.write(client.me.albums) }    
  end                    
  
  def generate_wall_file
    
  end                   
  
  def generate_friend_list_file
    
  end
  
  def generate_tgz
    system("tar -czf #{RAILS_ROOT}/tmp/export.tgz --directory=#{RAILS_ROOT}/tmp export/")
    content = File.read("#{RAILS_ROOT}/tmp/export.tgz")   
  end
end
