require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a User if all of the validations are true' do
    user = User.new(username: "Jane",  email: "janedoe@yahoo.ca", password: "pass", password_confirmation: "pass")

    user.valid?

    expect(user.errors).not_to include("can't be blank")
    end

    it 'should not create a User if their username is missing' do
    user = User.new( email: "PaulaLola@yahoo.ca", password: "pass123", password_confirmation: "pass123")
    puts user
    user.valid?
    expect(user.errors[:username]).to include("can\'t be blank")
    end

    it 'should not create a User if their email is missing' do
    user = User.new( username: "Paula", password: "pass123", password_confirmation: "pass123")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
    end

    it 'should not create a User if their email is not unique' do
    user1 = User.new(username: "Paula",  email: "Paula@hotmail.ca", password: "pass123", password_confirmation: "pass123")
    user1.save
    user2 = User.new(username: "Paula",  email: "Paula@hotmail.ca", password: "pass123", password_confirmation: "pass123")
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
    end

    it 'should not create a User if their passwords do not match' do
    user = User.new(username: "Paula",  email: "Paula@hotmail.ca", password: "pass123", password_confirmation: "pass123G")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end

    it 'should not create a User if there is no password' do
    user = User.new(username: "Paula",  email: "Paula@hotmail.ca")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can\'t be blank")
    end

    it 'should not create a User if there the password is too short' do
    user = User.new(username: "Paula",  email: "Paula@hotmail.ca", password: "ABC", password_confirmation: "ABC")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end


  describe '.authenticate_with_credentials' do
    it 'should log the user in if the credentials are correct' do
      user = User.new(
        username: 'user',
        email: 'paulvanderbilt4@hotmail.ca',
        password: 'pass123',
        password_confirmation: 'pass123'
      )

      user.save
      validUser = User.authenticate_with_credentials("paulvanderbilt4@hotmail.ca", "pass123")
      
      expect(validUser).to eq(user)
    end

    it 'should not log the user in if the email is wrong' do
      user = User.new(
        username: 'user',
        email: 'paulvanderbilt4@hotmail.ca',
        password: 'pass123',
        password_confirmation: 'pass123'
      )
      
      user.save
      invalidUser = User.authenticate_with_credentials("paaeb4@hotmail.ca", "pass123")
      
      expect(invalidUser).to_not eq(user)
    end

    it 'should not log the user in if the password is wrong' do
      user = User.new(
        username: 'user',
        email: 'paulvanderbilt4@hotmail.ca',
        password: 'pass123',
        password_confirmation: 'pass123'
      )

      user.save
      invalidUser = User.authenticate_with_credentials("paulvanderbilt4@hotmail.ca", "pas23")
      
      expect(invalidUser).to_not be(user)
    end

    it 'should log the user in, even if the email contains spaces' do
      
      user = User.new(
        username: 'user',
        email: 'paulvanderbilt4@hotmail.ca',
        password: 'pass123',
        password_confirmation: 'pass123'
      )

      user.save
      validUser = User.authenticate_with_credentials(" paulvanderbilt4@hotmail.ca ", "pass123")
      
      expect(validUser).to eq(user)
    end

    it 'should log the user in even if the email is typed with a different case' do

      user = User.new(
        username: 'user',
        email: 'paulvanderbilt4@hotmail.ca',
        password: 'pass123',
        password_confirmation: 'pass123'
      )

      user.save
      
      validUser = User.authenticate_with_credentials("PaulVanderbilt4@hotmail.ca", "pass123")
      
      expect(validUser).to eq(user)
    end

  end


end