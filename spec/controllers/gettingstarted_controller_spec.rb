require 'spec_helper'

describe GettingstartedController do

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'step1'" do
    it "returns http success" do
      get 'step1'
      response.should be_success
    end
  end

end
