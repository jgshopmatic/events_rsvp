class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.timestamps
    end
    add_index :users, %i[username email]
  end
end
