class Section < ApplicationRecord
  belongs_to :cv
  has_many :certificates, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :references, dependent: :destroy

  enum name: {
    basic_user: 0,
    coach: 1,
    lead: 4,
    admin: 2,
    super_admin: 3
  }
  NAMES = names.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_names
    NAMES
  end

  def self.get_human_names
    NAMES.to_h { |k, _v| [Section.human_enum_name(:names, k), k] }
  end

end