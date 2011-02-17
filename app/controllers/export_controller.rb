class ExportController < ApplicationController
  
  def new    
  end
  
  def create
    #send_data generate_tgz("#{RAILS_ROOT}/tmp/myfile_#{Process.pid}"), :filename => 'Facebook-export.tgz'
    send_file "#{RAILS_ROOT}/tmp/example.txt", :filename => 'Facebook-export.txt'    
  end
end
