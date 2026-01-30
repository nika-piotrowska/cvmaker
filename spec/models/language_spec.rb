require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'associations' do
    it 'belongs to section' do
      association = described_class.reflect_on_association(:section)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'enums' do
    it 'defines language levels' do
      expect(described_class.language_levels.keys).to match_array(%w[a1 a2 b1 b2 c1 c2])
    end
  end

  describe '.get_language_levels' do
    it 'returns the language level values' do
      expect(described_class.get_language_levels[:a1]).to eq('a1')
    end
  end

  describe '.get_human_language_levels' do
    it 'returns translated language levels' do
      expected = described_class.get_language_levels.transform_keys do |level|
        described_class.human_enum_name(:language_levels, level)
      end.transform_values(&:to_sym)

      expect(described_class.get_human_language_levels).to eq(expected)
    end
  end

  describe '.get_translations_languages_levels' do
    it 'inverts the human language levels hash' do
      translations = described_class.get_translations_languages_levels

      expect(translations).to include(a1: described_class.human_enum_name(:language_levels, :a1))
    end
  end

  describe '#move_up' do
    it 'swaps position with the language above' do
      section = create(:section)
      top = create(:language, section: section, position: 1)
      lower = create(:language, section: section, position: 2)

      lower.move_up

      expect(lower.reload.position).to eq(1)
      expect(top.reload.position).to eq(2)
    end

    it 'does nothing when already at the top' do
      section = create(:section)
      language = create(:language, section: section, position: 1)

      expect { language.move_up }.not_to change(language, :position)
    end
  end

  describe '#move_down' do
    it 'swaps position with the language below' do
      section = create(:section)
      top = create(:language, section: section, position: 1)
      lower = create(:language, section: section, position: 2)

      top.move_down

      expect(top.reload.position).to eq(2)
      expect(lower.reload.position).to eq(1)
    end

    it 'does nothing when already at the bottom' do
      section = create(:section)
      language = create(:language, section: section, position: 1)

      expect { language.move_down }.not_to change(language, :position)
    end
  end
end
