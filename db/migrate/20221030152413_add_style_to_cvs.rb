class AddStyleToCvs < ActiveRecord::Migration[6.0]
  def change
    add_column :cvs, :style, :integer, default: 0, null: false
  end
end
