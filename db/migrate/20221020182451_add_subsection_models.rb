class AddSubsectionModels < ActiveRecord::Migration[6.0]
  def change
    create_table :employment do |t|
      t.belongs_to :section
      t.string :name, null: false
      t.string :city
      t.string :employer, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.text :description
      t.integer :position, null: false
      t.timestamps
    end

    create_table :education do |t|
      t.belongs_to :section
      t.string :level, null: false
      t.string :city
      t.string :university, null: false
      t.string :faculty
      t.string :specialisation
      t.date :start_date, null: false
      t.date :end_date
      t.integer :position, null: false
      t.timestamps
    end

    create_table :languages do |t|
      t.belongs_to :section
      t.string :language
      t.integer :language_level, default: 0, null: false
      t.integer :position, null: false
      t.timestamps
    end

    create_table :courses do |t|
      t.belongs_to :section
      t.string :name, null: false
      t.string :institution, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.text :description
      t.integer :position, null: false
      t.timestamps
    end

    create_table :references do |t|
      t.belongs_to :section
      t.string :company, null: false
      t.string :contact_person
      t.bigint :phone_number
      t.string :email
      t.text :description
      t.integer :position
      t.timestamps
    end

    create_table :certificates do |t|
      t.belongs_to :section
      t.string :name, null: false
      t.date :date
      t.text :description
      t.integer :position
      t.timestamps
    end
  end
end
