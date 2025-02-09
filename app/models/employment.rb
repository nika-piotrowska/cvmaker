class Employment < ApplicationRecord
  belongs_to :section

  has_rich_text :description

  def move_up
    up_employment = self.section.employments.find_by(position: self.position - 1 )
    if up_employment.present?
      self.update(position: self.position - 1)
      up_employment.update(position: up_employment.position + 1)
    end
  end

  def move_down
    down_employment = self.section.employments.find_by(position: self.position + 1 )
    if down_employment.present?
      self.update(position: self.position + 1)
      down_employment.update(position: down_employment.position - 1)
    end
  end
end
