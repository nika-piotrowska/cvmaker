class AddNameToCvs < ActiveRecord::Migration[6.0]
  def change
    add_column :cvs, :name, :string, null: false
  end
end
