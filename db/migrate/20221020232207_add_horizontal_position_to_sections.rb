class AddHorizontalPositionToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :horizontal_position, :integer, default: 0, null: false
    rename_column :sections, :position, :vertical_position
  end
end
