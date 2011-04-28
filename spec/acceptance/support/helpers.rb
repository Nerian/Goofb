# coding: UTF-8 
module HelperMethods
  # Put helper methods you need to be available in all tests here.
  
  def login
    visit('/')
    click_link('Click here to connect to Facebook')
    if not have_content('Select the resources that you want to export')
      page.fill_in 'Email', :with => ENV['fb_email']
      page.fill_in 'Password', :with => ENV['fb_password']                 
      page.click_button 'Login'
    end
  end                            
end

RSpec.configuration.include HelperMethods, :type => :acceptance
