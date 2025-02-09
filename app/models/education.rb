class Education < ApplicationRecord
  belongs_to :section

  def move_up
    up_education = section.educations.find_by(position: position - 1)
    if up_education.present?
      update(position: position - 1)
      up_education.update(position: up_education.position + 1)
    end
  end

  def move_down
    down_education = section.educations.find_by(position: position + 1)
    if down_education.present?
      update(position: position + 1)
      down_education.update(position: down_education.position - 1)
    end
  end
end
