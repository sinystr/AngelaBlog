require 'spec_helper'

RSpec.describe User do
  describe '#admin?' do
    it 'is true when the user rank is 1' do
      user = create :user, rank: 1
      expect(user).to be_admin
    end

    it 'is false when the rank is less than 1' do
      user = create :user, rank: 0
      expect(user).to_not be_admin
    end

    it 'is false when the rank is not set' do
      user = create :user, rank: nil
      expect(user).to_not be_admin
    end
  end
end
