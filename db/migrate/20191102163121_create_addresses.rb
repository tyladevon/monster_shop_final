class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :nickname
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.bigint "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_addresses_on_user_id"
    end
  end
end
