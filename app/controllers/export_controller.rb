class ExportController < ApplicationController
  
  def new    
  end
  
  def create
    #send_data generate_tgz("#{RAILS_ROOT}/tmp/myfile_#{Process.pid}"), :filename => 'Facebook-export.tgz'
    File.open("#{RAILS_ROOT}/tmp/example.txt", 'w') {|f| f.write("Example") }      
    send_file "#{RAILS_ROOT}/tmp/example.txt", :filename => 'Facebook-export.txt'    
  end
end
