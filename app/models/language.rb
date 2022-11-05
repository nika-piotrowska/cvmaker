class Language < ApplicationRecord
  belongs_to :section

  enum language_level: {
    a1: 0,
    a2: 1,
    b1: 2,
    b2: 3,
    c1: 4,
    c2: 5
  }
  LANGUAGE_LEVELS = language_levels.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_language_levels
    LANGUAGE_LEVELS
  end

  def self.get_human_language_levels
    LANGUAGE_LEVELS.to_h { |k, _v| [Language.human_enum_name(:language_levels, k), k] }
  end

  def self.get_translations_languages_levels
    get_human_language_levels.to_h { |k, v| [v, k] }
  end
end
