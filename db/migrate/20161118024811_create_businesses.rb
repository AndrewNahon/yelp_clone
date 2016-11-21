class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :description
      t.string :city
      t.timestamps
    end
  end
end
