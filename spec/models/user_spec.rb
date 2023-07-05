require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be true
    end

    it 'should have matching password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'differentpassword'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have unique email (case-insensitive)' do
      user1 = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user2 = User.new(
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user2.save).to be false
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'should have email, first name, and last name fields required' do
      user = User.new
      user.save
      expect(user.errors.full_messages).to include(
        "Email can't be blank",
        "First name can't be blank",
        "Last name can't be blank"
      )
    end

    it 'should have a minimum password length' do
      user = User.new(
        email: 'test@example.com',
        password: 'short',
        password_confirmation: 'short'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      it 'should authenticate successfully with leading/trailing whitespaces in email' do
        user = User.authenticate_with_credentials('   test@example.com   ', 'password')
        expect(user).to eq(@user)
      end
      
      it 'should authenticate successfully with different cases in email' do
        user = User.authenticate_with_credentials('tEsT@exAMPLe.com', 'password')
        expect(user).to eq(@user)
      end
    end
  
    it 'should return the user instance if authenticated successfully' do
      user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(user).to eq(@user)
    end
  
    it 'should return nil if authentication fails' do
      user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(user).to be_nil
    end
  end
end
