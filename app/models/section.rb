class Section < ApplicationRecord
  belongs_to :cv
  has_many :certificates, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :references, dependent: :destroy

  enum name: {
    certificates_section: 0,
    courses_section: 1,
    educations_section: 2,
    employments_section: 3,
    languages_section: 4,
    references_section: 5,
    skills_section: 6,
    interest_section: 7,
    privacy_policy_sections: 8,
    description_section: 9,
    custom_section: 10
  }
  NAMES = names.to_h { |k, _v| [k.to_sym, k] }.freeze

  enum horizontal_position: {
    main_body: 0,
    side_body: 1
  }
  HORIZONTAL_POSITIONS = horizontal_positions.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_names
    NAMES
  end

  def self.get_horizontal_positions
    HORIZONTAL_POSITIONS
  end

  def self.get_human_names
    NAMES.to_h { |k, _v| [Section.human_enum_name(:names, k), k] }
  end

  def self.get_human_horizontal_positions
    HORIZONTAL_POSITIONS.to_h { |k, _v| [Section.human_enum_name(:horizontal_positions, k), k] }
  end

end
