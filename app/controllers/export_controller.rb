class ExportController < ApplicationController
  
  def new    
  end
  
  def create
    #send_data generate_tgz("#{RAILS_ROOT}/tmp/myfile_#{Process.pid}"), :filename => 'Facebook-export.tgz'
    generate_profile_file('Example2')
    
    send_file "#{RAILS_ROOT}/tmp/profile.txt#{Process.pid}", :filename => 'Facebook-export.txt'    
  end
end
