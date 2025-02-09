class Education < ApplicationRecord
  belongs_to :section

  def move_up
    up_education = self.section.educations.find_by(position: self.position - 1 )
    if up_education.present?
      self.update(position: self.position - 1)
      up_education.update(position: up_education.position + 1)
    end
  end

  def move_down
    down_education = self.section.educations.find_by(position: self.position + 1 )
    if down_education.present?
      self.update(position: self.position + 1)
      down_education.update(position: down_education.position - 1)
    end
  end
end
