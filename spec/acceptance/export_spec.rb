# coding: UTF-8 
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "The user" do 
  scenario "can login in Facebook" do
    visit('/')
    click_link('Click here to connect to Facebook')
    if current_path != '/export/new'
      page.fill_in 'Email', :with => ENV['fb_email']
      page.fill_in 'Password', :with => ENV['fb_password']                 
      page.click_button 'Login'
    end
    page.should have_content('Select the resources that you want to export')        
  end                            
    
  scenario "can download his profile" do
    login
    page.check('Profile')
    page.click_button('Export')
    page.response_headers['Content-Type'].should == "application/octet-stream"         
  end    
end
