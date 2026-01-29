class Reference < ApplicationRecord
  belongs_to :section

  has_rich_text :description

  def move_up
    up_reference = section.references.find_by(position: position - 1)
    if up_reference.present?
      update(position: position - 1)
      up_reference.update(position: up_reference.position + 1)
    end
  end

  def move_down
    down_reference = section.references.find_by(position: position + 1)
    if down_reference.present?
      update(position: position + 1)
      down_reference.update(position: down_reference.position - 1)
    end
  end
end
