require 'rails_helper'

RSpec.describe Cv, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many sections' do
      association = described_class.reflect_on_association(:sections)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'requires a name' do
      cv = build(:cv, name: nil)

      expect(cv).not_to be_valid
      expect(cv.errors[:name]).to be_present
    end
  end

  describe 'enums' do
    it 'defines sexes' do
      expect(described_class.sexes.keys).to match_array(%w[unspecified male female])
    end

    it 'defines styles' do
      expect(described_class.styles.keys).to match_array(%w[style1 style2 style3 style4])
    end
  end

  describe '.get_sexes' do
    it 'returns the sex values' do
      expect(described_class.get_sexes).to eq(unspecified: 'unspecified', male: 'male', female: 'female')
    end
  end

  describe '.get_human_sexes' do
    it 'returns translated sex values' do
      expected = {
        I18n.t('activerecord.attributes.cv.sexes.unspecified') => :unspecified,
        I18n.t('activerecord.attributes.cv.sexes.male') => :male,
        I18n.t('activerecord.attributes.cv.sexes.female') => :female
      }

      expect(described_class.get_human_sexes).to eq(expected)
    end
  end

  describe '.get_styles' do
    it 'returns the style values' do
      expect(described_class.get_styles).to eq(
        style1: 'style1',
        style2: 'style2',
        style3: 'style3',
        style4: 'style4'
      )
    end
  end

  describe '.get_human_styles' do
    it 'returns translated style values' do
      expected = described_class.get_styles.transform_keys do |style|
        described_class.human_enum_name(:styles, style)
      end.transform_values(&:to_sym)

      expect(described_class.get_human_styles).to eq(expected)
    end
  end

  describe '#get_available_human_names' do
    it 'excludes already used section names except custom section' do
      cv = create(:cv)
      create(:section, cv: cv, name: :skills_section, vertical_position: 1)
      create(:section, cv: cv, name: :custom_section, vertical_position: 2)

      available = cv.get_available_human_names.values

      expect(available).not_to include(:skills_section)
      expect(available).to include(:custom_section)
    end
  end
end
