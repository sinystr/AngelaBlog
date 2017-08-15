require 'spec_helper'

RSpec.describe User do
  describe '#admin?' do
    it 'is true when the user rank is 1' do
      user = User.new email: 'test@test.com',
                      name: 'test',
                      password: '1234',
                      password_salt: '1234',
                      rank: 1

      expect(user).to be_admin
    end

    it 'is false when the rank is less than 1' do
      user = User.new email: 'test@test.com',
                      name: 'test',
                      password: '1234',
                      password_salt: '1234',
                      rank: 0
      
      expect(user).to_not be_admin
    end

    it 'is false when the rank is not set' do
      user = User.new email: 'test@test.com',
                      name: 'test',
                      password: '1234',
                      password_salt: '1234'

      expect(user).to_not be_admin
    end
  end
end
