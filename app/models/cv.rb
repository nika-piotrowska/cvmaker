class Cv < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_one_attached :main_photo

end
