require 'spec_helper'

describe ExportController do

  describe "GET 'get_file'" do
    it "should be successful" do
      get 'get_file'
      response.should be_success
    end
  end

end
