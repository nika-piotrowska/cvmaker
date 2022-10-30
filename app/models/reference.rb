class Reference < ApplicationRecord
  belongs_to :section

  has_rich_text :description
end
