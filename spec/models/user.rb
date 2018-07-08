require "rails_helper"

RSpec.describe User, :type => :model do

  before(:each) do
    @user = User.new(name: "Test User", email: "test@test.com",
                     password: "password", password_confirmation: "password")
  end

  context "user valid" do
    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end

    it "is invalid with blank email" do
      @user.email = "     "
      expect(@user).to_not be_valid
    end

    it "is invalid when email is too long" do
      @user.email = "a" * 254 + "@test.com"
      expect(@user).to_not be_valid
    end

    it "is valid with valid email addresses" do
      valid_addresses = %w[test@test.com TEST@test.COM T_ES-T@test.test.test
                         test.test@test.test test+user@test.org]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it "is invalid with invalid email addresses" do
      invalid_addresses = %w[test@test,com test_user_1.com test.user@test.
                           test@user_1.com test@user+1.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end

    it "is invalid with duplicate email address" do 
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to_not be_valid
    end

    it "is invalid when password is blank" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).to_not be_valid
    end

    it "is invalid when password is short" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).to_not be_valid
    end

    context "post destroyed on user destroy" do
      it "should destroy post" do
        @user.save!
        @user.posts.create!(caption: "Test")
        expect { @user.destroy }.to change { Post.count }.by(-1)
      end
    end

    context "follow and unfollow a user" do
      it "should follow and unfollow user" do
        test1 = User.create(email: "test@test.com", password: "password")
        test2  = User.create(email: "test123@test.com", password: "password")
        expect(test1.following?(test2)).to be false
        test1.follow(test2)
        expect(test1.following?(test2)).to be true
        expect(test2.followers.include?(test1)).to be true
        test1.unfollow(test2)
        expect(test1.following?(test2)).to_not be true
      end
    end 
  end
end