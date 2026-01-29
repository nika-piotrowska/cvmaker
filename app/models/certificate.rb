class Certificate < ApplicationRecord
  belongs_to :section

  has_rich_text :description

  def move_up
    up_certificate = section.certificates.find_by(position: position - 1)
    if up_certificate.present?
      update(position: position - 1)
      up_certificate.update(position: up_certificate.position + 1)
    end
  end

  def move_down
    down_certificate = section.certificates.find_by(position: position + 1)
    if down_certificate.present?
      update(position: position + 1)
      down_certificate.update(position: down_certificate.position - 1)
    end
  end
end
