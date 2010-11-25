require 'spec_helper'

describe SessionController do

  describe "GET 'get_file'" do
    it "should be successful" do
      get 'get_file'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

end
