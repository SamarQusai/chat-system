class ChangeBodyOnMessages < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :body, :integer, :null => false
  end
end
