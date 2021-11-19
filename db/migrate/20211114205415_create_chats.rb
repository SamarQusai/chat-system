class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :sequential_number, null: false
      t.references :application,foreign_key: true, null: false
      t.integer :messages_count, default: 0

      t.timestamps
    end
    add_index :chats, [:application_id, :sequential_number], unique: true
  end
end
