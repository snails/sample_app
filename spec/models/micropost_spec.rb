require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }

  before do
    # @micropost = Micropost.new(content:"I Love U", user_id: user.id)
    @micropost = user.microposts.build(content: "I Love U")
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "it can't be blanck" do
    before { @micropost.content = "" }
    it { should_not be_valid }
  end

  describe "it can't be over 140 chractors" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

end
