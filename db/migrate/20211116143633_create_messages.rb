class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :sequential_number, null: false
      t.references :chat, foreign_key: true, null: false
      t.text :body

      t.timestamps
    end
    add_index :messages, [:chat_id, :sequential_number], unique: true
  end
end
