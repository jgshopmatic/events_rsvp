class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day
      t.integer :created_by
      t.integer :status
      t.timestamps
    end
  end
end
