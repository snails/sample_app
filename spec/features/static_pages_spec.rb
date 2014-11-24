require 'rails_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_selector("h1", :text => "Home")
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby On Rails Tutorial Sample App | Home")
    end
    
    it "should not have a custom title '| Home'" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => "| Home")
    end

  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby On Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', :text => 'About US')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby On Rails Tutorial Sample App | About US")
    end
  end
end
