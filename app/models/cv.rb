class Cv < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_one_attached :main_photo

  enum sex: {
    unspecified: 0,
    male: 1,
    female: 2
  }
  SEXES = sexes.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_sexes
    SEXES
  end

  def self.get_human_sexes
    SEXES.to_h { |k, _v| [Cv.human_enum_name(:sexes, k), k] }
  end

  def get_available_human_names
    section_list = sections.pluck(:name).map(&:to_sym)
    section_list.delete(:custom_section)
    Section.get_human_names.reject { |_, v| section_list.include? v }
  end

end
