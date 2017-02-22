require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do
      @errorMessages = [
        'can\'t be blank',
        'is too short',
        'has already been taken']
      @password = '1234abcd!'
      @user1 = User.new(
       first_name:'Tom',
       last_name:'Travolta',
       email:'tom@travolta.com',
       email_confirmation: 'tom@travolta.com',
       password: @password,
       password_confirmation: @password)
      @user2 = User.new(
       first_name:'Tom',
       last_name:'Travolta',
       email:'tom2@travolta.com',
       email_confirmation: 'tom2@travolta.com',
       password: @password,
       password_confirmation: @password)
    end

    it "Initial user should be valid" do
      expect(@user1).to be_valid
      expect(@user1.errors.messages == nil)
      expect(@user1).inspect
    end

    it "should require an email" do
      @user1.email = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:email][0] == @errorMessages[0])
    end

    it "email confirmation should equivalent to email" do
      @user1.email_confirmation = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:email_confirmation][0] == @errorMessages[0])
    end

    it "should require a first name" do
      @user1.first_name = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:first_name][0] == @errorMessages[0])
    end

    it "should require a last name" do
      @user1.last_name = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:last_name][0] == @errorMessages[0])
    end

    it "should require a password" do
      @user1.password = nil
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:password][0] == @errorMessages[0])
    end

    it "should require a password" do
      @user1.password = '123'
      @user1.password_confirmation = '123'
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:password][0] == @errorMessages[1])
    end

    it "email shoud be unique" do
      @user2.save
      @user1.email = @user2.email
      @user1.email_confirmation = @user2.email
      expect(@user1).to be_invalid
      expect(@user1.errors.messages[:email][0] == @errorMessages[2])
    end

  end

  describe '.authenticate_with_credentials' do

    before(:each) do
      @errorMessages = [
        'can\'t be blank',
        'is too short',
        'has already been taken']
      @password = '1234abcd!'
      @user1 = User.new(
       first_name:'Tom',
       last_name:'Travolta',
       email:'tom@travolta.com',
       email_confirmation: 'tom@travolta.com',
       password: @password,
       password_confirmation: @password)
      @user2 = User.new(
       first_name:'Tom',
       last_name:'Travolta',
       email:'tom2@travolta.com',
       email_confirmation: 'tom2@travolta.com',
       password: @password,
       password_confirmation: @password)
    end

    it "Initial user should be valid" do
      @user1.save
      @user = User.authenticate_with_credentials( @user1.email, @user1.password)
      expect(@user).to_not be_nil
      expect(@user.errors.messages == nil)
    end

    it "Email text shoud not be case sensitve" do
      @user1.save
      @user = User.authenticate_with_credentials( @user1.email.upcase, @user1.password)
      expect(@user).to_not be_nil
    end

    it "Email text shoud be stripped" do
      @user1.save
      @user = User.authenticate_with_credentials( ' '+@user1.email.upcase+'     ', @user1.password)
      expect(@user).to_not be_nil
    end

    it "password should match email" do
      @user2.save
      @user3 = User.authenticate_with_credentials( @user1.email, @user2.password)
      expect(@user3).to be_nil
    end

  end
end
