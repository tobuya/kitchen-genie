require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:foods) }
    it { should have_many(:recipes) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'database_authenticatable' do
    it 'should be valid with a valid email and password' do
      user = User.create(email: 'test@example.com', password: 'password')
      expect(user.valid_password?('password')).to eq(true)
    end

    it 'should not be valid with an incorrect password' do
      user = User.create(email: 'test@example.com', password: 'password')
      expect(user.valid_password?('wrong_password')).to eq(false)
    end
  end
end
