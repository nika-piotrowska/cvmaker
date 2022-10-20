class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cvs, dependent: :destroy

  def ability
    @ability ||= Ability.new(self)
  end
end
