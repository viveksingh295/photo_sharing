require "rails_helper"

RSpec.describe Post, :type => :model do
  before(:all) do
    @user = User.create(email: "test@test.com", password: "password")
    @post = @user.posts.build(caption: "Test")
  end

  context "valid post" do
    it "should be valid" do
      expect(@post).to be_valid
    end

    it "should contain user id" do
      @post.user_id = nil
      expect(@post).to_not be_valid
    end
  end
end