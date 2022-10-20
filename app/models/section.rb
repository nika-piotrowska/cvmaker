class Section < ApplicationRecord
  belongs_to :cv
  has_many :certificates, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :references, dependent: :destroy

end