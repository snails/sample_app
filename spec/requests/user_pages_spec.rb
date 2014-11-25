require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup functions" do

    before { visit signup_path }
    let(:submit) { "Create my account" }

    it "should not creat new user" do
      expect{ click_button submit }.not_to change(User, :count)
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "David"
        fill_in "Email",        with: "godhuyang@gmail.com"
        fill_in "Password",     with: "12345678"
        fill_in "Confirmation", with: "12345678"
      end 

      it "should create a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

  end
end
