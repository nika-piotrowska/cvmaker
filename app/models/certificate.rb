class Certificate < ApplicationRecord
  belongs_to :section

  has_rich_text :description
end
