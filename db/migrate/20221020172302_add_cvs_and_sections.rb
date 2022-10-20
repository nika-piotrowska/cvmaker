class AddCvsAndSections < ActiveRecord::Migration[6.0]
  def change
    create_table :cvs do |t|
      t.belongs_to :user
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :address
      t.string :drivers_licence
      t.string :linkedin
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :github
      t.string :website
      t.date :birth_date, null: false
      t.integer :sex, default: 0, null: false
      t.timestamps
    end

    create_table :sections do |t|
      t.belongs_to :cv
      t.integer :name, default: 0, null: false
      t.string :custom_name
      t.text :content
      t.integer :position, null: false
      t.timestamps
    end
  end
end
