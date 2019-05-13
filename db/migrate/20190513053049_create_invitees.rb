class CreateInvitees < ActiveRecord::Migration[5.2]
  def change
    create_table :invitees do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :rsvp
      t.timestamps
    end
  end
end
