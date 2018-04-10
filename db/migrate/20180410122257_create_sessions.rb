class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions, id: false do |t|
      t.string :encrypted_id, limit: 64, null: false
      t.text :data, null: false

      t.timestamps
    end
  end
end
