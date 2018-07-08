require "rails_helper"

RSpec.describe Subscription, :type => :model do
  before(:all) do
    test1 = User.create(email: "test321@test.com", password: "password")
    test2  = User.create(email: "test_123@test.com", password: "password")
    @subscription = Subscription.new(follower_id: test1.id, followed_id: test2.id)
  end

  context "valid Subscription" do
    it "should be valid" do
      expect(@subscription).to be_valid
    end

    it "should have a follower id" do
      @subscription.follower_id = nil
      expect(@subscription).to_not be_valid
    end

    it "should have a followed id" do
      @subscription.followed_id = nil
      expect(@subscription).to_not be_valid
    end
  end
end