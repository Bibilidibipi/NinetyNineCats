class AddToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, index: true, references: :users
  end
end
