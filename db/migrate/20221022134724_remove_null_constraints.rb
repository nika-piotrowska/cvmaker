class RemoveNullConstraints < ActiveRecord::Migration[6.0]
  def change
    change_column :certificates, :name, :string, :null => true
    change_column :courses, :name, :string, :null => true
    change_column :courses, :institution, :string, :null => true
    change_column :courses, :start_date, :date, :null => true
    change_column :educations, :level, :string, :null => true
    change_column :educations, :university, :string, :null => true
    change_column :educations, :start_date, :date, :null => true
    change_column :employments, :name, :string, :null => true
    change_column :employments, :employer, :string, :null => true
    change_column :employments, :start_date, :date, :null => true
    change_column :references, :company, :string, :null => true
    change_column :cvs, :first_name, :string, :null => true
    change_column :cvs, :last_name, :string, :null => true
    change_column :cvs, :phone_number, :string, :null => true
    change_column :cvs, :birth_date, :date, :null => true
  end
end
