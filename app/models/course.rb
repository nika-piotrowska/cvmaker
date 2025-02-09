class Course < ApplicationRecord
  belongs_to :section

  has_rich_text :description

  def move_up
    up_course = self.section.courses.find_by(position: self.position - 1 )
    if up_course.present?
      self.update(position: self.position - 1)
      up_course.update(position: up_course.position + 1)
    end
  end

  def move_down
    down_course = self.section.courses.find_by(position: self.position + 1 )
    if down_course.present?
      self.update(position: self.position + 1)
      down_course.update(position: down_course.position - 1)
    end
  end

end
