class Cv < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_one_attached :main_photo

  enum sex: {
    male: 0,
    female: 1
  }
  SEXES = sexes.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_sexes
    SEXES
  end

  def self.get_human_sexes
    SEXES.to_h { |k, _v| [Cv.human_enum_name(:sexes, k), k] }
  end

end
