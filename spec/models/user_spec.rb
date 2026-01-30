require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many cvs' do
      association = described_class.reflect_on_association(:cvs)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe '#ability' do
    it 'returns an ability instance' do
      user = build(:user)

      expect(user.ability).to be_a(Ability)
    end

    it 'memoizes the ability instance' do
      user = build(:user)

      expect(user.ability).to be(user.ability)
    end
  end
end
