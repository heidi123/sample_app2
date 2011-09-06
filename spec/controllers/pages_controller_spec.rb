require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    before(:each) do
      @base_title = "Ruby on Rails Tutorial Sample App"
    end
    it "should be successful" do
      get 'home'
      response.should be_success
      response.should have_selector("title",
                    :content => "#{@base_title} | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
      response.should have_selector("title",
                    :content => "#{@base_title} | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
      response.should have_selector("title",
                    :content => "#{@base_title} | About")
    end
  end
end
