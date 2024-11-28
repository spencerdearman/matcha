class CreateCafes < ActiveRecord::Migration[7.1]
  def change
    create_table :cafes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng
      t.text :description

      t.timestamps
    end
  end
end
