require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { described_class.new(user) }

  context 'when guest user' do
    let(:user) { nil }

    it 'allows managing only a new user record' do
      expect(ability.can?(:manage, User.new)).to be(true)
      expect(ability.can?(:create, Cv)).to be(false)
    end
  end

  context 'when logged in user' do
    let(:user) { create(:user) }

    it 'allows creating cv-related records' do
      expect(ability.can?(:create, Cv)).to be(true)
      expect(ability.can?(:create, Section)).to be(true)
      expect(ability.can?(:create, Certificate)).to be(true)
      expect(ability.can?(:create, Course)).to be(true)
      expect(ability.can?(:create, Education)).to be(true)
      expect(ability.can?(:create, Employment)).to be(true)
      expect(ability.can?(:create, Language)).to be(true)
      expect(ability.can?(:create, Reference)).to be(true)
    end

    it 'allows managing owned records' do
      cv = create(:cv, user: user)
      section = create(:section, cv: cv)
      certificate = create(:certificate, section: section)
      course = create(:course, section: section)
      education = create(:education, section: section)
      employment = create(:employment, section: section)
      language = create(:language, section: section)
      reference = create(:reference, section: section)

      expect(ability.can?(:manage, cv)).to be(true)
      expect(ability.can?(:manage, section)).to be(true)
      expect(ability.can?(:manage, certificate)).to be(true)
      expect(ability.can?(:manage, course)).to be(true)
      expect(ability.can?(:manage, education)).to be(true)
      expect(ability.can?(:manage, employment)).to be(true)
      expect(ability.can?(:manage, language)).to be(true)
      expect(ability.can?(:manage, reference)).to be(true)
    end
  end
end
